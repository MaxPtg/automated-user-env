FROM debian:12

# Update and upgrade the system
RUN apt-get update && apt-get upgrade -y

# Install required packages
RUN apt-get install -y \
    apt-utils \
    software-properties-common \
    sudo \
    htop \
    git \
    nano \
    bat \
    curl \ 
    ansible

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Create test user
RUN useradd -m -s /bin/bash testuser && \
    echo "testuser ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/testuser

# Set the working directory
WORKDIR /home/testuser

# Create a startup script
COPY test-startup.sh /usr/local/bin/test-startup.sh
RUN chmod +x /usr/local/bin/test-startup.sh

# Create directory for local mode
RUN mkdir -p /automated-user-env

# Switch to test user
USER testuser

# No ENTRYPOINT or CMD - we'll handle it in the run command
