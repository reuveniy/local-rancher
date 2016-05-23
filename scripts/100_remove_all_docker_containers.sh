#!/bin/bash -eu
sudo docker ps -a | awk '{ print $1 }' | grep -v CONTAINER | xargs sudo docker rm -f || true