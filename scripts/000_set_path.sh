#!/bin/bash -eux
if [[ "${PATH}" != *"/vagrant/bin"* ]]; then
   echo "export PATH=\"${PATH}:/vagrant/bin\"" | sudo tee /etc/environment
fi


