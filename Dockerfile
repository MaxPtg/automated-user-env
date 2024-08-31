FROM debian:12

# Update and upgrade the system
RUN apt-get update && apt-get upgrade -y

# Install required packages
RUN apt-get install -y \
    sudo \
    htop \
    git \
    nano

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /root

# Create a startup script
RUN echo '#!/bin/bash' > /root/startup.sh && \
    echo 'git clone https://github.com/MaxPtg/automated-user-env /root/automated-user-env' >> /root/startup.sh && \
    echo 'exec /bin/bash' >> /root/startup.sh && \
    chmod +x /root/startup.sh

# Set default command to run the startup script
CMD ["/root/startup.sh"]