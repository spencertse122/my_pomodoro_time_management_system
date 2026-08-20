# Focus Flow v2 completion report

Date: 2026-08-20

This report separates repository-verified behavior from production gates that
require publisher credentials, licensed artifacts, or target hardware.

## Requirements and repository evidence

| Requirement | Implemented evidence | Verification |
| --- | --- | --- |
| No routine Firebase user-data storage | `SyncService` removed; repositories are local-only; Firestore client exposes only GET/list/DELETE for the explicit legacy workflow | Privacy-boundary and legacy-migration tests |
| Encrypted local storage | Required OS-held random key, `sqlite3mc` SQLCipher-compatible database, no plaintext fallback, verified v1 conversion | Encrypted backup/migration tests and raw-file open failure |
| Ephemeral screenshots | Native code returns typed in-memory PNG bytes; persistence schema has no image/blob/path column; local inference accepts byte parts; mid-capture locks discard all displays | Capture, controller, local-AI, and native-boundary tests |
| Desktop activity collection | Native foreground app/window metadata plus idle and lock state on macOS and Windows, with fail-closed self-window exclusion | Dart channel-contract and source-boundary tests; target-host smoke test still required |
| Local AI only | In-process `lib_llama_cpp` Gemma multimodal runtime with no remote fallback, single-flight backpressure, forced schema output, prompt-injection defenses | Local-AI unit tests with an injected runtime |
| Categories and dashboard | Default/editable categories, AI allowlist, confidence review, manual retagging, per-app rules, observed totals, separate Pomodoro lane | Repository, controller, local-AI, and dashboard tests |
| Consent and controls | First-run disclosure, current-notice gate, explicit permission action, pause/disable, idle/lock skip, app exclusion, launch at login, diagnostics control | Onboarding, controller, settings persistence, diagnostics tests |
| Data portability and deletion | Device-wide passphrase-encrypted backup, exact schema validation, rollback-safe staged restore, explicit legacy import/purge verification, write-drained local hard deletion | Backup, migration, auth, timer, and database tests |
| Release path | Hosted CI for macOS/Windows smoke builds; protected self-hosted signed release workflow; model hash verification; DMG and Inno packaging | YAML parsing and `actionlint` |

## Local validation completed

The following commands passed in the repository worktree:

```sh
flutter pub get
dart run build_runner build
dart format --output=none --set-exit-if-changed lib test integration_test tool
flutter analyze
flutter test
go run github.com/rhysd/actionlint/cmd/actionlint@v1.7.12
git diff --check
```

The Flutter suite contains 67 passing unit and widget tests. It covers encrypted
database and backup behavior, legacy plaintext conversion, secure refresh-token
storage, Firestore GET/DELETE isolation, screenshot byte boundaries, idle/lock
skipping including mid-capture lock checks, in-flight capture shutdown,
current-notice consent gates, local-AI validation/backpressure, categories/rules,
dashboard behavior, diagnostics, update endpoint validation, timer state, and
user isolation.

## Not verifiable in this environment

- Publishing `feat/privacy-first-v2` and observing its hosted CI are blocked by
  repository authorization: the available GitHub identity
  `afreeelfdobby934-sys` has read-only access to
  `spencertse122/my_pomodoro_time_management_system`. The complete branch and
  commits remain available in the local repository.
- Native macOS and Windows compilation and physical permission flows. The
  current host is Linux and the project intentionally has no Linux target.
- Real Gemma image inference, latency, and memory/thermal behavior. Licensed
  model/projector files are intentionally absent from Git.
- Apple Silicon signing/notarization/Gatekeeper and Windows Authenticode,
  SmartScreen, and installer behavior. Publisher credentials and target runners
  are not available locally.
- The real Firebase authentication integration test. It requires a disposable
  account supplied through `TEST_EMAIL` and `TEST_PASSWORD`.
- Deployment and live verification of the restrictive Firestore rules.
- Optional production update-feed and aggregate-diagnostics services.

See `docs/release.md` for the exact secrets, variables, target-host smoke matrix,
and release order. These external gates must pass before calling a particular
installer production-released.
