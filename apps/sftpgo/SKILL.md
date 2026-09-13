---
name: update-sftpgo
description: "Procedure for updating SFTPGo Docker container."
---

# Update SFTPGo

## How to update

1. Check latest releases at https://github.com/drakkan/sftpgo/releases
2. Update `image: drakkan/sftpgo:vX.Y.Z-slim` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- SFTPGo auto-migrates its internal DB on startup
- User data persists in `${SFTP_SRV_MOUNT_DIR}`; config/DB in `${SFTP_LIB_MOUNT_DIR}`
- The `-slim` variant excludes the WebDAV component
- Verify user access and port forwarding after upgrade
