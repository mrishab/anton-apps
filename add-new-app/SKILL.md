---
name: add-new-app
description: "Workflow for adding a new Dockerized application to the anton-apps collection. Use this skill when a user wants to create a new app directory, configure its Docker Compose and environment templates, and register it in the Ansible deployment system."
---

# Add New App Skill

This skill guides the creation of a new application in the `anton-apps` repository, ensuring consistency across Docker configurations and Ansible deployment files.

## Workflow

### 1. Research & Planning
- Identify the app's name, primary port, and necessary data volumes.
- Determine if the app requires specific host permissions (UID/GID) or sysctl settings.

### 2. Create Application Directory
Create the folder and its essential files:
- `docker-compose.yml`: Define services, networks, and volumes. Use environment variables for ports and paths.
- `template.env`: A template file containing all necessary environment variables with default or placeholder values.
- `README.md`: Short description and usage notes for the app.
- `db-init-scripts/`: (Optional) If the app needs initialization scripts for a database.

### 3. Register in Ansible
You MUST update the following files to include the new app:

#### `ansible/vars/app_configs.yml`
Add the app to the `app_configs` dictionary:
```yaml
app_configs:
  ...
  new-app-name:
    port: 1234  # The primary web port
    dirs:
      - { path: "{{ host_data_dir }}/new-app-name/data", owner: "1000", group: "1000" }
```

### 4. Verification
- Run `make dry-run APPS=new-app-name` to verify Ansible sees the new configuration.
- Check that `docker-compose.yml` uses the variables defined in `template.env`.

## Guidelines

- **Port Management**: Ensure the port doesn't conflict with existing apps. Check `ansible/vars/app_configs.yml` for used ports.
- **Paths**: Always use `{{ host_data_dir }}/app-name/...` for persistent data volumes in Ansible.
- **Permissions**: Follow existing patterns for UID/GID (e.g., 1000 for standard linuxserver images, specific ones for Postgres/Nextcloud).
- **No Deletion**: Never add tasks that perform `rm -rf` on the host data directories.
