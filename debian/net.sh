#!/bin/bash

FIREFOX="firefox-21.0.tar.bz2"
FIREFOXURL="download-origin.cdn.mozilla.net/pub/firefox/releases/21.0/linux-i686/fr"

# Main program
# ------------

# Services reconfiguration
clear && dpkg-reconfigure locales
clear && dpkg-reconfigure debconf

# Backup sources.list
cp /etc/apt/sources.list /etc/apt/sources.list.orig
# Update sources.list
sed -i "/main/s/\$/ contrib non-free&/" /etc/apt/sources.list

# APT update
clear && aptitude update && aptitude safe-upgrade
clear && aptitude clean  && aptitude autoclean

# Packages installation [Base]
clear && aptitude install -y  bzip2 zip unzip rar unrar
clear && aptitude install -y  xserver-xorg-core xfonts-base mesa-utils
clear && aptitude install -y  acpid ntpdate rcconf alsa-base alsa-utils

# Packages installation [KDE]
clear && aptitude install -y kde-plasma-desktop kdm plasma-widget-smooth-tasks kde-l10n-fr
clear && aptitude install -y tcl-tls ark ksnapshot kdeadmin kmix systemsettings plasma-widget-networkmanagement
clear && aptitude install -y kwin-style-qtcurve kde-config-gtk-style kde-style-qtcurve gtk2-engines-qtcurve gtk-chtheme

# Packages installation [Dev]
clear && aptitude install -y build-essential module-assistant fakeroot kernel-package libncurses5-dev

# Packages installation [Nvidia]
clear && aptitude install -y nvidia-glx nvidia-xconfig nvidia-settings

# Firefox installation
clear && wget $FIREFOXURL/$FIREFOX && tar xjf $FIREFOX -C /opt && rm $FIREFOX

# Enable/Restart NetworkManager [managed -> true]
nano /etc/NetworkManager/NetworkManager.conf && /etc/init.d/network-manager restart

# Reboot computer
shutdown -r now

