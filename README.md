# Focus Flow

Focus Flow is a local-first Pomodoro desktop app for macOS and Windows. Describe
your work, run configurable focus and break phases, and review a daily timeline
of completed and partial intervals. SQLite is the on-device source of truth;
Firebase Authentication and Cloud Firestore provide account ownership and sync.

## MVP features

- Email/password account creation, sign-in, password reset, and sign-out.
- Classic 25/5/15 Pomodoro cycle with a long break after four focuses.
- Configurable durations, long-break interval, and completion sound.
- Pause/resume, partial-session saving, and timestamp-based restart recovery.
- Native desktop completion notification plus a short generated completion tone.
- Local-first Drift/SQLite storage with queued, idempotent Firestore sync.
- Daily focus/break totals, completed Pomodoros, partial focus time, and timeline.
- Date navigation, activity-label correction, and synchronized tombstone deletion.

Passive screen-time collection, system-tray operation, charts, tags, and automatic
phase starts are intentionally outside this first release.

## Prerequisites

- Flutter 3.41.1 or newer with macOS and/or Windows desktop support enabled.
- Xcode for macOS builds; Visual Studio with Desktop development with C++ for
  Windows builds.
- The checked-in app is already connected to the Firebase project
  `focus-flow-spencertse`. Firebase configuration identifiers are not secrets;
  account access and data isolation are enforced by Authentication and the
  deployed Firestore security rules.

## Firebase setup

Firebase project creation, the macOS and Windows app registrations,
Email/Password Authentication, and the Firestore database in
`asia-southeast1` have already been provisioned. To redeploy the checked-in
configuration and security rules after changing them:

```sh
firebase login
firebase use focus-flow-spencertse
firebase deploy --only auth,firestore:rules
```

Platform identifiers live in `lib/core/firebase_config.dart`. Focus Flow uses
Firebase's authenticated REST APIs so a personal macOS build does not require an
Apple Developer signing certificate. The refresh token is stored in the local
SQLite database; Firestore requests use short-lived Firebase ID tokens and are
still evaluated by the deployed security rules.

## Development commands

```sh
flutter pub get
dart run build_runner build
flutter run -d macos
# Run the equivalent command on a Windows host:
flutter run -d windows
```

## Use the app

After a release build, open the macOS app directly:

```sh
open "build/macos/Build/Products/Release/Focus Flow.app"
```

On first launch, create an account with your email and a password of at least
six characters. Enter the work you are doing, start the focus timer, and use
the **Day** view to review, rename, or remove tracked intervals. Settings are
available from the left navigation rail.

## Validation and builds

```sh
dart format --output=none --set-exit-if-changed lib test integration_test
flutter analyze
flutter test
flutter build macos
# Must run on Windows:
flutter build windows
```

The real-backend integration test requires a temporary Firebase test account:

```sh
flutter test integration_test/app_flow_test.dart \
  --dart-define=TEST_EMAIL=... \
  --dart-define=TEST_PASSWORD=...
```

Run the Firebase emulators for manual rules testing with:

```sh
firebase emulators:start --only auth,firestore
```

## Data and recovery behavior

Each account has local session, settings, and active-timer records. A finished
session is first committed to SQLite and marked dirty; synchronization writes it
to `users/{uid}/sessions/{sessionId}` and clears the dirty flag. Offline edits and
deletions use the same queue. Deletes remain tombstones so another installation
does not restore removed history.

If the app reopens while a running phase still has time remaining, the countdown
is reconstructed from its UTC deadline. If the deadline passed, the phase is
recorded once at its scheduled end and the app waits for the user to start the
next phase. Paused timers remain paused. Active timers are device-local and are
not handed off between computers.

## Project structure

- `lib/features/` contains authentication, timer, dashboard, and settings UI.
- `lib/domain/` contains timer/session/settings types.
- `lib/data/` contains Drift persistence, repositories, and Firestore sync.
- `lib/services/` contains authentication and desktop notification adapters.
- `test/` mirrors critical timer and persistence behavior.
