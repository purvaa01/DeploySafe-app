#!/bin/bash

set -e
LOCAL_PORT=8090
ACTIVE=$1

kubectl port-forward service/deploysafe-service $LOCAL_PORT:80 -n deploysafe >/tmp/pf.log 2>&1 &
PF_PID=$!

cleanup() {
    if ps -p $PF_PID > /dev/null 2>&1; then
        kill $PF_PID
    fi
}

trap cleanup EXIT

sleep 5

STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$LOCAL_PORT/health)

if [ "$STATUS" != "200" ]; then
    echo "Health check failed."

    ./scripts/rollback.sh "$ACTIVE"

    exit 1
fi

echo "Health check passed."