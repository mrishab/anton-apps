---
name: update-sonarqube
description: "Procedure for updating SonarQube Docker container."
---

# Update SonarQube

## How to update

1. Check latest releases at https://github.com/SonarSource/sonarqube/releases
2. Update `image: sonarqube:X.Y.Z.NNNNN-community` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- SonarQube auto-migrates its Elasticsearch-based data on startup
- Data, extensions, and logs persist in their respective volumes
- For major version jumps (e.g., 25.x → 26.x), check the [SonarQube upgrade guide](https://docs.sonarsource.com/sonarqube/latest/setup-and-upgrade/upgrade-the-server/)
- Large instance upgrades may need a multi-step path — SonarQube supports skipping some minor versions
- Always backup the Postgres DB before upgrading
