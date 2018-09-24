#!/bin/bash

docker_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P ) # Pfad zum Script
docker build -t babelnode $docker_path