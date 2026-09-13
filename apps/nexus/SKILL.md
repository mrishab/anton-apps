---
name: update-nexus
description: "Procedure for updating Sonatype Nexus 3 Docker container."
---

# Update Nexus

## How to update

1. Check latest Nexus3 image tags at https://hub.docker.com/r/sonatype/nexus3/tags
2. **Pin the version**: The current image uses `sonatype/nexus3` (no tag = `latest`). Replace with an explicit tag for reproducibility.
3. Update `image: sonatype/nexus3:X.Y.Z-N` in `docker-compose.yml`
4. `docker compose pull && docker compose up -d`

## Notes

- Nexus data (repositories, config, blobs) persists in `${NEXUS_MOUNT_DIR}`
- Nexus auto-migrates its internal DB (OrientDB or H2) on startup
- For major version jumps, check the [Nexus upgrade docs](https://help.sonatype.com/en/sonatype-nexus-repository-3.html)
- Allow a few minutes for Nexus to restart (startup is slow)
- Verify repositories and users are intact after upgrade
