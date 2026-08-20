import Cocoa
import CoreImage
import CoreMedia
import CoreVideo
import FlutterMacOS
import ScreenCaptureKit
import ServiceManagement

class MainFlutterWindow: NSWindow {
  private var activityCaptureChannel: FlutterMethodChannel?

  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)
    registerActivityCaptureChannel(
      messenger: flutterViewController.engine.binaryMessenger
    )

    super.awakeFromNib()
  }

  private func registerActivityCaptureChannel(messenger: FlutterBinaryMessenger) {
    let channel = FlutterMethodChannel(
      name: "focus_flow/activity_capture",
      binaryMessenger: messenger
    )
    channel.setMethodCallHandler { [weak self] call, result in
      guard let self else {
        result(
          FlutterError(
            code: "unavailable",
            message: "The activity capture host is no longer available.",
            details: nil
          )
        )
        return
      }
      self.handleActivityCapture(call: call, result: result)
    }
    activityCaptureChannel = channel
  }

  private func handleActivityCapture(
    call: FlutterMethodCall,
    result: @escaping FlutterResult
  ) {
    guard #available(macOS 13.0, *) else {
      if call.method == "permissionStatus" || call.method == "requestPermission" {
        result("unsupported")
      } else {
        result(
          FlutterError(
            code: "unsupported",
            message: "Activity capture requires macOS 13 or later.",
            details: nil
          )
        )
      }
      return
    }

    switch call.method {
    case "permissionStatus":
      result(screenCapturePermissionStatus())
    case "requestPermission":
      UserDefaults.standard.set(
        true,
        forKey: ActivityCaptureConstants.didRequestPermissionKey
      )
      result(CGRequestScreenCaptureAccess() ? "granted" : "denied")
    case "getActivitySnapshot":
      result(activitySnapshot())
    case "captureDisplays":
      guard !screenIsLocked() else {
        result(
          FlutterError(
            code: "session-locked",
            message: "Display capture is unavailable while the session is locked.",
            details: nil
          )
        )
        return
      }
      guard CGPreflightScreenCaptureAccess() else {
        result(
          FlutterError(
            code: "permission-denied",
            message: "Screen Recording permission is required to capture displays.",
            details: nil
          )
        )
        return
      }
      Task { [weak self] in
        do {
          let displays = try await self?.captureAllDisplays() ?? []
          DispatchQueue.main.async { result(displays) }
        } catch {
          DispatchQueue.main.async {
            switch error {
            case ActivityCaptureError.sessionLocked:
              result(
                FlutterError(
                  code: "session-locked",
                  message: "Display capture stopped because the session locked.",
                  details: nil
                )
              )
            default:
              result(
                FlutterError(
                  code: "capture-failed",
                  message: "Display capture failed.",
                  details: nil
                )
              )
            }
          }
        }
      }
    case "setLaunchAtLogin":
      guard
        let arguments = call.arguments as? [String: Any],
        let enabled = arguments["enabled"] as? Bool
      else {
        result(
          FlutterError(
            code: "invalid-arguments",
            message: "setLaunchAtLogin requires an enabled boolean.",
            details: nil
          )
        )
        return
      }
      do {
        let service = SMAppService.mainApp
        if enabled {
          switch service.status {
          case .enabled:
            break
          case .requiresApproval:
            SMAppService.openSystemSettingsLoginItems()
          case .notRegistered:
            try service.register()
            if service.status == .requiresApproval {
              SMAppService.openSystemSettingsLoginItems()
            }
          case .notFound:
            result(
              FlutterError(
                code: "launch-at-login-unavailable",
                message: "macOS could not find the main application login item.",
                details: nil
              )
            )
            return
          @unknown default:
            result(
              FlutterError(
                code: "launch-at-login-unavailable",
                message: "macOS returned an unknown login-item status.",
                details: nil
              )
            )
            return
          }
        } else {
          switch service.status {
          case .enabled, .requiresApproval:
            try service.unregister()
          case .notRegistered, .notFound:
            break
          @unknown default:
            result(
              FlutterError(
                code: "launch-at-login-unavailable",
                message: "macOS returned an unknown login-item status.",
                details: nil
              )
            )
            return
          }
        }
        result(service.status == .enabled)
      } catch {
        result(
          FlutterError(
            code: "launch-at-login-failed",
            message: "Could not update the login item.",
            details: String(describing: error)
          )
        )
      }
    case "isLaunchAtLoginEnabled":
      result(SMAppService.mainApp.status == .enabled)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  @available(macOS 13.0, *)
  private func screenCapturePermissionStatus() -> String {
    if CGPreflightScreenCaptureAccess() {
      return "granted"
    }
    return UserDefaults.standard.bool(
      forKey: ActivityCaptureConstants.didRequestPermissionKey
    ) ? "denied" : "notDetermined"
  }

  @available(macOS 13.0, *)
  private func activitySnapshot() -> [String: Any] {
    // kCGAnyInputEventType is a C macro rather than a CGEventType case, so it
    // must be represented by its documented all-bits-set token in Swift.
    let anyInputEvent = CGEventType(rawValue: UInt32.max)!
    let idleSeconds = CGEventSource.secondsSinceLastEventType(
      .combinedSessionState,
      eventType: anyInputEvent
    )
    let safeIdleSeconds = idleSeconds.isFinite ? max(0, idleSeconds) : 0
    let isLocked = screenIsLocked()
    var payload: [String: Any] = [
      "capturedAtMilliseconds": Int64(Date().timeIntervalSince1970 * 1_000),
      "idleMilliseconds": Int64(safeIdleSeconds * 1_000),
      "isIdle": safeIdleSeconds >= ActivityCaptureConstants.defaultIdleSeconds,
      "isLocked": isLocked,
    ]

    if !isLocked, let application = NSWorkspace.shared.frontmostApplication {
      var metadata: [String: Any] = [
        "name": application.localizedName ?? "Unknown application",
        "processId": Int64(application.processIdentifier),
      ]
      if let identifier = application.bundleIdentifier {
        metadata["identifier"] = identifier
      }
      if CGPreflightScreenCaptureAccess(),
        let title = foregroundWindowTitle(processId: application.processIdentifier)
      {
        metadata["windowTitle"] = title
      }
      payload["foregroundApplication"] = metadata
    }
    return payload
  }

  @available(macOS 13.0, *)
  private func screenIsLocked() -> Bool {
    guard let session = CGSessionCopyCurrentDictionary() as? [String: Any] else {
      // Treat an unreadable session state as locked so pixel capture fails
      // closed instead of guessing that private content is available.
      return true
    }
    guard let isLocked = session["CGSSessionScreenIsLocked"] as? Bool else {
      return true
    }
    return isLocked
  }

  @available(macOS 13.0, *)
  private func foregroundWindowTitle(processId: pid_t) -> String? {
    let options: CGWindowListOption = [.optionOnScreenOnly, .excludeDesktopElements]
    guard
      let windows = CGWindowListCopyWindowInfo(options, kCGNullWindowID)
        as? [[String: Any]]
    else {
      return nil
    }

    return windows.first { window in
      let ownerPid = (window[kCGWindowOwnerPID as String] as? NSNumber)?.int32Value
      let layer = (window[kCGWindowLayer as String] as? NSNumber)?.intValue
      return ownerPid == processId && layer == 0
    }.flatMap { window in
      guard let title = window[kCGWindowName as String] as? String, !title.isEmpty else {
        return nil
      }
      return title
    }
  }

  @available(macOS 13.0, *)
  private func captureAllDisplays() async throws -> [[String: Any]] {
    let content = try await SCShareableContent.excludingDesktopWindows(
      false,
      onScreenWindowsOnly: true
    )
    guard !content.displays.isEmpty else {
      throw ActivityCaptureError.noDisplays
    }

    var payloads: [[String: Any]] = []
    payloads.reserveCapacity(content.displays.count)
    let ownBundleIdentifier = Bundle.main.bundleIdentifier
    let excludedApplications = content.applications.filter {
      $0.bundleIdentifier == ownBundleIdentifier
    }
    for display in content.displays {
      guard !screenIsLocked() else {
        throw ActivityCaptureError.sessionLocked
      }
      let frameCapture = ScreenCaptureFrame()
      let pngData = try await frameCapture.capture(
        display: display,
        excludingApplications: excludedApplications
      )
      // Lock state can change while ScreenCaptureKit is producing a frame.
      // Discard all payloads instead of analyzing pixels captured across that
      // privacy boundary.
      guard !screenIsLocked() else {
        throw ActivityCaptureError.sessionLocked
      }
      payloads.append([
        "id": String(display.displayID),
        "width": display.width,
        "height": display.height,
        "scaleFactor": backingScaleFactor(displayId: display.displayID),
        "pngBytes": FlutterStandardTypedData(bytes: pngData),
      ])
    }
    return payloads
  }

  @available(macOS 13.0, *)
  private func backingScaleFactor(displayId: CGDirectDisplayID) -> Double {
    let screen = NSScreen.screens.first { screen in
      (screen.deviceDescription[NSDeviceDescriptionKey("NSScreenNumber")]
        as? NSNumber)?.uint32Value == displayId
    }
    return Double(screen?.backingScaleFactor ?? 1.0)
  }
}

private enum ActivityCaptureConstants {
  static let didRequestPermissionKey = "FocusFlowDidRequestScreenCapturePermission"
  static let defaultIdleSeconds: TimeInterval = 5 * 60
}

private enum ActivityCaptureError: LocalizedError {
  case noDisplays
  case pngEncodingFailed
  case sessionLocked
  case timedOut

  var errorDescription: String? {
    switch self {
    case .noDisplays:
      return "No displays are available for capture."
    case .pngEncodingFailed:
      return "The captured frame could not be encoded as PNG."
    case .sessionLocked:
      return "Display capture stopped because the session locked."
    case .timedOut:
      return "ScreenCaptureKit timed out waiting for a frame."
    }
  }
}

@available(macOS 13.0, *)
private final class ScreenCaptureFrame: NSObject, SCStreamOutput {
  private let outputQueue = DispatchQueue(
    label: "com.spencertse.focusflow.screen-capture-frame"
  )
  private let lock = NSLock()
  private var stream: SCStream?
  private var continuation: CheckedContinuation<Data, Error>?

  func capture(
    display: SCDisplay,
    excludingApplications: [SCRunningApplication]
  ) async throws -> Data {
    let configuration = SCStreamConfiguration()
    configuration.width = display.width
    configuration.height = display.height
    configuration.pixelFormat = kCVPixelFormatType_32BGRA
    // ScreenCaptureKit documents three frames as the minimum queue depth.
    // Capture still stops after the first complete frame, so no image persists.
    configuration.queueDepth = 3
    configuration.showsCursor = false
    configuration.capturesAudio = false

    let filter = SCContentFilter(
      display: display,
      excludingApplications: excludingApplications,
      exceptingWindows: []
    )
    let stream = SCStream(filter: filter, configuration: configuration, delegate: nil)
    self.stream = stream
    try stream.addStreamOutput(self, type: .screen, sampleHandlerQueue: outputQueue)

    return try await withCheckedThrowingContinuation { continuation in
      lock.lock()
      self.continuation = continuation
      lock.unlock()

      Task { [weak self] in
        do {
          try await stream.startCapture()
        } catch {
          self?.finish(.failure(error))
        }
      }
      outputQueue.asyncAfter(deadline: .now() + 5) { [weak self] in
        self?.finish(.failure(ActivityCaptureError.timedOut))
      }
    }
  }

  func stream(
    _ stream: SCStream,
    didOutputSampleBuffer sampleBuffer: CMSampleBuffer,
    of outputType: SCStreamOutputType
  ) {
    guard outputType == .screen,
      sampleBuffer.isValid,
      let attachmentsArray = CMSampleBufferGetSampleAttachmentsArray(
        sampleBuffer,
        createIfNecessary: false
      ) as? [[SCStreamFrameInfo: Any]],
      let attachments = attachmentsArray.first,
      let statusRawValue = attachments[SCStreamFrameInfo.status] as? Int,
      let status = SCFrameStatus(rawValue: statusRawValue),
      status == .complete,
      let pixelBuffer = sampleBuffer.imageBuffer
    else {
      return
    }

    let image = CIImage(cvPixelBuffer: pixelBuffer)
    let context = CIContext(options: nil)
    guard
      let cgImage = context.createCGImage(image, from: image.extent),
      let data = NSBitmapImageRep(cgImage: cgImage).representation(
        using: .png,
        properties: [:]
      )
    else {
      finish(.failure(ActivityCaptureError.pngEncodingFailed))
      return
    }
    finish(.success(data))
  }

  private func finish(_ result: Result<Data, Error>) {
    lock.lock()
    guard let continuation = continuation else {
      lock.unlock()
      return
    }
    self.continuation = nil
    let activeStream = stream
    stream = nil
    lock.unlock()

    continuation.resume(with: result)
    Task {
      try? await activeStream?.stopCapture()
    }
  }
}
