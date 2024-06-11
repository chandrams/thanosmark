#!/bin/bash

source .bingo/variables.env

function deploydir() {
    DIR=$1
    if [ -z "${DIR}" ]; then
        echo "dir missing"
    fi

    for f in `find "${DIR}" -type f -name "*.yaml"`
    do
        cat ${f} | ${GOMPLATE} | kubectl apply -f -
    done
}

function undeploydir() {
    DIR=$1
    if [ -z "${DIR}" ]; then
        echo "dir missing"
    fi


    for f in `find "${DIR}" -type f -name "*.yaml"`
    do
        cat ${f} | ${GOMPLATE} | kubectl delete -f -
    done    
}
