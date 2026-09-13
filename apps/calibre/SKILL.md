---
name: update-calibre
description: "Procedure for updating Calibre + Calibre-web Docker containers."
---

# Update Calibre

## How to update

1. Check latest Calibre releases at https://github.com/kovidgoyal/calibre/releases
2. For linuxserver images, check tags at https://hub.docker.com/r/linuxserver/calibre/tags
3. Update image tags in `docker-compose.yml`:
   - `calibre`: `lscr.io/linuxserver/calibre:version-vX.Y.Z`
   - `calibre-web`: `lscr.io/linuxserver/calibre-web:version-vX.Y.Z`
4. `docker compose pull && docker compose up -d`

## Notes

- Calibre and Calibre-web can be updated independently
- Library data is in `${CALIBRE_LIBRARY_MOUNT_DIR}`
- linuxserver images follow the `version-vX.Y.Z` tag convention
- The `DOCKER_MODS=linuxserver/mods:universal-calibre` on calibre-web enables ebook viewing
