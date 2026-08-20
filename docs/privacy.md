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
and the Firebase refresh token are stored in Keychain on macOS or Credential
Manager on Windows.

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
- Legacy Firestore import and cloud purge are separate, explicit, one-time
  actions with previews and confirmations.

## Diagnostics

When enabled and when a production endpoint is configured, diagnostics contain
only platform, app version, and bounded counts of successful, skipped, and
failed operations. The diagnostics API does not accept account IDs, device IDs,
timestamps, application/window metadata, labels, screenshots, or model output.
