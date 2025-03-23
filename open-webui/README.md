# Open-WebUI

Open-WebUI is a user-friendly web interface designed for Ollama and other AI models, providing a ChatGPT-like experience for open-source models.

## Overview

This deployment includes:
- Open-WebUI server connected to Ollama
- Persistent storage for conversations and settings
- User interface for interacting with AI models

## Configuration

### Environment Variables

Copy the template.env to .env:

```sh
cp template.env .env
```

Edit the .env file with your configuration:

```
OPEN_WEBUI_MOUNT_DIR=/mnt/external_hdd/open-webui    # Persistent data directory
OPEN_WEBUI_WEB_PORT=3000                             # Web interface port
OLLAMA_BASE_URL=http://ollama:11434                  # URL to Ollama instance
```

### Prerequisites

- Running Ollama instance (can be set up from the [ollama](../ollama) folder in this repository)
- At least one model loaded in Ollama
- Networking that allows Open-WebUI to connect to Ollama

## Usage

### Starting the Application

```sh
# From the open-webui directory
docker-compose up -d

# Or from the parent directory
make start APPS="open-webui"
```

### Accessing the Web Interface

After starting the container, access the Open-WebUI interface at:

```
http://your-server-ip:OPEN_WEBUI_WEB_PORT
```

### Setting Up Models

1. Ensure models are already loaded in Ollama
2. Log in to Open-WebUI (create an account on first access)
3. Navigate to the Models section to see available models
4. Start a conversation with your desired model

## Maintenance

### Data Management

- Conversation history and settings are stored in the mount directory
- Regularly back up this directory to preserve your data
- Clear browser cache if you experience UI issues

### Updates

Keep the container up to date for new features and security updates:

```sh
docker-compose pull
docker-compose up -d
```

## Troubleshooting

### Common Issues

- **Cannot Connect to Ollama**: Verify OLLAMA_BASE_URL is correct and Ollama is running
- **Models Not Showing**: Check if models are properly loaded in Ollama
- **Slow Responses**: Large models may require more powerful hardware

### Logs

```sh
docker logs open-webui
```

## Integration with Ollama

For the best experience, start both Ollama and Open-WebUI:

```sh
make start APPS="ollama open-webui"
```

This ensures proper communication between the services.

## Additional Resources

- [Open-WebUI GitHub](https://github.com/open-webui/open-webui)
- [Ollama Documentation](https://github.com/ollama/ollama)
- [Main Repository README](../README.md)
