# Electronic Program Guide (EPG) Grabber

This service hosts an automated EPG grabber for IPTV, fetching XMLTV-format program guides on a regular schedule using the `iptv-org/epg` utility.

## Features
- **Scheduled Grab**: Runs automatically on a customized cron schedule (`EPG_CRON_SCHEDULE`).
- **Channel Sources**: Scrapes program descriptions for specific channels defined in a read-only local `channels.xml` file.
- **Web UI & Output**: Exposes a web UI on `EPG_WEB_UI_PORT` (default: `30000`) to serve the generated guide files.

## Environment Variables
- `HOST_TZ`: Local timezone for schedule synchronization.
- `EPG_CRON_SCHEDULE`: Crontab definition (e.g. `0 0,12 * * *` to run twice daily at midnight and noon).
- `EPG_MAX_CONNECTIONS`: Parallel connection limit for fetching XML feeds.
- `EPG_DAYS`: Number of days of TV listings to fetch (default: `14`).
- `EPG_RUN_AT_STARTUP`: Whether to perform an immediate grab at container boot.
- `EPG_GZIP`: Whether to gzip-compress the output XMLTV files.
- `EPG_CURL`: Whether to use `curl` instead of the built-in HTTP client for fetching feeds.
- `EPG_TIMEOUT`: Request timeout in milliseconds for each feed fetch.
- `EPG_DELAY`: Delay in milliseconds between individual feed requests to avoid rate-limiting.
- `EPG_CHANNELS_FILE`: Path on host pointing to channels list XML.
- `EPG_PUBLIC_MOUNT_DIR`: Directory where output XML files are compiled and served.
- `EPG_WEB_UI_PORT`: Host port to access files and monitor status.
