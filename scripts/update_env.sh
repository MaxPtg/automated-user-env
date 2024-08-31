#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}Updating user environment...${NC}"

# Pull latest changes
git pull

# Run the update playbook
ansible-playbook -i ../ansible/inventory.yml ../ansible/playbooks/main_update.yml

echo -e "${GREEN}Update complete!${NC}"
echo -e "${GREEN}Source your users .bashrc file in order for the changes to take effect.${NC}"
echo -e "${GREEN}> source ~/.bashrc${NC}"
