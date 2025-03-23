# AdGuard Home

AdGuard Home is a network-wide software for blocking ads and tracking. After you configure it, it'll cover all your home devices without requiring any client-side software.

## Overview

This deployment includes:
- AdGuard Home DNS server
- Web interface for management
- DNS and DHCP server capabilities

## Configuration

### Environment Variables

Copy the template.env to .env:

```sh
cp template.env .env
```

Edit the .env file with your configuration:

```
ADGUARD_CONF_MOUNT_DIR=/mnt/external_hdd/adguard/conf   # Configuration directory
ADGUARD_WORK_MOUNT_DIR=/mnt/external_hdd/adguard/work   # Working directory
ADGUARD_WEBUI_PORT=3000                                 # Web interface port
ADGUARD_DNS_PORT=53                                     # DNS server port
```

### Network Configuration

- Ensure port 53 (DNS) is available on your host
- Configure your router to use AdGuard Home as the DNS server
- For DHCP server functionality, additional network configuration may be required

## Usage

### Starting the Application

```sh
# From the adguardhome directory
docker-compose up -d

# Or from the parent directory
make start APPS="adguardhome"
```

### Initial Setup

1. Access the web interface at `http://your-server-ip:3000`
2. Follow the setup wizard
3. Configure your DNS settings
4. Add your blocking lists

## Maintenance

### Updating Blocklists

- Regular updates occur automatically
- Manual updates can be triggered from the web interface
- Custom lists can be added in the Filters section

### Monitoring

- Check the Query Log for DNS activity
- Review Statistics for blocking effectiveness
- Monitor system resources usage

## Troubleshooting

### Common Issues

- **Port 53 Conflict**: Disable system resolved or other DNS services
- **Cannot Access Web UI**: Check firewall settings
- **Slow DNS Resolution**: Review upstream DNS servers

### Logs

```sh
docker logs adguard
```

## Additional Resources

- [AdGuard Home Documentation](https://github.com/AdguardTeam/AdGuardHome/wiki)
- [AdGuard Home GitHub](https://github.com/AdguardTeam/AdGuardHome)
- [Main Repository README](../README.md)
