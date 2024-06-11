#!/bin/bash

. ./scripts/util.sh

export $(grep -v '^#' .env | xargs)

while test $# -gt 0; do
    case "$1" in
    -sgwsd | --storegw-stress-deploy)
        shift
        deploydir "./manifests/storegw_storeapi_stress"
        shift
        ;;
    -sgwsud | --storegw-stress-undeploy)
        shift
        undeploydir "./manifests/storegw_storeapi_stress"
        shift
        ;;
    -qsd | --query-store-deploy)
        shift
        deploydir "./manifests/query_w_store"
        shift
        ;;
    -qsud | --query-store-undeploy)
        shift
        undeploydir "./manifests/query_w_store"
        shift
        ;;
    -rid | --receive-ingest-deploy)
        shift
        deploydir "./manifests/receive-ingest"
        shift
        ;;
    -riud | --receive-ingest-undeploy)
        shift
        undeploydir "./manifests/receive-ingest-avalanche"
        shift
        ;;
    -qrd | --query-receive-deploy)
        shift
        deploydir "./manifests/query_w_receive"
        shift
        ;;
    -qrud | --query-receive-undeploy)
        shift
        undeploydir "./manifests/query_w_receive"
        shift
        ;;
    -rsd | --receive-stress-deploy)
        shift
        deploydir "./manifests/receive_storeapi_stress"
        shift
        ;;
    -rsud | --receive-stree-undeploy)
        shift
        undeploydir "./manifests/receive_storeapi_stress"
        shift
        ;;

    *)
        break
        ;;
    esac
done

