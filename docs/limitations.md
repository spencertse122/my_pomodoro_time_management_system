# Validation limits and external dependencies

The repository can verify Dart behavior, privacy boundaries, encrypted storage,
prompt/schema handling, controller behavior, and source formatting on any
supported Flutter development host. Several production claims require systems
that are intentionally outside this repository.

## Requires target hardware

- macOS ScreenCaptureKit permission prompts, multi-display capture, Keychain,
  launch-at-login registration, Apple Silicon inference, code signing,
  notarization, Gatekeeper, DMG installation, sleep/lock transitions, and tray
  lifecycle.
- Windows 11 foreground-window metadata, WTS lock notifications, multi-monitor
  GDI/WIC capture including DPI/scaling layouts, Credential Manager, Run-key
  launch-at-login, local inference, Authenticode, SmartScreen reputation, Inno
  Setup installation, sleep/lock transitions, and tray lifecycle.
- Representative 16 GB machines for inference latency, memory pressure, thermal
  behavior, and capture cadence tuning.

## Requires publisher-controlled services

- Authorized Gemma model artifacts, accepted redistribution terms, and pinned
  SHA-256 digests.
- Apple Developer ID/notarization credentials and a Windows code-signing
  certificate.
- Deployed restrictive Firestore rules before the legacy purge UI is released.
- Optional HTTPS update-feed and aggregate-diagnostics services. The app remains
  functional without either endpoint.
- Disposable Firebase test accounts for the real authentication integration
  test. Unit tests do not contact Firebase.

Development builds intentionally omit model weights from Git and degrade to
metadata-only tracking. Linux desktop is not configured or shipped in v2.
