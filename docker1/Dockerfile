# Use the official Ubuntu 18.04 base image
FROM ubuntu:18.04

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install required packages
RUN apt-get update && \
    apt-get install -y \
        wget \
        software-properties-common \
        apt-transport-https \
        gnupg \
        sudo \
        xfce4 \
        xfce4-goodies \
        xorg \
        dbus-x11 \
        x11-xserver-utils \
        xvfb \
        xserver-xorg-video-dummy \
        xbase-clients \
        python3-packaging \
        xrdp \
        curl \
        xfce4-terminal && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configure XRDP to use XFCE
RUN echo "xfce4-session" > /etc/skel/.xsession

# Download and install NoMachine
RUN curl -fSL "https://download.nomachine.com/download/8.13/Linux/nomachine_8.13.1_1_amd64.deb" \
    -o nomachine.deb && dpkg -i nomachine.deb && \
    sed -i "s|#EnableClipboard both|EnableClipboard both |g" /usr/NX/etc/server.cfg && \
    rm -f nomachine.deb

# Create users
RUN for i in $(seq 1 5); do \
    username="user$i"; \
    useradd -m -s /bin/bash $username && \
    echo "$username:123456" | chpasswd && \
    adduser $username sudo; \
done

# Expose XRDP port
EXPOSE 3389 4000
VOLUME [/home/nomachine]

COPY nxserver.sh /nxserver.sh
RUN chmod +x /nxserver.sh
# Start service
ENTRYPOINT ["./nxserver.sh"]
