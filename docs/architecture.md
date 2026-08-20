# Focus Flow v2 architecture

The Flutter application coordinates four independent boundaries:

1. Native macOS and Windows channels return foreground-app metadata, idle/lock
   state, consent status, and in-memory PNG bytes for connected displays.
2. A single-flight tracking controller applies pause, idle, lock, exclusion,
   and backpressure checks before each capture.
3. `lib_llama_cpp` runs the bundled Gemma vision model locally and returns
   schema-validated classification and insight objects.
4. Drift writes domain records to a SQLCipher-compatible `sqlite3mc` database.

Firebase Authentication is an identity boundary, not a data store. The only
Firestore code reachable in v2 is the explicit legacy migration workflow.

Focus Flow does not read an operating-system-owned historical Screen Time
database. It measures its own intervals from foreground snapshots at the chosen
cadence, which keeps the collection behavior explicit and consistent across the
two supported desktop targets.

## Degraded operation

Missing or denied screen permission does not disable Pomodoro features. Missing
model assets, model-load failures, malformed model output, or inference
backpressure produce a typed status and a metadata-only record. Raw images are
dropped immediately. The app does not substitute a remote AI service.

## Release assets

Gemma weights are intentionally excluded from Git. A trusted release job must
stage the two declared GGUF files, verify their SHA-256 values with
`dart run tool/verify_models.dart`, accept and bundle the applicable Gemma terms,
then sign the installer. Development builds without those files surface a clear
"local model missing" status.
