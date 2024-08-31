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
    # temporary packages
    ansible 

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /root

# Create a startup script
RUN echo '#!/bin/bash' > /root/startup.sh && \
    echo 'git clone https://github.com/MaxPtg/automated-user-env /root/automated-user-env' >> /root/startup.sh && \
    echo 'chmod +x /root/automated-user-env/scripts/initial_setup.sh' >> /root/startup.sh && \
    echo 'chmod +x /root/automated-user-env/scripts/update_env.sh' >> /root/startup.sh && \
    echo 'exec /bin/bash && cd /root/automated-user-env/scripts' >> /root/startup.sh && \
    chmod +x /root/startup.sh

# Set default command to run the startup script
CMD ["/root/startup.sh"]