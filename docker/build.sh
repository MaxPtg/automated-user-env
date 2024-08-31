#!/bin/bash

DOCKER_BUILDKIT=1 docker build --build-arg BUILDKIT_INLINE_CACHE=1 -t debian12-custom . && docker run -it --rm debian12-custom