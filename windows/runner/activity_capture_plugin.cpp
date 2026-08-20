#include "activity_capture_plugin.h"

#include <windows.h>
#include <wincodec.h>
#include <wrl/client.h>
#include <wtsapi32.h>

#include <algorithm>
#include <chrono>
#include <cstdint>
#include <optional>
#include <string>
#include <vector>

#include <flutter/standard_method_codec.h>

#include "utils.h"

namespace {

using flutter::EncodableList;
using flutter::EncodableMap;
using flutter::EncodableValue;
using Microsoft::WRL::ComPtr;

constexpr char kActivityCaptureChannel[] = "focus_flow/activity_capture";
constexpr wchar_t kPrivacyRegistryKey[] = L"Software\\FocusFlow\\Privacy";
constexpr wchar_t kCaptureConsentValue[] = L"ActivityCaptureConsent";
constexpr wchar_t kRunRegistryKey[] =
    L"Software\\Microsoft\\Windows\\CurrentVersion\\Run";
constexpr wchar_t kRunValueName[] = L"FocusFlow";
constexpr ULONGLONG kDefaultIdleMilliseconds = 5ULL * 60ULL * 1000ULL;

void Put(EncodableMap* map, const char* key, EncodableValue value) {
  map->insert_or_assign(EncodableValue(key), std::move(value));
}

int64_t CurrentTimeMilliseconds() {
  return std::chrono::duration_cast<std::chrono::milliseconds>(
             std::chrono::system_clock::now().time_since_epoch())
      .count();
}

std::string CaptureConsentStatus() {
  DWORD consent = 0;
  DWORD size = sizeof(consent);
  const LSTATUS status = RegGetValueW(
      HKEY_CURRENT_USER, kPrivacyRegistryKey, kCaptureConsentValue,
      RRF_RT_REG_DWORD, nullptr, &consent, &size);
  if (status == ERROR_FILE_NOT_FOUND || status == ERROR_PATH_NOT_FOUND) {
    return "notDetermined";
  }
  if (status != ERROR_SUCCESS) {
    return "restricted";
  }
  return consent == 1 ? "granted" : "denied";
}

bool GrantCaptureConsent() {
  HKEY key = nullptr;
  DWORD disposition = 0;
  const LSTATUS create_status = RegCreateKeyExW(
      HKEY_CURRENT_USER, kPrivacyRegistryKey, 0, nullptr, 0, KEY_SET_VALUE,
      nullptr, &key, &disposition);
  if (create_status != ERROR_SUCCESS) {
    return false;
  }
  const DWORD consent = 1;
  const LSTATUS write_status = RegSetValueExW(
      key, kCaptureConsentValue, 0, REG_DWORD,
      reinterpret_cast<const BYTE*>(&consent), sizeof(consent));
  RegCloseKey(key);
  return write_status == ERROR_SUCCESS;
}

std::wstring ForegroundWindowTitle(HWND window) {
  const int length = GetWindowTextLengthW(window);
  if (length <= 0) {
    return std::wstring();
  }
  std::vector<wchar_t> buffer(static_cast<size_t>(length) + 1);
  const int copied = GetWindowTextW(window, buffer.data(),
                                    static_cast<int>(buffer.size()));
  return copied > 0 ? std::wstring(buffer.data(), copied) : std::wstring();
}

std::wstring ProcessName(DWORD process_id) {
  HANDLE process = OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION, FALSE,
                               process_id);
  if (process == nullptr) {
    return L"Unknown application";
  }
  std::vector<wchar_t> path(32768);
  DWORD length = static_cast<DWORD>(path.size());
  const BOOL queried =
      QueryFullProcessImageNameW(process, 0, path.data(), &length);
  CloseHandle(process);
  if (!queried || length == 0) {
    return L"Unknown application";
  }
  const std::wstring full_path(path.data(), length);
  const size_t separator = full_path.find_last_of(L"\\/");
  return separator == std::wstring::npos ? full_path
                                         : full_path.substr(separator + 1);
}

EncodableMap ActivitySnapshot(bool session_locked) {
  LASTINPUTINFO last_input{};
  last_input.cbSize = sizeof(last_input);
  // DWORD subtraction intentionally preserves GetTickCount's wraparound.
  const DWORD idle_milliseconds = GetLastInputInfo(&last_input)
      ? GetTickCount() - last_input.dwTime
      : 0;
  const bool locked = session_locked || IsCurrentSessionLocked();

  EncodableMap snapshot;
  Put(&snapshot, "capturedAtMilliseconds",
      EncodableValue(CurrentTimeMilliseconds()));
  Put(&snapshot, "idleMilliseconds",
      EncodableValue(static_cast<int64_t>(idle_milliseconds)));
  Put(&snapshot, "isIdle",
      EncodableValue(idle_milliseconds >= kDefaultIdleMilliseconds));
  Put(&snapshot, "isLocked", EncodableValue(locked));

  const HWND foreground = locked ? nullptr : GetForegroundWindow();
  if (foreground != nullptr) {
    DWORD process_id = 0;
    GetWindowThreadProcessId(foreground, &process_id);
    EncodableMap application;
    const std::wstring process_name = ProcessName(process_id);
    const std::string process_name_utf8 = Utf8FromUtf16(process_name.c_str());
    Put(&application, "name", EncodableValue(process_name_utf8));
    Put(&application, "identifier", EncodableValue(process_name_utf8));
    Put(&application, "processId",
        EncodableValue(static_cast<int64_t>(process_id)));
    const std::wstring title = ForegroundWindowTitle(foreground);
    if (!title.empty()) {
      Put(&application, "windowTitle",
          EncodableValue(Utf8FromUtf16(title.c_str())));
    }
    snapshot.insert_or_assign(EncodableValue("foregroundApplication"),
                              EncodableValue(std::move(application)));
  }
  return snapshot;
}

struct DisplayMonitor {
  HMONITOR handle;
  RECT bounds;
  std::wstring device_name;
};

BOOL CALLBACK CollectDisplayMonitor(HMONITOR monitor, HDC, LPRECT,
                                    LPARAM context) {
  auto* displays = reinterpret_cast<std::vector<DisplayMonitor>*>(context);
  MONITORINFOEXW info{};
  info.cbSize = sizeof(info);
  if (GetMonitorInfoW(monitor, &info)) {
    displays->push_back({monitor, info.rcMonitor, info.szDevice});
  }
  return TRUE;
}

double DisplayScaleFactor(HMONITOR monitor) {
  HMODULE shcore = LoadLibraryW(L"Shcore.dll");
  if (shcore == nullptr) {
    return 1.0;
  }
  using GetDpiForMonitorFunction = HRESULT(WINAPI*)(HMONITOR, int, UINT*, UINT*);
  const auto get_dpi_for_monitor = reinterpret_cast<GetDpiForMonitorFunction>(
      GetProcAddress(shcore, "GetDpiForMonitor"));
  UINT dpi_x = 96;
  UINT dpi_y = 96;
  if (get_dpi_for_monitor == nullptr ||
      FAILED(get_dpi_for_monitor(monitor, 0, &dpi_x, &dpi_y))) {
    dpi_x = 96;
  }
  FreeLibrary(shcore);
  return std::max(1.0, static_cast<double>(dpi_x) / 96.0);
}

bool EncodeBitmapAsPng(HBITMAP bitmap, UINT width, UINT height,
                       std::vector<uint8_t>* png_bytes) {
  ComPtr<IWICImagingFactory> factory;
  if (FAILED(CoCreateInstance(CLSID_WICImagingFactory, nullptr,
                              CLSCTX_INPROC_SERVER, IID_PPV_ARGS(&factory)))) {
    return false;
  }

  ComPtr<IWICBitmap> source;
  if (FAILED(factory->CreateBitmapFromHBITMAP(
          bitmap, nullptr, WICBitmapIgnoreAlpha, &source))) {
    return false;
  }

  IStream* raw_stream = nullptr;
  if (FAILED(CreateStreamOnHGlobal(nullptr, TRUE, &raw_stream))) {
    return false;
  }
  ComPtr<IStream> stream;
  stream.Attach(raw_stream);

  ComPtr<IWICBitmapEncoder> encoder;
  if (FAILED(factory->CreateEncoder(GUID_ContainerFormatPng, nullptr,
                                    &encoder)) ||
      FAILED(encoder->Initialize(stream.Get(), WICBitmapEncoderNoCache))) {
    return false;
  }

  ComPtr<IWICBitmapFrameEncode> frame;
  ComPtr<IPropertyBag2> properties;
  if (FAILED(encoder->CreateNewFrame(&frame, &properties)) ||
      FAILED(frame->Initialize(properties.Get())) ||
      FAILED(frame->SetSize(width, height))) {
    return false;
  }
  WICPixelFormatGUID pixel_format = GUID_WICPixelFormat32bppBGRA;
  if (FAILED(frame->SetPixelFormat(&pixel_format)) ||
      FAILED(frame->WriteSource(source.Get(), nullptr)) ||
      FAILED(frame->Commit()) || FAILED(encoder->Commit())) {
    return false;
  }

  HGLOBAL memory = nullptr;
  if (FAILED(GetHGlobalFromStream(stream.Get(), &memory)) || memory == nullptr) {
    return false;
  }
  const SIZE_T size = GlobalSize(memory);
  const void* bytes = GlobalLock(memory);
  if (bytes == nullptr || size == 0) {
    if (bytes != nullptr) {
      GlobalUnlock(memory);
    }
    return false;
  }
  const auto* begin = static_cast<const uint8_t*>(bytes);
  png_bytes->assign(begin, begin + size);
  GlobalUnlock(memory);
  return true;
}

bool CaptureDisplay(const DisplayMonitor& display, EncodableMap* payload) {
  const int width = display.bounds.right - display.bounds.left;
  const int height = display.bounds.bottom - display.bounds.top;
  if (width <= 0 || height <= 0) {
    return false;
  }

  HDC screen = GetDC(nullptr);
  HDC memory = screen == nullptr ? nullptr : CreateCompatibleDC(screen);
  HBITMAP bitmap =
      memory == nullptr ? nullptr : CreateCompatibleBitmap(screen, width, height);
  HGDIOBJ previous = bitmap == nullptr ? nullptr : SelectObject(memory, bitmap);
  const BOOL copied = bitmap != nullptr &&
      BitBlt(memory, 0, 0, width, height, screen, display.bounds.left,
             display.bounds.top, SRCCOPY | CAPTUREBLT);

  std::vector<uint8_t> png_bytes;
  const bool encoded = copied &&
      EncodeBitmapAsPng(bitmap, static_cast<UINT>(width),
                        static_cast<UINT>(height), &png_bytes);
  if (previous != nullptr) {
    SelectObject(memory, previous);
  }
  if (bitmap != nullptr) {
    DeleteObject(bitmap);
  }
  if (memory != nullptr) {
    DeleteDC(memory);
  }
  if (screen != nullptr) {
    ReleaseDC(nullptr, screen);
  }
  if (!encoded) {
    return false;
  }

  Put(payload, "id",
      EncodableValue(Utf8FromUtf16(display.device_name.c_str())));
  Put(payload, "width", EncodableValue(width));
  Put(payload, "height", EncodableValue(height));
  Put(payload, "scaleFactor",
      EncodableValue(DisplayScaleFactor(display.handle)));
  Put(payload, "pngBytes", EncodableValue(std::move(png_bytes)));
  return true;
}

std::optional<EncodableList> CaptureAllDisplays() {
  std::vector<DisplayMonitor> displays;
  if (!EnumDisplayMonitors(nullptr, nullptr, CollectDisplayMonitor,
                           reinterpret_cast<LPARAM>(&displays)) ||
      displays.empty()) {
    return std::nullopt;
  }

  EncodableList captured;
  captured.reserve(displays.size());
  for (const auto& display : displays) {
    EncodableMap payload;
    if (!CaptureDisplay(display, &payload)) {
      return std::nullopt;
    }
    captured.emplace_back(std::move(payload));
  }
  return captured;
}

std::wstring CurrentExecutablePath() {
  std::vector<wchar_t> path(32768);
  const DWORD copied =
      GetModuleFileNameW(nullptr, path.data(), static_cast<DWORD>(path.size()));
  return copied > 0 && copied < path.size()
      ? std::wstring(path.data(), copied)
      : std::wstring();
}

bool IsLaunchAtLoginEnabled() {
  DWORD type = 0;
  DWORD size = 0;
  const LSTATUS status = RegGetValueW(
      HKEY_CURRENT_USER, kRunRegistryKey, kRunValueName, RRF_RT_REG_SZ, &type,
      nullptr, &size);
  return status == ERROR_SUCCESS && size > sizeof(wchar_t);
}

bool SetLaunchAtLogin(bool enabled) {
  HKEY key = nullptr;
  DWORD disposition = 0;
  const LSTATUS create_status = RegCreateKeyExW(
      HKEY_CURRENT_USER, kRunRegistryKey, 0, nullptr, 0, KEY_SET_VALUE, nullptr,
      &key, &disposition);
  if (create_status != ERROR_SUCCESS) {
    return false;
  }

  LSTATUS status = ERROR_SUCCESS;
  if (enabled) {
    const std::wstring executable = CurrentExecutablePath();
    if (executable.empty()) {
      RegCloseKey(key);
      return false;
    }
    const std::wstring command = L"\\\"" + executable + L"\\\"";
    status = RegSetValueExW(
        key, kRunValueName, 0, REG_SZ,
        reinterpret_cast<const BYTE*>(command.c_str()),
        static_cast<DWORD>((command.size() + 1) * sizeof(wchar_t)));
  } else {
    status = RegDeleteValueW(key, kRunValueName);
    if (status == ERROR_FILE_NOT_FOUND) {
      status = ERROR_SUCCESS;
    }
  }
  RegCloseKey(key);
  return status == ERROR_SUCCESS;
}

}  // namespace

bool IsCurrentSessionLocked() {
  LPWSTR state_buffer = nullptr;
  DWORD byte_count = 0;
  if (!WTSQuerySessionInformationW(
          WTS_CURRENT_SERVER_HANDLE, WTS_CURRENT_SESSION, WTSConnectState,
          &state_buffer, &byte_count) ||
      state_buffer == nullptr || byte_count < sizeof(WTS_CONNECTSTATE_CLASS)) {
    if (state_buffer != nullptr) {
      WTSFreeMemory(state_buffer);
    }
    return GetForegroundWindow() == nullptr;
  }
  const auto state = *reinterpret_cast<WTS_CONNECTSTATE_CLASS*>(state_buffer);
  WTSFreeMemory(state_buffer);
  return state != WTSActive;
}

std::unique_ptr<flutter::MethodChannel<flutter::EncodableValue>>
RegisterActivityCaptureChannel(flutter::BinaryMessenger* messenger,
                               const bool* session_locked) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          messenger, kActivityCaptureChannel,
          &flutter::StandardMethodCodec::GetInstance());
  channel->SetMethodCallHandler(
      [session_locked](const auto& call, auto result) {
        const std::string& method = call.method_name();
        if (method == "permissionStatus") {
          result->Success(EncodableValue(CaptureConsentStatus()));
          return;
        }
        if (method == "requestPermission") {
          if (!GrantCaptureConsent()) {
            result->Error("permission-store-failed",
                          "Could not save local activity capture consent.");
          } else {
            result->Success(EncodableValue("granted"));
          }
          return;
        }
        if (method == "getActivitySnapshot") {
          result->Success(
              EncodableValue(ActivitySnapshot(*session_locked)));
          return;
        }
        if (method == "captureDisplays") {
          if (CaptureConsentStatus() != "granted") {
            result->Error("permission-denied",
                          "Activity capture consent is required.");
            return;
          }
          auto displays = CaptureAllDisplays();
          if (!displays.has_value()) {
            result->Error(
                "capture-failed",
                "One or more connected displays could not be captured.");
          } else {
            result->Success(EncodableValue(std::move(displays.value())));
          }
          return;
        }
        if (method == "setLaunchAtLogin") {
          const auto* arguments =
              std::get_if<EncodableMap>(call.arguments());
          if (arguments == nullptr) {
            result->Error("invalid-arguments",
                          "setLaunchAtLogin requires an enabled boolean.");
            return;
          }
          const auto iterator = arguments->find(EncodableValue("enabled"));
          const bool* enabled = iterator == arguments->end()
                                    ? nullptr
                                    : std::get_if<bool>(&iterator->second);
          if (enabled == nullptr) {
            result->Error("invalid-arguments",
                          "setLaunchAtLogin requires an enabled boolean.");
          } else if (!SetLaunchAtLogin(*enabled)) {
            result->Error(
                "launch-at-login-failed",
                "Could not update the current user's login entry.");
          } else {
            result->Success(EncodableValue(IsLaunchAtLoginEnabled()));
          }
          return;
        }
        if (method == "isLaunchAtLoginEnabled") {
          result->Success(EncodableValue(IsLaunchAtLoginEnabled()));
          return;
        }
        result->NotImplemented();
      });
  return channel;
}
