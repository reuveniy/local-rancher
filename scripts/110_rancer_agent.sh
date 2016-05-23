#!/bin/bash -eux
source $(dirname $0)/utils.sh
wait_for_service 8800 /v1/registrationtokens

TOKEN=""
while [ -z "{$TOKEN}" ]; do
   TOKEN="$(wget "http://localhost:8800/v1/registrationtokens?projectId=1a5" -O - | tr '"' '\n' | grep ^token -A3 | head -3 | tail -1)"
   if [ "${TOKEN}" != "transitioning" ]; then TOKEN=""; fi
done

RANCHER_SERVER_IP="$(ifconfig | grep "inet addr" | grep -v "172.17" | grep -v "127.0.0" | tr ':' ' ' | awk '{ print $3 }')"

echo "Registration token: ${RANCHER_SERVER_IP}/${TOKEN}"
sudo docker run -d --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/rancher:/var/lib/rancher localhost:5000/rancher/agent:v1.0.1 http://${RANCHER_SERVER_IP}:8800/v1/scripts/${TOKEN}
