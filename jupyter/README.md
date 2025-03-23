# Jupyter Notebook

## Overview
Jupyter Notebook is an open-source web application that allows you to create and share documents that contain live code, equations, visualizations, and narrative text. This Docker setup provides a Jupyter environment for data science, machine learning, and scientific computing.

## Setup Instructions

### Prerequisites
- Docker and Docker Compose installed on your system
- Basic understanding of Python and Jupyter

### Quick Start
1. Configure your environment variables in the `.env` file
2. Run the application:
```sh
docker-compose up -d
```

### Environment Variables
- `JUPYTER_PORT`: External port for accessing the Jupyter interface (default: 8888)
- `JUPYTER_DATA`: Path to store Jupyter notebooks and data
- `JUPYTER_TOKEN`: Authentication token for accessing Jupyter (set to a secure value)
- `JUPYTER_PASSWORD`: Optional password instead of token

## Usage
- Access Jupyter at `http://your-server-ip:JUPYTER_PORT`
- Enter the token or password when prompted
- Create new notebooks or open existing ones
- Install additional Python packages as needed using conda or pip

## Troubleshooting
- Memory issues might require adjusting Docker resource limits
- Package installation problems could be related to permission issues
- For kernel connection problems, try restarting the notebook server

## Further Resources
- [Official Jupyter Documentation](https://jupyter.org/documentation)
- [Return to Main Documentation](../README.md)
