#!/bin/bash
function wait_for_service {
	set +x
	echo -n "Waiting for service to go up on port $1."
    while [ -n "$(wget -O - -T 1 -t 1 http://localhost:$1${2-} 2>&1 | grep -i 'refused\|error\|no data')" ]
    do
       sleep 1
       echo -n "."
    done
    echo "Ok..."
    set -x
}