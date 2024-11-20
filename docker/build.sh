#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Building test container...${NC}"

# Ensure we're in the docker directory
cd "$(dirname "$0")"

# Clean up any existing containers and volumes
echo -e "${YELLOW}Cleaning up previous test environment...${NC}"
docker container prune -f
docker volume prune -f

# Build with BuildKit
DOCKER_BUILDKIT=1 docker build \
  --build-arg BUILDKIT_INLINE_CACHE=1 \
  --build-arg CACHE_DATE="$(date +%s)" \
  -t automated-user-env-test . && \
docker run -it --rm automated-user-env-test /bin/bash -c '/usr/local/bin/test-startup.sh; exec /bin/bash -l'

echo -e "${GREEN}Test container terminated.${NC}"
