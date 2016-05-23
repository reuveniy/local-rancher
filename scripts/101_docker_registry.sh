#!/bin/bash -eux
source $(dirname $0)/utils.sh
sudo docker run -p 5000:5000 -v /vagrant/docker-registry:/var/lib/registry -d --name registry registry:2
wait_for_service 5000

