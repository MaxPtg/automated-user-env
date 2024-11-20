#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}Starting test environment...${NC}"

# Clone the repository
echo -e "${YELLOW}Cloning automated-user-env repository...${NC}"
git clone https://github.com/MaxPtg/automated-user-env /home/testuser/automated-user-env

# Run initial setup with forced interactive mode
echo -e "${YELLOW}Running initial setup...${NC}"
cd /home/testuser/automated-user-env/scripts
ANSIBLE_FORCE_INTERACTIVE=1 bash initial_setup.sh

# Source the updated configuration
source /home/testuser/.bashrc

# Verify installation
echo -e "${YELLOW}Verifying installation...${NC}"

verify_path() {
    if [ -e "$1" ]; then
        echo -e "${GREEN}✓ Found: $1${NC}"
        ls -la "$1"
    else
        echo -e "${RED}✗ Missing: $1${NC}"
        return 1
    fi
}

echo -e "\nChecking system-wide oh-my-bash installation:"
verify_path "/usr/local/share/oh-my-bash"

echo -e "\nChecking custom theme installation:"
verify_path "/usr/local/share/oh-my-bash/custom/themes/luan"

echo -e "\nChecking user configuration:"
verify_path "/home/testuser/.automated-user-env"

echo -e "\nChecking if oh-my-bash environment variables are set:"
echo "OSH=$OSH"
echo "OSH_CUSTOM=$OSH_CUSTOM"

echo -e "${GREEN}Test environment ready for inspection.${NC}"
echo -e "${YELLOW}You can now manually inspect the environment.${NC}"
echo -e "${YELLOW}The shell will remain active for testing.${NC}"
