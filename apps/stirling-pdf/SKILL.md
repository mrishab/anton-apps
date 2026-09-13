---
name: update-stirling-pdf
description: "Procedure for updating Stirling PDF Docker container."
---

# Update Stirling PDF

## How to update

1. Check latest releases at https://github.com/Frooodle/Stirling-PDF/releases
2. Update `image: stirlingtools/stirling-pdf:X.Y.Z` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- Stirling-PDF auto-migrates its config on startup
- Configs persist in `${STIRLING_PDF_CONFIG_MOUNT_DIR}`
- Tessdata (OCR languages), logs, and pipeline files are in separate volumes
- Check release notes for new features and breaking API changes
