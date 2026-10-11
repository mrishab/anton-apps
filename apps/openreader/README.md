# OpenReader

OpenReader is a self-host-friendly, text-to-speech document reader built with Next.js for **EPUB, PDF, TXT, MD, and DOCX** with multilingual, synchronized read-along playback and progressive audio generation.

## Overview

Key features include:
- **Layout-Aware PDF Parsing**: Structured block detection and cross-page stitching using PP-DocLayoutV3 (ONNX) for precise geometry-based highlighting.
- **Word-by-Word Synchronized Highlighting**: Powered by ONNX Whisper alignment through the embedded compute worker control plane (NATS JetStream).
- **Progressive Background Generation**: Begins listening as soon as the first segment is synthesized while the worker streams ahead; cached audio is reused across seeks, reloads, and exports.
- **Audiobook Export**: Export documents to M4B or MP3 assembled directly from the playback cache.
- **Integrated Storage & Database**: Embedded SQLite metadata storage and embedded SeaweedFS S3 document store under `/app/docstore`.
- **GPU-Accelerated TTS via Kokoro**: Connected seamlessly to the companion `kokoro-tts` service running on the host's ZOTAC GeForce GTX 1660 6GB GDDR5 GPU.

## Architecture

```
                          ┌─────────────────────────┐
                          │   Browser / Client      │
                          └───────────┬─────────────┘
                                      │
               ┌──────────────────────┴──────────────────────┐
               │ HTTPS (Reverse Proxy / Nginx / Cloudflare)   │
               └──────────────┬───────────────────┬──────────┘
                              │                   │
                     /v1/tts-playback/           Web / API
                              │                   │
                              ▼                   ▼
                  ┌───────────────────────────────────────┐
                  │           OpenReader Container        │
                  │  ┌─────────────────────────────────┐  │
                  │  │ Next.js App Server (Port 3003)  │  │
                  │  └───────────────┬─────────────────┘  │
                  │                  │                    │
                  │  ┌───────────────▼─────────────────┐  │
                  │  │ Embedded Compute Worker         │  │
                  │  │ (Port 8081 - Playback & Align)  │  │
                  │  └───────────────┬─────────────────┘  │
                  │                  │                    │
                  │  ┌───────────────▼─────────────────┐  │
                  │  │ Storage & DB (/app/docstore)    │  │
                  │  │ (SQLite, SeaweedFS, JetStream)  │  │
                  │  └─────────────────────────────────┘  │
                  └──────────────────┬────────────────────┘
                                     │
                     TTS Requests:   │  http://172.17.0.1:8880/v1
                     /v1/audio/speech│
                                     ▼
                  ┌───────────────────────────────────────┐
                  │          Kokoro-TTS Container         │
                  │   (NVIDIA GeForce GTX 1660 6GB GPU)   │
                  │          Kokoro-82M (CUDA 12.6)       │
                  └───────────────────────────────────────┘
```

## Configuration

### Environment Variables

Copy `template.env` to `.env`:
```bash
cp template.env .env
```

Configuration parameters:

| Variable | Description | Default / Example |
|---|---|---|
| `OPENREADER_WEB_PORT` | Host port for OpenReader web application | `3005` |
| `OPENREADER_PLAYBACK_PORT` | Host port for compute worker TTS playback audio | `8087` |
| `OPENREADER_CONFIG_MOUNT_DIR` | Persistent host directory for configuration | `/mnt/external_hdd/openreader/config` |
| `OPENREADER_DATA_MOUNT_DIR` | Persistent host directory for docstore (SQLite + SeaweedFS + NATS) | `/mnt/external_hdd/openreader/data` |
| `OPENREADER_BASE_URL` | Externally accessible base URL | `https://openreader.cloudville.me` |
| `OPENREADER_AUTH_SECRET` | 32+ character random secret for session encryption | *(auto-generated)* |
| `OPENREADER_BOOTSTRAP_ADMIN_EMAIL` | Initial admin user email address | `admin@cloudville.me` |
| `OPENREADER_BOOTSTRAP_ADMIN_PASSWORD` | Initial admin password (16+ characters required) | *(user-defined, min 16 chars)* |
| `OPENREADER_COMPUTE_WORKER_PUBLIC_URL` | Public audio URL accessed by browsers | `https://openreader.cloudville.me` |
| `OPENREADER_TTS_API_BASE` | Base URL pointing to the Kokoro TTS service | `http://172.17.0.1:8880/v1` |
| `OPENREADER_TTS_API_KEY` | API key / Bearer token for authenticating with Kokoro TTS | *(matches `KOKORO_TTS_API_KEY`)* |
| `OPENREADER_TTS_API_MODEL_NAME` | Default TTS model name | `kokoro` |

### Seed Configuration (`RUNTIME_SEED_JSON`)

On first boot, OpenReader automatically seeds Kokoro with the authentication key as the default shared TTS provider:
```json
{
  "version": 1,
  "runtimeConfig": {
    "defaultTtsProvider": "kokoro"
  },
  "providers": [
    {
      "slug": "kokoro",
      "displayName": "Kokoro (Local GPU)",
      "providerType": "custom-openai",
      "baseUrl": "http://172.17.0.1:8880/v1",
      "apiKey": "<KOKORO_TTS_API_KEY>",
      "defaultModel": "kokoro",
      "enabled": true
    }
  ]
}
```

> **Note for Existing Deployments**: `RUNTIME_SEED_JSON` seeds providers during the first initialization only. If OpenReader has already completed its initial setup, update the API key in the web interface: navigate to **Settings → Admin → Shared providers**, edit **Kokoro (Local GPU)**, enter your `KOKORO_TTS_API_KEY` into the **API Key** field, and save.


## Usage

### Starting OpenReader with Kokoro TTS

Start both services together to enable AI voice reading:
```bash
# Start both apps from repository root
make start APPS="kokoro-tts,openreader"
```

Or from the openreader folder:
```bash
cd apps/openreader
docker compose up -d
```

### First-Time Login & Administrator Activation

1. Navigate to `https://openreader.cloudville.me` (or `http://<server-ip>:3005` on LAN).
2. Sign in with the bootstrap credentials:
   - **Email**: `admin@cloudville.me`
   - **Password**: The password defined in `OPENREADER_BOOTSTRAP_ADMIN_PASSWORD`.
3. Go to **Settings → Account** and change the initial password. This activates your administrator role and reveals the **Admin** panel.
4. Go to **Settings → Admin → Maintenance** to verify that storage, compute worker, and the Kokoro provider are active and healthy.

### Reading PDFs & EPUBs

1. Upload any PDF or EPUB in the web interface.
2. Open the document to view the layout-parsed blocks.
3. Click **Play** — the compute worker requests speech segments from `kokoro-tts` on the GTX 1660 GPU and plays synchronized audio with word highlighting.

## Maintenance

### Updating OpenReader

```bash
cd apps/openreader
docker compose pull
docker compose up -d
```

### Viewing Logs

```bash
docker compose logs -f
# or
docker logs openreader
```

### Backups

All metadata, books, uploaded PDFs, audio caches, and JetStream states are stored in `${OPENREADER_DATA_MOUNT_DIR}` (`/mnt/external_hdd/openreader/data`). Back up this directory to preserve user state and documents.
