#!/bin/bash -eux
source $(dirname $0)/utils.sh
sudo docker run -d --restart=always -p 8800:8080 --name rancher localhost:5000/rancher/server
wait_for_service 8800
echo "Creating a registration token"
wait_for_service 8800 /v1/registrationtokens
wget --post-data="" "http://localhost:8800/v1/registrationtokens?projectId=1a5" || true