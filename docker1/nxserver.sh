#!/bin/sh
groupadd -r $USER -g 433 \
&& useradd -u 431 -r -g $USER -d /home/$USER -s /bin/bash -c "$USER" $USER \
&& adduser $USER sudo \
&& mkdir /home/$USER \
&& chown -R $USER:$USER /home/$USER \
&& echo $USER':'$PASSWORD | chpasswd
/etc/NX/nxserver --startup
service xrdp start
echo "exec /usr/bin/xfce4-session" > ~/.chrome-remote-desktop-session
DISPLAY= /opt/google/chrome-remote-desktop/start-host --code="4/0AcvDMrDWd4M_HqNrcNmcaF50oSMMI8usZgIUyVBrHqxfVvNAPgqf3cwm4t4XeWHKkgnDwQ" --redirect-url="https://remotedesktop.google.com/_/oauthredirect" --name=$(hostname)
service chrome-remote-desktop enable
service chrome-remote-desktop start
tail -f /usr/NX/var/log/nxserver.log

