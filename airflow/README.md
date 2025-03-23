# Airflow

Apache Airflow is a platform to programmatically author, schedule and monitor workflows. It allows you to define complex task dependencies and orchestrate data pipelines.

## Overview

This deployment includes:
- Airflow webserver for UI access
- Airflow scheduler for job orchestration
- PostgreSQL database for metadata storage
- Support for DAGs and plugins

## Configuration

### Environment Variables

Copy the template.env to .env:

```sh
cp template.env .env
```

Edit the .env file with your configuration:

```
# Postgres Configuration
PG_USERNAME=postgres                   # Database superuser
PG_PASSWORD=secure_password            # Database password
PG_PORT=5432                          # Database port
PG_DATABASE=postgres                   # Root database name

# Airflow DB Configuration
AIRFLOW_DB_USER=airflow               # Airflow database user
AIRFLOW_DB_PASS=airflow_pass          # Airflow database password
AIRFLOW_DB_NAME=airflow               # Airflow database name
AIRFLOW_DB_PORT=5432                  # Database port
AIRFLOW_DB_HOST=postgres              # Database hostname
AIRFLOW_DB_SCHEME=postgresql+psycopg2 # Database connection scheme

# Airflow App Configuration
AIRFLOW_MOUNT_DIR_PLUGINS=/path/to/plugins  # Plugins directory
AIRFLOW_MOUNT_DIR_DAGS=/path/to/dags       # DAGs directory
AIRFLOW_MOUNT_DIR_LOGS=/path/to/logs       # Logs directory
AIRFLOW_PUBLIC_URL=http://localhost:8080    # Public URL
AIRFLOW_WEB_PORT=8080                      # Web interface port
AIRFLOW_CORE_EXECUTOR=LocalExecutor         # Executor type

# Airflow Admin User
AIRFLOW_ADMIN_USER=admin                    # Admin username
AIRFLOW_ADMIN_FIRSTNAME=Admin               # Admin first name
AIRFLOW_ADMIN_LASTNAME=User                 # Admin last name
AIRFLOW_ADMIN_ROLE=Admin                    # Admin role
AIRFLOW_ADMIN_EMAIL=admin@example.com       # Admin email
AIRFLOW_ADMIN_PASS=admin                    # Admin password
```

## Usage

### Starting the Application

```sh
# From the airflow directory
docker-compose up -d

# Or from the parent directory
make start APPS="airflow"
```

### Accessing the Web Interface

The Airflow UI will be available at:
```
http://your-server-ip:AIRFLOW_WEB_PORT
```

### Creating Your First DAG

1. Place your DAG file in the configured DAGs directory
2. Wait for the scheduler to pick up the new DAG
3. Enable the DAG in the web interface

## Maintenance

### Database Backups

```sh
docker exec airflow_postgres pg_dump -U postgres airflow > airflow_backup.sql
```

### Log Management

- Regularly rotate logs to prevent disk space issues
- Monitor the logs directory size
- Configure log retention in airflow.cfg

## Troubleshooting

### Common Issues

- **Scheduler Not Running**: Check scheduler container logs
- **DAGs Not Appearing**: Verify DAG file permissions and syntax
- **Database Connection Issues**: Check database credentials and connectivity

### Logs

```sh
# View webserver logs
docker logs airflow_webserver

# View scheduler logs
docker logs airflow_scheduler

# View database logs
docker logs airflow_postgres
```

## Additional Resources

- [Apache Airflow Documentation](https://airflow.apache.org/docs/)
- [Airflow GitHub](https://github.com/apache/airflow)
- [Main Repository README](../README.md)
