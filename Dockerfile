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
        xfce4-terminal && \
    apt-get clean

# Configure XRDP to use XFCE
RUN echo "xfce4-session" > /etc/skel/.xsession

# Create a user
RUN useradd -m -s /bin/bash user && \
    echo "user:123456" | chpasswd && \
    adduser user sudo

# Expose XRDP port
EXPOSE 3389

# Start XRDP service
CMD service xrdp start && tail -f /var/log/xrdp.log
