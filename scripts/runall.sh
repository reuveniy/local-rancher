#!/bin/bash -eu
cd /vagrant/scripts || true
for f in $(ls [0-9]*.sh | sort); do chmod +x $f; echo $f; ./$f; done