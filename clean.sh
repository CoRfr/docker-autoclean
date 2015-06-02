#!/bin/bash

# Old containers
for cnt in $(docker ps -a |grep '\-old-' | awk '{print $1}' ); do
    echo "Removing container $cnt"
    docker rm $cnt
done

# Partial images
for img in $(docker ps -a | awk '{print $2}' | grep -E "[a-z0-9]{12}" ); do
    cnt=$(docker ps -a | grep $img | awk '{print $1}' )
    echo "Removing container $cnt"
    docker rm $cnt
    echo "Removing $img ..."
    docker rmi $img
done

# Old images
for img in $(docker images -a | grep -v latest | grep -E "(weeks|months)" | awk '{print $3}' | sort | uniq); do
    echo "Removing $img ..."
    docker rmi $img
done

