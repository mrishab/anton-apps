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
KOKORO_TTS_API_KEY=<PUT-KOKORO-TTS-API-KEY-HERE>
KOKORO_TTS_CONFIG_MOUNT_DIR=/mnt/external_hdd/kokoro-tts/config
KOKORO_TTS_DATA_MOUNT_DIR=/mnt/external_hdd/kokoro-tts/data # Mounted to /home/appuser/.cache
KOKORO_TTS_USE_GPU=true
KOKORO_TTS_DEVICE_TYPE=cuda
KOKORO_TTS_DEFAULT_VOICE=af_heart
KOKORO_TTS_API_LOG_LEVEL=INFO
KOKORO_TTS_ENABLE_WEB_PLAYER=true
KOKORO_TTS_CORS_ENABLED=true
```

### Security & Authentication

Kokoro-FastAPI is protected by a reverse proxy sidecar (`kokoro-tts-proxy`) that authenticates every incoming request before forwarding it to the Kokoro model engine:
- **Bearer Token**: `Authorization: Bearer <KOKORO_TTS_API_KEY>` or `Authorization: Token <KOKORO_TTS_API_KEY>` (standard OpenAI API header, used by OpenReader and OpenAI SDKs)
- **API Key Header**: `X-API-Key: <KOKORO_TTS_API_KEY>`
- **Query Parameter**: `?api_key=<KOKORO_TTS_API_KEY>`, `?token=<KOKORO_TTS_API_KEY>`, or `?key=<KOKORO_TTS_API_KEY>` (convenient for web browsers and quick testing)
- **Session Cookie**: Visiting `/?token=<KOKORO_TTS_API_KEY>` or `/?api_key=<KOKORO_TTS_API_KEY>` in a browser sets a session cookie (`kokoro_session`) so the embedded web player and static assets work seamlessly.
- **Health Probes**: The `/health` and `/health/` endpoints remain open for container and uptime monitoring probes.
- **Unauthenticated Requests**: Automatically rejected with `HTTP 401 Unauthorized` and `WWW-Authenticate: Bearer` challenge.


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

### Verifying the API & Security

1. Test that unauthenticated requests are rejected:
```bash
curl -i http://localhost:8880/v1/audio/voices
# Returns: HTTP/1.1 401 Unauthorized
```

2. Test that requests with the API key succeed:
```bash
# List available voices using Bearer authorization
curl http://localhost:8880/v1/audio/voices \
  -H "Authorization: Bearer <KOKORO_TTS_API_KEY>"

# Alternatively, using X-API-Key header
curl http://localhost:8880/v1/audio/voices \
  -H "X-API-Key: <KOKORO_TTS_API_KEY>"

# Or query parameter in a web browser
curl "http://localhost:8880/v1/audio/voices?api_key=<KOKORO_TTS_API_KEY>"
```

3. Generate a sample audio file:
```bash
curl -X POST http://localhost:8880/v1/audio/speech \
  -H "Authorization: Bearer <KOKORO_TTS_API_KEY>" \
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

OpenReader connects to this Kokoro-TTS instance via the Docker host IP bridge (`http://172.17.0.1:8880/v1`) using the shared API key (`OPENREADER_TTS_API_KEY` matching `KOKORO_TTS_API_KEY`).

To start both services together:
```bash
make start APPS="kokoro-tts,openreader"
```

OpenReader sends `Authorization: Bearer <key>` on its background requests, probes `/v1/audio/voices`, discovers the available voices, and performs synchronized TTS generation.

## Troubleshooting

- **GPU Not Detected**: Verify the NVIDIA Container Toolkit is installed on the host and that `nvidia-smi` works (`make check-nvidia`).
- **Port Conflict**: Default port is `8880`. If another service uses `8880`, modify `KOKORO_TTS_PORT` in `.env` and update the dependent apps accordingly.
- **Audio Output Empty**: Check container logs using `docker logs kokoro-tts` for any CUDA out-of-memory or input encoding errors.
