# Focus Flow v2

Focus Flow is a privacy-first Pomodoro and activity-awareness desktop app for
macOS and Windows. It combines an intentional Pomodoro lane with an observed
activity lane, then uses a bundled Gemma vision model to classify activity and
generate daily summaries entirely on the user's machine.

## Privacy guarantees

- Personal activity data is stored only in a local SQLCipher-compatible
  `sqlite3mc` database. Its random key is held by Keychain on macOS or Windows
  Credential Manager.
- Screenshots are captured only after explicit consent, passed from native
  memory directly to local inference, and never written to disk, the database,
  logs, backups, diagnostics, Firebase, or another network service.
- Firebase is used for authentication only. Routine Firestore synchronization
  has been removed. Firestore access exists only in the explicit, one-time
  legacy import-and-purge tool.
- Tracking pauses for a locked session or configurable idle period. Users can
  pause/disable tracking, exclude apps, retag classifications, and disable
  aggregate diagnostics.

The complete boundary and data inventory are in [docs/privacy.md](docs/privacy.md)
and [docs/architecture.md](docs/architecture.md).

## Product behavior

- Native foreground-app, active-window, idle, and lock-state observation.
- Explicit screen-recording permission and in-memory capture of every connected
  display for local Gemma 3 multimodal analysis.
- Editable categories, including Learning, Work, Miscellaneous, Time wasted,
  and Casual browsing; low-confidence output remains visible for review.
- Daily observed-activity totals kept separate from Pomodoro intentions so the
  same time is never double-counted.
- Manual retagging, optional per-app rules, app exclusions, metadata-only
  degradation, daily local-AI insight, system tray operation, and launch at
  login.
- User-initiated passphrase-encrypted backup/restore and an explicit legacy
  Firestore migration with preview, import confirmation, purge confirmation,
  and cloud-empty verification.

An encrypted backup contains all Focus Flow profiles stored on that computer;
the export dialog makes this device-wide scope explicit.

## Supported release targets

- macOS 13 or newer on Apple Silicon.
- Windows 11 x64.
- 16 GB RAM is recommended for the bundled Gemma 3 4B Q4 model.

Linux is not a v2 release target. Physical macOS/Windows permission behavior,
GPU/CPU performance, signing, notarization, and installer verification must be
validated on their target hosts; see [docs/release.md](docs/release.md) and
[docs/limitations.md](docs/limitations.md).

## Development

Install Flutter 3.47.1, Xcode 15+ for macOS, or Visual Studio 2022 with Desktop
development with C++ for Windows. Then run:

```sh
flutter pub get
dart run build_runner build
dart format --output=none --set-exit-if-changed lib test integration_test tool
flutter analyze
flutter test
flutter run -d macos
# On a Windows host:
flutter run -d windows
```

Development builds work without model weights and show a local-model-missing
state. To exercise AI, put these files in `assets/models/` before building, or
provide absolute paths with `FOCUS_FLOW_MODEL_PATH` and
`FOCUS_FLOW_MMPROJ_PATH` as compile-time defines:

- `gemma-3-4b-it-q4_k_m.gguf`
- `mmproj-gemma-3-4b-it-f16.gguf`

Weights are intentionally gitignored. Obtain them from an authorized source,
accept the [Gemma Terms of Use](https://ai.google.dev/gemma/terms), and verify
their release-pinned SHA-256 values:

```sh
GEMMA_MODEL_SHA256=<64 hex characters> \
GEMMA_MMPROJ_SHA256=<64 hex characters> \
dart run tool/verify_models.dart
```

## Firebase boundary

The checked-in Firebase configuration contains public application identifiers,
not credentials. Email/password authentication supports account creation,
sign-in, password reset, refresh, sign-out, and deletion. The refresh token is
stored in the OS secure store, not in the database.

Deploy the v2 rules before offering legacy cleanup. They permit an authenticated
owner to read/delete only their old session/settings documents and reject all
creates and updates:

```sh
firebase login
firebase use focus-flow-spencertse
firebase deploy --only firestore:rules
```

The optional real-auth integration test requires a disposable Firebase account:

```sh
flutter test integration_test/app_flow_test.dart \
  --dart-define=TEST_EMAIL=... \
  --dart-define=TEST_PASSWORD=...
```

## Release configuration

The signed release workflow downloads model artifacts from protected URLs,
checks their SHA-256 digests, builds target-native packages, and signs/notarizes
them. It requires self-hosted Apple Silicon macOS and Windows x64 runners plus
the secrets and variables documented in [docs/release.md](docs/release.md).

Optional endpoints are compile-time only:

- `FOCUS_FLOW_DIAGNOSTICS_URL`: HTTPS endpoint accepting only the documented
  coarse health-counter schema. With no value, no diagnostics request is made.
- `FOCUS_FLOW_UPDATE_FEED_URL`: HTTPS JSON feed pointing to signed installers.
  With no value, update checking reports that it is not configured.

## Project structure

- `lib/features/` contains authentication, onboarding, timer, tracking,
  dashboard, and settings UI/controllers.
- `lib/data/` contains encrypted local repositories and the isolated legacy
  migration boundary.
- `lib/services/` contains local inference, native capture, secure storage,
  backups, authentication, diagnostics, and update adapters.
- `macos/Runner/` and `windows/runner/` contain the platform capture channels.
- `test/` covers domain, privacy-boundary, database, AI, capture, and UI behavior.
- `docs/` and `packaging/` contain operational documentation and installers.
