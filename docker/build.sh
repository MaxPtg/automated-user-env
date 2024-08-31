#!/bin/bash

DOCKER_BUILDKIT=1 docker build \
  --build-arg BUILDKIT_INLINE_CACHE=1 \
  -t deb12-test-container . && \
docker run -it --rm deb12-test-container
