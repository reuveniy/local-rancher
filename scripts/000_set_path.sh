#!/bin/bash -eux
if [[ "${PATH}" != *"${HOME}/bin"* ]]; then
   echo 'export PATH=${PATH}:${HOME}/bin' | tee -a ~/.bashrc
fi
if [[ "${PATH}" != *"/vagrant/bin"* ]]; then
   echo 'export PATH=${PATH}:/vagrant/bin' | tee -a ~/.bashrc
fi

