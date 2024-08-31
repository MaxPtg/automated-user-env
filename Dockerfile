FROM debian:12

# Update and upgrade the system
RUN apt-get update && apt-get upgrade -y

# Install required packages
RUN apt-get install -y \
    htop \
    git \
    nano

# Clone the repository
RUN git clone https://github.com/MaxPtg/automated-user-env /root/automated-user-env

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /root

# Set default command to start bash
CMD ["/bin/bash"]

