# automated-user-env

A simple automation suite to set up a custom user environment on any Debian/Ubuntu machine. It uses **Ansible** and **Bash** scripts to install and configure the necessary packages and environment variables.

It is intended to be used on a fresh install of a Debian/Ubuntu machine, but it can be used to update an existing environment as well. That way, you can keep your environment up to date with the latest changes across all your machines.

## Prerequisites

In order to use this script, you must have the following packages installed:

```bash	
sudo apt update
sudo apt install -y sudo git curl
```

Packages needed by the suite will be installed on the first run of the `initial_setup.sh` script.

## Usage

Clone the repository into your home directory:

```bash
git clone https://github.com/MaxPtg/automated-user-env
```

Navigate to the `scripts` directory:

```bash
cd automated-user-env/scripts
```

On a fresh install, run the `inistal_setup.sh` script:

```bash
sudo bash initial_setup.sh && source ~/.bashrc
```

After the initial setup, you can run the `update_env.sh` script to update your environment:

```bash
sudo bash update_env.sh
```

> **NOTE**: The `update_env.sh` script will update your environment with the latest changes from the repository. As some environment variables could be changed/removed, it is recommended to restart your terminal session after running the script.

## Testing

To easily develop and test this automation suite, you can use the provided `Dockerfile` to build a container with the necessary dependencies. To speed up the process, you can use the provided `build.sh` script:

```bash
sudo bash build.sh
```

This script uses `DOCKER_BUILDKIT=1` to build the container, which allows for caching of intermediate layers. This way, you can quickly iterate on the development of the automation suite.

> **NOTE**: The required packages are already installed in the container, so you don't need to install them manually.

## Known Bugs/ToDo

- [ ] Add support to change the `oh-my-bash` installation directory
    - If **not** left on default, manual changes to the `.custom.bash*` files are needed