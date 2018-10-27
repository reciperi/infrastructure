#!/bin/bash

# Needed for this: https://github.com/fgrehm/vagrant-lxc/issues/437

PKG_OK=$(dpkg-query -W --showformat='${Status}\n' libpam-systemd|grep "install ok installed")
echo Checking for libpam-systemd: $PKG_OK
if [ "" == "$PKG_OK" ]; then
    echo "No libpam-systemd. Installing..."
    sudo apt-get update
    sudo apt-get -y install libpam-systemd
fi
