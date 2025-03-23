# Ollama

Ollama is a lightweight, self-hosted large language model (LLM) server that allows you to run open-source LLMs locally on your hardware.

## Overview

This deployment includes:
- Ollama server with GPU support (via NVIDIA CUDA)
- Persistent storage for models and data

## Configuration

### Environment Variables

Copy the template.env to .env:

```sh
cp template.env .env
```

Edit the .env file with your configuration:

```
OLLAMA_MOUNT_DIR=/mnt/external_hdd/ollama  # Directory for storing models and data
OLLAMA_WEB_PORT=11434                      # Port for API access
```

### Hardware Requirements

- **CPU**: 4+ cores recommended
- **RAM**: 8GB minimum, 16GB+ recommended for larger models
- **Storage**: 10GB+ for each model you plan to use
- **GPU**: NVIDIA GPU with CUDA support (optional but recommended)

### NVIDIA GPU Support

Ensure you have installed:
- NVIDIA drivers
- NVIDIA Container Toolkit

Verify with:
```sh
make check-nvidia
```

## Usage

### Starting the Application

```sh
# From the ollama directory
docker-compose up -d

# Or from the parent directory
make start APPS="ollama"
```

### Using Ollama

Once running, you can download and use models with:

```sh
# Via API
curl http://localhost:11434/api/generate -d '{
  "model": "llama2",
  "prompt": "Hello, I am a language model"
}'

# Via the Ollama CLI (if installed locally)
ollama run llama2
```

### Available Models

Some popular models you can pull:
- `llama2`
- `mistral`
- `vicuna`
- `codellama`
- `orca-mini`

Pull a model with:
```sh
curl http://localhost:11434/api/pull -d '{"name": "llama2"}'
```

## Integration with Open-WebUI

Ollama works seamlessly with Open-WebUI, which is also available in this repository:

1. Set up Open-WebUI with:
   ```
   OLLAMA_BASE_URL=http://ollama:11434
   ```
   
2. Start both services:
   ```
   make start APPS="ollama open-webui"
   ```

## Maintenance

### Managing Models

List all downloaded models:
```sh
curl http://localhost:11434/api/tags
```

Remove a model:
```sh
curl http://localhost:11434/api/delete -d '{"name": "llama2"}'
```

### Resource Management

Monitor GPU usage with:
```sh
nvidia-smi
```

## Troubleshooting

### Common Issues

- **GPU Not Detected**: Check NVIDIA Container Toolkit is properly installed
- **Out of Memory**: Try a smaller model or reduce context window size
- **Slow Performance**: Consider using a quantized model (e.g., `llama2:7b-q4_0`)

### Logs

```sh
docker logs ollama
```

## Additional Resources

- [Ollama Documentation](https://github.com/ollama/ollama)
- [Model Library](https://ollama.ai/library)
- [Main Repository README](../README.md)
