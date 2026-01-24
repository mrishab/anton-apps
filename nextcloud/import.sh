docker exec -ti --user www-data nextcloud /var/www/html/occ files:scan --all
docker exec -ti --user www-data nextcloud /var/www/html/occ app:install duplicatefinder
docker exec -ti --user www-data nextcloud /var/www/html/occ duplicates:find-all