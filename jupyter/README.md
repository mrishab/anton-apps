# Jupyter (JupyterLab)

JupyterLab is the next-generation interface for Jupyter Notebooks. This Docker setup provides a JupyterLab environment for data science, machine learning, and scientific computing.

## Setup Instructions

### Prerequisites
- Docker and Docker Compose installed on your system

### Quick Start
1. Configure your environment variables in the `.env` file
2. Run the application:
```sh
docker-compose up -d
```

### Environment Variables
- `JUPYTER_ENABLE_LAB`: Set to `yes` to enable JupyterLab interface (vs classic Notebook UI)
- `JUPYTER_WEB_UI_PORT`: Host port for accessing the interface (default: `2705`; container port is `8888`)
- `USER_HOME_MOUNT_DIR`: Persistent home directory path on the host (mounted to `/home/jovyan`)
- `JUPYTER_TOKEN`: Authentication token for secure access

## Usage
- Access JupyterLab at `http://your-server-ip:JUPYTER_WEB_UI_PORT`
- Enter the `JUPYTER_TOKEN` when prompted
- Create new notebooks or open existing ones from the persistent volume
- Install additional Python packages as needed using `conda` or `pip` within a notebook

## Troubleshooting
- Memory issues might require adjusting Docker resource limits
- Package installation problems could be related to permission issues with the mounted volume
- For kernel connection problems, try restarting the notebook server

## Further Resources
- [Official JupyterLab Documentation](https://jupyterlab.readthedocs.io/)
- [Return to Main Documentation](../README.md)
