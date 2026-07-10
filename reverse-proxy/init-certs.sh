# For cert-setup, the nginx needs to be started without reverse-proxy.conf.template file.
mv static/etc/nginx/templates/reverse-proxy.conf.template static/etc/nginx/templates/reverse-proxy.conf.template.bak &&\
make restart &&\

make domain-1-cert-setup &&\

make subdomain-1-cert-setup SUBDOMAIN=brewcraft &&\
make subdomain-1-cert-setup SUBDOMAIN=jenkins &&\
make subdomain-1-cert-setup SUBDOMAIN=nextcloud &&\
make subdomain-1-cert-setup SUBDOMAIN=nexus &&\
make subdomain-1-cert-setup SUBDOMAIN=pgadmin &&\
make subdomain-1-cert-setup SUBDOMAIN=registry &&\
make subdomain-1-cert-setup SUBDOMAIN=adguardhome &&\
make subdomain-1-cert-setup SUBDOMAIN=wikijs &&\
make subdomain-1-cert-setup SUBDOMAIN=vscode &&\
make subdomain-1-cert-setup SUBDOMAIN=airflow &&\
make subdomain-1-cert-setup SUBDOMAIN=deluge &&\
make subdomain-1-cert-setup SUBDOMAIN=nzbget &&\
make subdomain-1-cert-setup SUBDOMAIN=prowlarr &&\
make subdomain-1-cert-setup SUBDOMAIN=sonarr &&\
make subdomain-1-cert-setup SUBDOMAIN=lidarr &&\
make subdomain-1-cert-setup SUBDOMAIN=radarr &&\
make subdomain-1-cert-setup SUBDOMAIN=bazarr &&\
make subdomain-1-cert-setup SUBDOMAIN=plex &&\
make subdomain-1-cert-setup SUBDOMAIN=duplicati &&\
make subdomain-1-cert-setup SUBDOMAIN=lazylibrarian &&\
make subdomain-1-cert-setup SUBDOMAIN=kibana &&\
make subdomain-1-cert-setup SUBDOMAIN=rss &&\
make subdomain-1-cert-setup SUBDOMAIN=grafana &&\
make subdomain-1-cert-setup SUBDOMAIN=tautulli &&\
make subdomain-1-cert-setup SUBDOMAIN=ombi &&\
make subdomain-1-cert-setup SUBDOMAIN=jupyter &&\
make subdomain-1-cert-setup SUBDOMAIN=brewcraftdev &&\
make subdomain-1-cert-setup SUBDOMAIN=sonarqube &&\
make subdomain-1-cert-setup SUBDOMAIN=calibre &&\
make subdomain-1-cert-setup SUBDOMAIN=calibre-web &&\
make subdomain-1-cert-setup SUBDOMAIN=sftpgo &&\
make subdomain-1-cert-setup SUBDOMAIN=ovpn &&\
make subdomain-1-cert-setup SUBDOMAIN=ollama &&\
make subdomain-1-cert-setup SUBDOMAIN=open-webui &&\
make subdomain-1-cert-setup SUBDOMAIN=postiz &&\
make subdomain-1-cert-setup SUBDOMAIN=immich &&\
make subdomain-1-cert-setup SUBDOMAIN=affine &&\
make subdomain-1-cert-setup SUBDOMAIN=n8n &&\
make subdomain-1-cert-setup SUBDOMAIN=threadfin &&\
make subdomain-1-cert-setup SUBDOMAIN=epg &&\
make subdomain-1-cert-setup SUBDOMAIN=upsnap &&\
make subdomain-1-cert-setup SUBDOMAIN=jellyfin &&\
make subdomain-1-cert-setup SUBDOMAIN=bentopdf &&\
make subdomain-1-cert-setup SUBDOMAIN=stirlingpdf &&\
make subdomain-1-cert-setup SUBDOMAIN=homarr &&\

make domain-2-cert-setup &&\
make subdomain-2-cert-setup SUBDOMAIN=ghost &&\

make domain-3-cert-setup &&\


mv static/etc/nginx/templates/reverse-proxy.conf.template.bak static/etc/nginx/templates/reverse-proxy.conf.template &&\
make restart
