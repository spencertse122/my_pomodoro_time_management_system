# Local AI model staging

Focus Flow v2 uses a quantized Gemma 3 4B instruction model and matching
multimodal projector through `llama.cpp`. Model weights are intentionally not
committed to Git.

Before a release build, place the verified artifacts here:

- `gemma-3-4b-it-q4_k_m.gguf`
- `mmproj-gemma-3-4b-it-f16.gguf`

`tool/verify_models.dart` validates them against the checksums configured by the
release environment. Release operators must accept the Gemma Terms of Use and
retain the checked-in notice alongside the bundled model.
