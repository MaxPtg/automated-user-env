# automated-user-env

A comprehensive automation suite to set up and maintain a custom user environment on any Debian/Ubuntu machine. It uses **Ansible** and **Bash** scripts to install and configure necessary packages, environment variables, and shell customizations.

## Overview

The suite provides:
- System-wide oh-my-bash installation with custom theme
- Automated package installation and updates
- User environment configuration management
- Version tracking and updates
- Docker-based testing environment

## Project Structure
```
automated-user-env/
├── ansible/
│   ├── group_vars/
│   │   └── all.yml
│   ├── host_vars/
│   ├── migrations/
│   ├── playbooks/
│   │   ├── main_setup.yml
│   │   ├── main_update.yml
│   │   ├── oh-my-bash_setup.yml
│   │   ├── packages_install.yml
│   │   ├── system_setup.yml
│   │   ├── user_env_setup.yml
│   │   ├── user_env_update.yml
│   │   └── version_check.yml
│   ├── roles/
│   └── inventory.yml
├── configs/
├── docker/
│   ├── build.sh
│   ├── Dockerfile
│   └── test-startup.sh
└── scripts/
    ├── initial_setup.sh
    └── update_env.sh
```

## Prerequisites

Required packages:
```bash
sudo apt update
sudo apt install -y sudo git curl
```

## Installation

1. Clone the repository:

```bash
git clone https://github.com/MaxPtg/automated-user-env
```

2. Navigate to scripts:

```bash
cd automated-user-env/scripts
```

3. Run initial setup:

```bash
sudo bash initial_setup.sh && source ~/.bashrc
```

## Updating

To update your environment with latest changes:

```bash
sudo bash update_env.sh
```

> **NOTE**: Restart your terminal session after updates as environment variables may change.

## Testing

For development and testing:

```bash
sudo bash build.sh
```

This uses BuildKit for efficient container builds with layer caching.

## Features

- System-wide oh-my-bash installation with custom Luan theme
- Automated package management
- Centralized user environment configuration
- Version tracking
- Docker-based testing environment
- Comprehensive backup and restore functionality
