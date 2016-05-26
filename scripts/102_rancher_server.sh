#!/bin/bash -eux

REGISTRY_URL="localhost:5000/"
EXT_PORT="8800"
source $(dirname $0)/utils.sh
sudo docker run -d --restart=always -p ${EXT_PORT}:8080 \
    --name rancher \
    -e CATTLE_BOOTSTRAP_REQUIRED_IMAGE=${REGISTRY_URL}rancher/agent:v1.0.1 \
    -e CATTLE_AGENT_INSTANCE_IMAGE=${REGISTRY_URL}rancher/agent-instance:v0.8.1 \
    ${REGISTRY_URL}rancher/server

wait_for_service ${EXT_PORT}
echo "Creating a registration token"
wait_for_service ${EXT_POST} /v1/registrationtokens
wget --post-data="" "http://localhost:${EXT_PORT}/v1/registrationtokens?projectId=1a5" || true
