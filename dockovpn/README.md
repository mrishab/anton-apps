# DockOVPN

DockOVPN is a containerized OpenVPN server that provides a simple, secure way to set up a VPN server in Docker.

## Overview

This deployment includes:
- OpenVPN server with UDP protocol
- Web server for client configuration distribution
- Simple client management

## Configuration

### Environment Variables

Copy the template.env to .env:

```sh
cp template.env .env
```

Edit the .env file with your configuration:

```
VPN_PORT=1194                              # VPN server port
WEB_PORT=8080                              # Web UI port for config download
HOST_ADDR=vpn.example.com                  # Your server's domain or IP address
HOST_CONF_PORT=8080                        # Port for config file distribution
```

### Network Configuration

- Ensure your firewall allows traffic on the VPN_PORT (UDP)
- If using a domain name, make sure DNS records are properly configured
- For remote access, set up port forwarding on your router to the VPN_PORT

## Usage

### Starting the Application

```sh
# From the dockovpn directory
docker-compose up -d

# Or from the parent directory
make start APPS="dockovpn"
```

### Accessing Client Configurations

After starting the container, access the client configuration at:

```
http://your-server-ip:WEB_PORT/
```

This page will allow you to download the OpenVPN client configuration file.

### Connecting Clients

1. Download the client configuration file from the web interface
2. Install an OpenVPN client on your device:
   - Windows/macOS: [OpenVPN Connect](https://openvpn.net/client/)
   - iOS/Android: OpenVPN Connect from app stores
   - Linux: `sudo apt install openvpn`
3. Import the configuration file into your OpenVPN client
4. Connect to the VPN

## Maintenance

### Managing Clients

- Each client uses the same configuration file by default
- For more advanced setups with unique client certificates, you may need to extend this container

### Security Considerations

- Regularly update the container image for security patches
- Consider implementing additional authentication mechanisms
- Review logs for unauthorized access attempts

## Troubleshooting

### Common Issues

- **Connection Failures**: Check firewall and port forwarding settings
- **DNS Issues**: Ensure proper DNS resolution for your HOST_ADDR
- **Client Compatibility**: Some older clients may have issues with certain encryption settings

### Logs

```sh
docker logs dockovpn
```

## Additional Resources

- [OpenVPN Documentation](https://openvpn.net/community-resources/how-to/)
- [DockOVPN GitHub](https://github.com/alekslitvinenk/openvpn)
- [Main Repository README](../README.md)
