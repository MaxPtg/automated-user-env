#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Parse command line arguments
LOCAL_MODE=false
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --local) LOCAL_MODE=true ;;
        *) echo "Unknown parameter: $1"; exit 1 ;;
    esac
    shift
done

echo -e "${YELLOW}Building test container...${NC}"

# Ensure we're in the docker directory
cd "$(dirname "$0")"

# Clean up any existing containers and volumes
echo -e "${YELLOW}Cleaning up previous test environment...${NC}"
docker container prune -f
docker volume prune -f

# Create build context directory
BUILD_CONTEXT="build_context"
rm -rf $BUILD_CONTEXT
mkdir -p $BUILD_CONTEXT

# Copy Dockerfile and test-startup.sh
cp Dockerfile $BUILD_CONTEXT/
cp test-startup.sh $BUILD_CONTEXT/

if [ "$LOCAL_MODE" = true ]; then
    echo -e "${YELLOW}Running in local mode - copying local files...${NC}"
    # Create automated-user-env directory and copy local files
    mkdir -p $BUILD_CONTEXT/automated-user-env
    cp -r ../ansible $BUILD_CONTEXT/automated-user-env/
    cp -r ../configs $BUILD_CONTEXT/automated-user-env/
    cp -r ../scripts $BUILD_CONTEXT/automated-user-env/
    # Modify test-startup.sh for local mode
    sed -i 's|git clone.*automated-user-env|cp -r /automated-user-env /home/testuser/|' $BUILD_CONTEXT/test-startup.sh
fi

# Build with BuildKit
DOCKER_BUILDKIT=1 docker build \
  --build-arg BUILDKIT_INLINE_CACHE=1 \
  --build-arg CACHE_DATE="$(date +%s)" \
  -t automated-user-env-test $BUILD_CONTEXT

# Run the container with the appropriate volume mount
if [ "$LOCAL_MODE" = true ]; then
    docker run -it --rm \
        -v "$(pwd)/$BUILD_CONTEXT/automated-user-env:/automated-user-env:ro" \
        automated-user-env-test /bin/bash -c '/usr/local/bin/test-startup.sh; exec /bin/bash -l'
else
    docker run -it --rm \
        automated-user-env-test /bin/bash -c '/usr/local/bin/test-startup.sh; exec /bin/bash -l'
fi

# Cleanup
echo -e "${YELLOW}Cleaning up build context...${NC}"
rm -rf $BUILD_CONTEXT

echo -e "${GREEN}Test container terminated.${NC}"
