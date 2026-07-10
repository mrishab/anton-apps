HOST=anton
HOST_APP_DIR:=/var/server/anton/reverse-proxy

setup-subdomain:
	ssh ${HOST} "cd ${HOST_APP_DIR} && make subdomain-1-cert-setup SUBDOMAIN=${SUBDOMAIN} && make restart"

cert-renew:
	docker compose run --rm certbot renew

subdomain-1-cert-setup:
	docker compose run --rm  certbot certonly --webroot --webroot-path /var/www/certbot/ -d ${SUBDOMAIN}.cloudville.me

subdomain-2-cert-setup:
	docker compose run --rm  certbot certonly --webroot --webroot-path /var/www/certbot/ -d ${SUBDOMAIN}.rishabmanocha.com

domain-1-cert-setup:
	docker compose run --rm  certbot certonly --webroot --webroot-path /var/www/certbot/ -d cloudville.me

domain-2-cert-setup:
	docker compose run --rm  certbot certonly --webroot --webroot-path /var/www/certbot/ -d rishabmanocha.com

domain-3-cert-setup:
	docker compose run --rm  certbot certonly --webroot --webroot-path /var/www/certbot/ -d wezeon.com


subdmain-1-delete-cert:
	docker compose run --rm certbot delete --cert-name ${SUBDOMAIN}.cloudville.me

init-certs:
	ssh ${HOST} "cd ${HOST_APP_DIR} && ./init-certs.sh"

delete-cert:
	docker compose run --rm certbot delete --cert-name mrishab.io
	docker compose run --rm certbot delete --cert-name ghost.mrishab.io