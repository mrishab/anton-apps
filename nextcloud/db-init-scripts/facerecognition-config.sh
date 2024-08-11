#!/bin/bash

## Run these commands on the nextcloud server once to set up configuration
## for the facerecognition app

docker exec -ti -u www-data nextcloud php occ face:setup -M 2048M \
&& docker exec -ti -u www-data nextcloud php occ face:setup -m 1 \
&& docker exec -ti -u www-data nextcloud php occ config:app:set facerecognition default_enabled --value true \
&& docker exec -ti -u www-data nextcloud php occ config:app:set facerecognition clustering_batch_size --value='1000' --type=integer \
&& docker exec -ti -u www-data nextcloud php occ config:app:set facerecognition max_image_area --value 786432 \
&& docker exec -ti -u www-data nextcloud php occ config:app:set facerecognition handle_external_files --value true \
&& docker exec -ti -u www-data nextcloud php occ config:app:set facerecognition handle_shared_files --value false \
&& docker exec -ti -u www-data nextcloud php occ config:app:set facerecognition min_image_size --value 128
