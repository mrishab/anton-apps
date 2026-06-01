# UpSnap (Wake on LAN Dashboard)

UpSnap is a self-hosted Wake on LAN (WoL) dashboard that monitors device statuses and sends magic packets to wake up systems on your local network.

## Features
- **Wake on LAN**: Wake up devices remotely via web UI.
- **Host Network Mode**: Configured with `network_mode: host` to allow container direct broadcast communication on the local subnet.
- **Subnet Sweeps**: Automatically scans defined network ranges to discover and monitor systems.
- **Privileged Access**: Granted raw socket capabilities (`NET_RAW`, `NET_ADMIN`) to handle raw network pings.

## Environment Variables
- `HOST_TZ`: Host timezone configuration.
- `UPSNAP_INTERVAL`: 6-field cron expression (includes seconds, e.g. `*/10 * * * * *`) defining how often device statuses are polled.
- `UPSNAP_SCAN_RANGE`: IP scan range used for subnet discovery (e.g. `192.168.1.0/24`).
- `UPSNAP_SCAN_TIMEOUT`: Go duration string for ping timeout during subnet sweeps (e.g. `500ms`).
- `UPSNAP_PING_PRIVILEGED`: Enables privileged ICMP ping via raw sockets.
- `UPSNAP_DATA_MOUNT_DIR`: Path to the PocketBase backend database directory.
- `UPSNAP_WEB_UI_PORT`: Host port where the interface is exposed.

## Configuration & Volumes
- **Network**: Operates in `host` network mode.
- **Volume Mounts**:
  - `/app/pb_data` — PocketBase persistent database directory containing users, devices, and history logs.
