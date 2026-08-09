---
name: update-ollama
description: "Procedure for updating Ollama LLM server Docker container."
---

# Update Ollama

## How to update

1. Check latest releases at https://github.com/ollama/ollama/releases
2. Update `image: ollama/ollama:X.Y.Z` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- Models persist in `${OLLAMA_MOUNT_DIR}` (downloaded model files survive upgrades)
- GPU (NVIDIA) pass-through is configured via `deploy.resources.reservations.devices`
- After upgrade, verify models load: `docker exec ollama ollama list`
- Major Ollama versions may change model format — check release notes
