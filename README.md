# Home Server Setup

For each application that you'd like to use:

1) Open the application's root directory.
2) Rename the `template.env` file to `.env`.
3) Replace the placeholder values with the values of your choice.
4) For the values that relate to the external directory mount, make sure the directory already exist and the owner UID/GID is set to the same as the docker process's UID.
5) Run `make reset APPS="app1 app2 app3".
