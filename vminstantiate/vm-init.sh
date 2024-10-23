#!/bin/bash

# Ensure the script runs with root privileges

if [[ $EUID -ne 0 ]]; then
echo 'This script requires root privileges. Please run with sudo.'
exit 1
fi

# Update the system 
apt update && apt upgrade -y

# Install software
apt install -y nfs-common openssh-server python3 git

# Open SSH port in firewall
ufw allow 22/tcp
ufw enable

# Remove SSH keys
rm /etc/ssh/ssh_host_*

# Regen machine ID
rm /etc/machine-id /var/lib/dbus/machine-id
dbus-uuidgen --ensure=/etc/machine-id

# Restart D-Bus based on the system's init system

if [ -x /bin/systemctl ]; then
systemctl restart dbus.service
else
/etc/init.d/dbus restart
fi

echo 'Script completed successfully!'
