HOST=anton
HOST_APP_DIR:=/var/server/anton/apps/reverse-proxy

setup-subdomain:
	ssh ${HOST} "cd ${HOST_APP_DIR} && make subdomain-1-cert-setup SUBDOMAIN=${SUBDOMAIN} && make restart"

cert-renew:
	docker compose run --rm certbot renew

subdomain-1-cert-setup:
	docker compose run --rm  certbot certonly --webroot --webroot-path /var/www/certbot/ -d ${SUBDOMAIN}.<your-domain>

subdomain-2-cert-setup:
	docker compose run --rm  certbot certonly --webroot --webroot-path /var/www/certbot/ -d ${SUBDOMAIN}.<your-personal-domain>

domain-1-cert-setup:
	docker compose run --rm  certbot certonly --webroot --webroot-path /var/www/certbot/ -d <your-domain>

domain-2-cert-setup:
	docker compose run --rm  certbot certonly --webroot --webroot-path /var/www/certbot/ -d <your-personal-domain>


subdmain-1-delete-cert:
	docker compose run --rm certbot delete --cert-name ${SUBDOMAIN}.<your-domain>

init-certs:
	ssh ${HOST} "cd ${HOST_APP_DIR} && ./init-certs.sh"

delete-cert:
	docker compose run --rm certbot delete --cert-name <your-other-domain>
	docker compose run --rm certbot delete --cert-name ghost.<your-other-domain>