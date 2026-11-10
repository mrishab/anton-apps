HOST=anton
HOST_APP_DIR:=/var/server/anton/apps/reverse-proxy
DOMAIN_1=cloudville.me
DOMAIN_2=rishabmanocha.com

start:
	docker compose up -d

stop:
	docker compose down

restart: stop start

setup-subdomain:
	ssh ${HOST} "cd ${HOST_APP_DIR} && make subdomain-1-cert-setup SUBDOMAIN=${SUBDOMAIN} && make restart"

cert-renew:
	docker compose run --rm certbot renew

subdomain-1-cert-setup:
	docker compose run --rm  certbot certonly --webroot --webroot-path /var/www/certbot/ -d ${SUBDOMAIN}.${DOMAIN_1}

subdomain-2-cert-setup:
	docker compose run --rm  certbot certonly --webroot --webroot-path /var/www/certbot/ -d ${SUBDOMAIN}.${DOMAIN_2}

domain-1-cert-setup:
	docker compose run --rm  certbot certonly --webroot --webroot-path /var/www/certbot/ -d ${DOMAIN_1}

domain-2-cert-setup:
	docker compose run --rm  certbot certonly --webroot --webroot-path /var/www/certbot/ -d ${DOMAIN_2}


subdomain-1-delete-cert:
	docker compose run --rm certbot delete --cert-name ${SUBDOMAIN}.${DOMAIN_1}

subdmain-1-delete-cert: subdomain-1-delete-cert

subdomain-2-delete-cert:
	docker compose run --rm certbot delete --cert-name ${SUBDOMAIN}.${DOMAIN_2}

domain-2-delete-cert:
	docker compose run --rm certbot delete --cert-name ${DOMAIN_2}

init-certs:
	ssh ${HOST} "cd ${HOST_APP_DIR} && ./init-certs.sh"

delete-cert:
	# Remove this target or update with actual cert names from DOMAIN_1 / DOMAIN_2
