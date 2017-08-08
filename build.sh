#!/bin/bash

rm -rf ./plugin

docker build -t rootfsimage .
id=$(docker create rootfsimage true) # id was cd851ce43a403 when the image was created
mkdir -p plugin/rootfs
docker export "$id" | tar -x -C plugin/rootfs
docker rm -vf "$id"
docker rmi rootfsimage
cp config.json ./plugin/

docker plugin disable ekristen/multilogger
docker plugin rm ekristen/multilogger
docker plugin create ekristen/multilogger ./plugin

rm -rf ./plugin
