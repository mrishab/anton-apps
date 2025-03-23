# Affine

Affine is an open-source knowledge base and collaboration platform that provides a clean, modern interface for notes, documents, and knowledge management.

## Overview

This deployment includes:
- Affine GraphQL server
- PostgreSQL database
- Redis for caching
- Email notification support
- Member limit customizations

## Configuration

### Environment Variables

Copy the template.env to .env:

```sh
cp template.env .env
```

Edit the .env file with your configuration:

```
# Affine Version
AFFINE_REVISION=stable                             # stable, beta, or canary

# Server Configuration
PORT=3010                                          # Web interface port
AFFINE_SERVER_HOST=affine.example.com              # Public hostname
AFFINE_SERVER_HTTPS=true                           # Set to true if using HTTPS

# Storage Locations
DB_DATA_LOCATION=/mnt/external_hdd/affine/db       # Database storage
UPLOAD_LOCATION=/mnt/external_hdd/affine/app/uploads  # File uploads
CONFIG_LOCATION=/mnt/external_hdd/affine/app/config   # Configuration files

# Email Settings (for notifications)
MAILER_HOST=smtp.gmail.com                         # SMTP server
MAILER_PORT=587                                    # SMTP port
MAILER_USER=your_email@gmail.com                   # Email address
MAILER_PASSWORD=your_app_password                  # App password
MAILER_SENDER=your_email@gmail.com                 # Sender email
MAILER_SECURE=false                                # TLS setting

# Database Credentials
DB_USERNAME=affine                                 # Database username
DB_PASSWORD=secure_password                        # Database password
DB_DATABASE=affine                                 # Database name
```

### Data Directories

Ensure proper permissions on the mount directories:

```sh
sudo mkdir -p /mnt/external_hdd/affine/{db,app/uploads,app/config}
sudo chown -R 1000:1000 /mnt/external_hdd/affine
```

## Usage

### Starting the Application

```sh
# From the affine directory
docker-compose up -d

# Or from the parent directory
make start APPS="affine"
```

### Accessing the Application

After starting the container, access Affine at:

```
http://your-server-ip:PORT
```

### Initial Setup

1. Access the web interface and create an initial admin account
2. Set up workspaces for your projects or teams
3. Invite members to collaborate

## Advanced Configuration

### Extending Member Limits

To increase the default member limit of 3 for all users:

```sh
# Connect to PostgreSQL
docker exec -ti affine_postgres psql -U affine

# Run this SQL query
UPDATE features 
SET configs = jsonb_set(configs::jsonb, '{memberLimit}', '10')
WHERE configs::jsonb ? 'memberLimit';
```

### Extending Document History Retention

To extend the document history period to 365 days:

```sql
UPDATE features
SET configs = jsonb_set(configs::jsonb, '{historyPeriod}', '31536000000')
WHERE configs::jsonb ? 'historyPeriod';
```

## Maintenance

### Database Backup

```sh
docker exec -t affine_postgres pg_dump -U affine affine > affine_backup.sql
```

### Updates

To update to the latest version:

1. Update the AFFINE_REVISION in your .env file
2. Restart the containers:
   ```sh
   docker-compose down && docker-compose up -d
   ```

## Troubleshooting

### Common Issues

- **Email Sending Fails**: Verify SMTP settings and app password
- **Database Connection Errors**: Check database container is running
- **Upload Failures**: Check permissions on upload directory

### Logs

```sh
# View server logs
docker logs affine_server

# View database logs
docker logs affine_postgres

# View Redis logs
docker logs affine_redis
```

## Additional Resources

- [Affine Documentation](https://docs.affine.pro/)
- [Affine GitHub](https://github.com/toeverything/AFFiNE)
- [Main Repository README](../README.md)
