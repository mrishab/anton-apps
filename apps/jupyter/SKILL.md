---
name: update-jupyter
description: "Procedure for updating Jupyter (PyTorch notebook) Docker container."
---

# Update Jupyter

## How to update

1. Check latest Jupyter Docker stacks at https://quay.io/repository/jupyter/pytorch-notebook
2. Update `image: quay.io/jupyter/pytorch-notebook:cuda12-conda-YYYY.M.N` in `docker-compose.yml`
3. `docker compose pull && docker compose up -d`

## Notes

- User work files are in `${USER_HOME_MOUNT_DIR}` — mounted to `/home/jovyan/work`
- Token auth persists via `${JUPYTER_TOKEN}` env var
- GPU (CUDA) support is configured with NVIDIA container toolkit
- The `cuda12-conda` flavor includes CUDA 12 + conda-based Python packages
- Verify GPU access after upgrade: `nvidia-smi` inside a notebook
