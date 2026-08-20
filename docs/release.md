# Release runbook

Focus Flow releases are target-native. The checked-in `release.yml` expects a
self-hosted Apple Silicon macOS runner and a self-hosted Windows x64 runner so
model artifacts and signing keys remain under the publisher's control.

## Required protected configuration

GitHub Actions secrets:

- `GEMMA_MODEL_URL` and `GEMMA_MMPROJ_URL`: authenticated or short-lived HTTPS
  download URLs for the approved GGUF artifacts.
- `GEMMA_MODEL_SHA256` and `GEMMA_MMPROJ_SHA256`: pinned lowercase or uppercase
  SHA-256 digests.
- `MACOS_SIGNING_IDENTITY`, `APPLE_ID`, `APPLE_TEAM_ID`, and
  `APPLE_APP_PASSWORD`: Developer ID and notarization credentials.
- `WINDOWS_CERTIFICATE_PFX` and `WINDOWS_CERTIFICATE_PASSWORD`: base64 PFX and
  password for an Authenticode code-signing certificate.

GitHub Actions variables:

- `FOCUS_FLOW_UPDATE_FEED_URL`: optional HTTPS release-feed URL.
- `FOCUS_FLOW_DIAGNOSTICS_URL`: optional HTTPS aggregate-diagnostics endpoint.

The macOS runner needs Xcode command-line tools. The Windows runner needs Visual
Studio 2022 with Desktop development with C++, Windows SDK signing tools, and
Inno Setup 6. Both need Flutter 3.47.1-compatible host dependencies and GitHub
Actions Runner 2.327.1 or newer for the Node 24-based checkout action.

## Release sequence

1. Confirm the publisher is authorized to redistribute the selected Gemma
   artifacts and has accepted the current Gemma Terms of Use.
2. Pin artifact URLs and SHA-256 digests in protected repository settings.
3. Deploy `firestore.rules` and verify a signed-in owner can read/delete but not
   create/update legacy documents.
4. Run CI and target-native smoke tests, including first-run permission flows,
   multiple displays, sleep/lock/unlock, idle skipping, tray restore/quit,
   launch at login, backup round-trip, and legacy preview/import/purge.
5. Dispatch **Signed desktop release** with an exact semantic version.
6. On clean macOS and Windows machines, verify the published artifact signature,
   install, launch, model availability, local classification, and uninstall.
7. Publish an HTTPS update-feed entry only after both signed artifacts pass
   smoke testing.

## Update-feed contract

The configured endpoint returns a JSON object with a platform-specific entry:

```json
{
  "macos-arm64": {
    "version": "2.0.1",
    "url": "https://downloads.example.com/Focus-Flow-2.0.1.dmg",
    "notes": "Short release notes"
  },
  "windows-x64": {
    "version": "2.0.1",
    "url": "https://downloads.example.com/Focus-Flow-2.0.1.exe",
    "notes": "Short release notes"
  }
}
```

The app presents the HTTPS link; it does not silently download or install code.
The operating system's signed-installer checks remain the trust boundary.

## Diagnostics contract

When a user leaves diagnostics enabled and the endpoint is configured, the app
sends one JSON object containing `schema`, `platform`, `appVersion`,
`capturesSucceeded`, `capturesSkipped`, and `inferenceFailures`. The server must
reject additional fields and must not derive or retain IP-based identifiers.
