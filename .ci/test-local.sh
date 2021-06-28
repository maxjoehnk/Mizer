#!/usr/bin/env bash
set -e
WORK_DIR=$PWD
cd "$(dirname "$0")"
docker build -t mizer-build:latest --target local .
docker run -it -v $WORK_DIR:/work -w /work mizer-build make build
