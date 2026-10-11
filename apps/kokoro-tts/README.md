# Kokoro-TTS

Kokoro-TTS is a high-performance, self-hosted text-to-speech (TTS) server powered by the [Kokoro-82M](https://huggingface.co/hexgrad/Kokoro-82M) model and packaged using [Kokoro-FastAPI](https://github.com/remsky/Kokoro-FastAPI). It provides an OpenAI-compatible speech synthesis endpoint with support for high-quality natural voices.

## Overview

This deployment provides:
- **OpenAI-Compatible TTS API**: Standard `/v1/audio/speech` and `/v1/audio/voices` endpoints compatible with OpenReader, Open-WebUI, Home Assistant, and OpenAI SDKs.
- **Hardware Acceleration**: Optimized for NVIDIA GPUs using CUDA (specifically tested on the ZOTAC GeForce GTX 1660 6GB GDDR5).
- **Embedded Web Player**: Interactive web UI at `/` and `/web` for testing voices, adjusting speech parameters, and generating audio.
- **Lightweight Footprint**: The Kokoro-82M model requires only ~1 GB VRAM, leaving ample GPU memory for concurrent tasks while achieving real-time factors well under 0.1 (minutes of audio in seconds).
- **Rich Voice Catalog**: Pre-baked voices across multiple accents and languages (e.g. `af_heart`, `af_bella`, `af_nicole`, `am_adam`, `am_michael`, `bf_emma`, `bf_isabella`, `bm_george`, `bm_lewis`).

## Hardware & GPU Configuration

### Target GPU: ZOTAC GeForce GTX 1660 6GB GDDR5
- **Architecture**: Turing (TU116)
- **Compute Capability**: 7.5
- **VRAM**: 6 GB GDDR5 192-bit
- **CUDA Runtime**: 12.6 (cu126) supported in the container
- **VRAM Utilization**: ~800 MB - 1.2 GB during active inference

### NVIDIA Prerequisites
Ensure the host has the NVIDIA driver and NVIDIA Container Toolkit installed:
```bash
# Verify NVIDIA GPU availability on the host
make check-nvidia
```

## Configuration

### Environment Variables

Copy `template.env` to `.env` if not already present:
```bash
cp template.env .env
```

Key variables configured in `.env`:
```env
# Global
HOST_TZ=America/Los_Angeles
APP_PUID=1001
APP_PGID=1001

# Kokoro-TTS
KOKORO_TTS_PORT=8880
KOKORO_TTS_CONFIG_MOUNT_DIR=/mnt/external_hdd/kokoro-tts/config
KOKORO_TTS_DATA_MOUNT_DIR=/mnt/external_hdd/kokoro-tts/data # Mounted to /home/appuser/.cache
KOKORO_TTS_USE_GPU=true
KOKORO_TTS_DEVICE_TYPE=cuda
KOKORO_TTS_DEFAULT_VOICE=af_heart
KOKORO_TTS_API_LOG_LEVEL=INFO
KOKORO_TTS_ENABLE_WEB_PLAYER=true
KOKORO_TTS_CORS_ENABLED=true
```

## Usage

### Starting Kokoro-TTS

From the app directory:
```bash
cd apps/kokoro-tts
docker compose up -d
```

Or from the repository root:
```bash
make start APPS="kokoro-tts"
```

### Stopping Kokoro-TTS

```bash
make stop APPS="kokoro-tts"
```

### Checking Status and Logs

```bash
docker compose logs -f
# or
docker logs kokoro-tts
```

### Verifying the API

Test that the service is running and GPU inference is responsive:

```bash
# List available voices
curl http://localhost:8880/v1/audio/voices

# Generate a sample audio file
curl -X POST http://localhost:8880/v1/audio/speech \
  -H "Content-Type: application/json" \
  -d '{
    "model": "kokoro",
    "input": "Hello! Kokoro TTS is running on the ZOTAC GeForce GTX 1660.",
    "voice": "af_heart",
    "response_format": "mp3"
  }' \
  --output test_speech.mp3
```

## Integration with OpenReader

OpenReader connects to this Kokoro-TTS instance via the Docker host IP bridge (`http://172.17.0.1:8880/v1`) or host gateway (`http://host.docker.internal:8880/v1`).

To start both services together:
```bash
make start APPS="kokoro-tts openreader"
```

OpenReader auto-probes `/v1/audio/voices`, discovers the available voices, and performs background TTS generation as you stream or export documents and audiobooks.

## Troubleshooting

- **GPU Not Detected**: Verify the NVIDIA Container Toolkit is installed on the host and that `nvidia-smi` works (`make check-nvidia`).
- **Port Conflict**: Default port is `8880`. If another service uses `8880`, modify `KOKORO_TTS_PORT` in `.env` and update the dependent apps accordingly.
- **Audio Output Empty**: Check container logs using `docker logs kokoro-tts` for any CUDA out-of-memory or input encoding errors.
