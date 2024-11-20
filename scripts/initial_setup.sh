#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Install Ansible
install_ansible() {
  if command_exists apt-get; then
    sudo apt-get update
    sudo apt-get install -y software-properties-common
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    sudo apt-get install -y ansible curl
  else
    echo -e "${RED}Unsupported package manager. Please install Ansible manually.${NC}"
    exit 1
  fi
}

# Main script
echo -e "${GREEN}Starting initial setup...${NC}"

# Check if Ansible is installed
if ! command_exists ansible; then
  echo "Ansible not found. Installing..."
  install_ansible
else
  echo "Ansible is already installed."
fi

# Check if curl is installed
if ! command_exists curl; then
  echo "curl not found. Installing..."
  if command_exists apt-get; then
    sudo apt-get update
    sudo apt-get install -y curl
  else
    echo -e "${RED}Unsupported package manager. Please install curl manually.${NC}"
    exit 1
  fi
else
  echo "curl is already installed."
fi

echo -e "${GREEN}Running Ansible playbook...${NC}"
ansible-playbook -i ../ansible/inventory.yml ../ansible/playbooks/main_setup.yml

echo -e "${GREEN}Setup complete!${NC}"
echo -e "${GREEN}Please log out and log back in for all changes to take effect.${NC}"
