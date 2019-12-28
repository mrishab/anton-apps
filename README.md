# Home Server Setup

This project contains a docker-compose.yml configuration to start-up all the docker containers on the home server.

# Prerequisites

## 1) Environment Variables

The following environment variables need to be setup before executing the `docker-compose up -d` command:

1) `PLEX_CLAIM`
2) `SAMBA_PASSWORD`

## 2) Setup the volumes

### Mounting external drive

1) Attach the external driver physically through the USB port.
2) Find the device in `/dev/sd*`.
3) As a root user, create the directory structure `/media/external/wd_hdd`.

### Samba Server Volume
1) Execute the `docker-compose up` command to run all the containers, including the `samba` server container.
2) This will create a volume for samba server, like, `serversetup_samba`.
3) Stop all the containers using the `CTRL+C` key combination, followed by `docker-compose down` command.
4) Run `sudo su` to switch to root user.
5) Navigate to the `samba` server's docker volume directory: `/var/lib/docker/volumes/{container_name}/`.
6) In this directory, there will be a directory named, `_data`. Remove it by running: `rmdir _data`.
7) Create a soft link to the desired directory and name it as `_data` by running: `ln -s /path/to/dir/ _data`.

# Running the containers.

To start up all the containers, go to the directory containing the `docker-compose.yml` file and execute `docker-compose up -d` command.
