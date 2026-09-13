---
name: update-jenkins
description: "Procedure for updating Jenkins CI/CD Docker container."
---

# Update Jenkins

## How to update

1. Check latest LTS releases at https://jenkins.io/download/ or https://hub.docker.com/r/jenkins/jenkins/tags
2. Update `image: jenkins/jenkins:2.X` in `docker-compose.yml`
3. Update socat helper if needed: `alpine/socat:X.Y.Z`
4. `docker compose pull && docker compose up -d`

## Notes

- Jenkins home (config, jobs, plugins) persists in `${JENKINS_MOUNT_DIR}`
- Jenkins auto-applies plugin/data migrations on startup
- For major jumps, check the [Jenkins upgrade guide](https://www.jenkins.io/doc/administration/requirements/upgrade-jenkins/) — plugins may need updating
- After upgrade, verify jobs load and agents connect
- The socat sidecar exposes Docker socket for Jenkins pipelines
