#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}Updating user environment...${NC}"

# Check if we're in the correct directory
if [[ ! -f ../ansible/inventory.yml ]]; then
    echo -e "${RED}Error: Please run this script from the scripts directory${NC}"
    exit 1
fi

# Pull latest changes
echo -e "${YELLOW}Pulling latest changes...${NC}"
git pull

# Check version and run update
echo -e "${YELLOW}Checking version...${NC}"
ansible-playbook -i ../ansible/inventory.yml ../ansible/playbooks/version_check.yml

echo -e "${YELLOW}Updating environment...${NC}"
ansible-playbook -i ../ansible/inventory.yml ../ansible/playbooks/main_update.yml

echo -e "${GREEN}Update complete!${NC}"
echo -e "${GREEN}Please log out and log back in for all changes to take effect.${NC}"
