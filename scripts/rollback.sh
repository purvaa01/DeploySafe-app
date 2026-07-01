#!/bin/bash

set -e

ACTIVE=$1

echo "Rolling back traffic to $ACTIVE..."

kubectl patch service deploysafe-service \
-n deploysafe \
-p "{\"spec\":{\"selector\":{\"app\":\"deploysafe\",\"version\":\"$ACTIVE\"}}}"

echo "Rollback completed."
