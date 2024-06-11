#!/bin/bash
. ./scripts/util.sh

export $(grep -v '^#' .env | xargs)

while test $# -gt 0; do
    case "$1" in
    -d | --deploy)
        shift
        deploydir "./manifests/objstore"
        shift
        ;;
    -ud | --undeploy)
        shift
        undeploydir "./manifests/objstore"
        shift
        ;;
    *)
        break
        ;;
    esac
done
