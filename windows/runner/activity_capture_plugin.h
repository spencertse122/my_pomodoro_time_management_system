#ifndef RUNNER_ACTIVITY_CAPTURE_PLUGIN_H_
#define RUNNER_ACTIVITY_CAPTURE_PLUGIN_H_

#include <flutter/binary_messenger.h>
#include <flutter/encodable_value.h>
#include <flutter/method_channel.h>

#include <memory>

// Returns a method channel that must be retained for the lifetime of the engine.
// |session_locked| is owned by the runner window and updated from WTS messages.
std::unique_ptr<flutter::MethodChannel<flutter::EncodableValue>>
RegisterActivityCaptureChannel(flutter::BinaryMessenger* messenger,
                               const bool* session_locked);

bool IsCurrentSessionLocked();

#endif  // RUNNER_ACTIVITY_CAPTURE_PLUGIN_H_
