# Privacy model

Focus Flow v2 is designed so personal activity data does not leave the user's
computer.

## Data boundaries

Firebase Identity Toolkit receives only the information needed for account
creation, sign-in, password reset, token refresh, and account deletion. Focus
Flow does not perform routine Firestore reads or writes in v2.

The encrypted database in the OS application-support directory stores Pomodoro
sessions, foreground application metadata, window titles, classifications,
categories, rules, and generated insights. Its randomly generated database key
and the Firebase refresh token are stored through the operating system's secure
credential facility. On macOS that is Keychain. On Windows,
`flutter_secure_storage` encrypts values with an AES-GCM key stored in Windows
Credential Manager; it does not leave those values as plaintext files.

Focus Flow does not upload that database. Operating-system or user-configured
backup software may copy its encrypted bytes, and a user may explicitly export
a passphrase-encrypted device backup containing every local Focus Flow profile.

Screen images are requested only after an explicit consent action. Connected
displays are encoded in native memory, passed directly to the local Gemma model,
and released. Images are never written to a file, inserted into the database,
included in logs, diagnostics, backups, or sent over the network.

## User controls

- Tracking is disabled until onboarding consent is complete.
- Tracking automatically skips locked sessions and configurable idle periods.
- Users can pause tracking, disable it, exclude application identifiers, and
  disable anonymous aggregate diagnostics.
- Encrypted export and import are user-initiated operations.
- Restore requires an explicit device-wide replacement confirmation. Account
  deletion cancels a staged restore so it cannot reintroduce the deleted
  profile; separately exported backup files remain under the user's control.
- Legacy Firestore import and cloud purge are separate, explicit, one-time
  actions with previews and confirmations.
- Account deletion purges and verifies the legacy Firestore locations while the
  identity can still authorize deletion, drains capture and timer writes,
  removes the account's local rows, and only then deletes the identity.

## Diagnostics

When enabled and when a production endpoint is configured, diagnostics contain
only platform, app version, and bounded counts of successful, skipped, and
failed operations. The diagnostics API does not accept account IDs, device IDs,
timestamps, application/window metadata, labels, screenshots, or model output.
Counters are neither recorded nor sent until the current privacy notice has
been completed. Pending counters are discarded if consent is absent or stale.
