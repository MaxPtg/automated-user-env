#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
NC='\033[0m' # No Color

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
    sudo apt-get install -y ansible
  else
    echo "Unsupported package manager. Please install Ansible manually."
    exit 1
  fi
}

# Main script
echo -e "${GREEN}Starting initial setup...${NC}"

if ! command_exists ansible; then
  echo "Ansible not found. Installing..."
  install_ansible
else
  echo "Ansible is already installed."
fi

echo -e "${GREEN}Cloning repository...${NC}"
git clone https://github.com/yourusername/user-env-setup.git
cd user-env-setup

echo -e "${GREEN}Running Ansible playbook...${NC}"
ansible-playbook -i ansible/inventory.yml ansible/playbooks/main.yml

echo -e "${GREEN}Setup complete!${NC}"