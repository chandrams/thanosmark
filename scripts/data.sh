#!/bin/bash
. ./scripts/util.sh

export $(grep -v '^#' .env | xargs)

while test $# -gt 0; do
    case "$1" in
    --profile*)
        export PROFILE=$(echo $1 | sed -e 's/^[^=]*=//g')
        shift
        ;;
    -d | --deploy)
        shift
        deploydir "./manifests/data"
        shift
        ;;
    -ud | --undeploy)
        shift
        undeploydir "./manifests/data"
        shift
        ;;
    *)
        break
        ;;
    esac
done
