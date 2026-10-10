# anton-apps — AGENT Rules

## Docker Host Access
- Docker daemon is **not** available via local socket. Always prefix docker commands with:
  `DOCKER_HOST=tcp://172.17.0.1:2375`
- Example: `DOCKER_HOST=tcp://172.17.0.1:2375 docker ps`

## Config Pattern — Disable, Never Delete
- Apps are enabled/disabled via enabled_apps lists in:
  - `ansible/host_vars/anton.yml` (production)
  - `ansible/host_vars/anton-dev.yml` (dev)
- **Never delete app code** — remove the entry from the `enabled_apps:` YAML list instead
- The full app directory with docker-compose.yml, config, templates, and README must remain in `apps/<name>/`

## Common Debugging Commands
```bash
# Live resource usage per container
DOCKER_HOST=tcp://172.17.0.1:2375 docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}\t{{.MemUsage}}"

# Inspect a container's mounts, env, health
DOCKER_HOST=tcp://172.17.0.1:2375 docker inspect <container>

# Run commands inside a container
DOCKER_HOST=tcp://172.17.0.1:2375 docker exec <container> sh -c "<cmd>"

# Fetch logs
DOCKER_HOST=tcp://172.17.0.1:2375 docker logs --tail 50 <container>
```

## Storage Rules
- All containers run on a RAID5 array of 3x 16TB WD HDDs (`/dev/md0`, 33TB, 85% full)
- The 931GB Portable SSD (sde) is **not to be used** for anything
- Config dirs stay on HDD — only ephemeral cache/temp/transcode paths may move to tmpfs
- Add tmpfs via the service-level `tmpfs:` directive in docker-compose.yml

## GPU
- NVIDIA GTX 1660 with NVENC available. Driver 580.178.04, CUDA 13.0
- Every container that benefits should have:
  ```yaml
  deploy:
    resources:
      reservations:
        devices:
          - driver: nvidia
            count: all
            capabilities: [gpu]
  ```

## PR Workflow
- gh CLI is at `/opt/data/home/.gemini/antigravity-cli/bin/gh`
- Auth token is in `~/.git-credentials` (HTTPS embedded)
- Push with `--force` when branch history is rewritten
- Use `gh pr create` with `--title`, `--body`, `--base master`
- Use `gh pr close <number>` to close a stale PR before recreating