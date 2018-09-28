#!/bin/bash

# Razor-Qt URL/Package
AUR='http://arch.tuxico.com/aur/razor-qt'
RAZOR='razor-qt-0.5.2-5-x86_64.pkg.tar.xz'

# Processor architecture
ARCH=$(uname -m)
# Get "[multilib]" line number
MULTILIB=$(grep -n "\[multilib\]" /etc/pacman.conf | cut -f1 -d:)

# Main program
# ------------

if [ "${ARCH}" == "x86_64" ] && [ $(pwd) == "/root/ali/utils" ]
then
    # Start network
    clear; echo ":: Starting network..."; systemctl start dhcpcd.service && sleep 7
    # Enable multilib repository
    [[ -n "${MULTILIB}" ]] && sed -i "${MULTILIB},$(($MULTILIB+1))s/^#//" /etc/pacman.conf || exit 1

    # Synchronize Pacman
    clear; pacman -Syu
    # Install Razor-Qt environment
    clear; curl -O ${AUR}/${RAZOR} && pacman -U ${RAZOR}
    # Install Steam client (3: lib*-nvidia*)
    clear; pacman -Syu steam lib32-flashplugin lib32-alsa-plugins
    # Install KWin compositor
    clear; pacman -Syu cronie phonon-qt4-gstreamer kdebase-workspace kdebase-konsole kdemultimedia-kmix

    # Enable systemd units
    clear
    for unit in 'kdm.service' 'cronie.service' 'dhcpcd.service'
    do
        systemctl --quiet enable $unit && echo ":: Unit enabled: $unit"
    done
else
    echo ":: Run 'steam.sh' into '/root/ali/utils' directory."
    echo ":: Only x86_64 systems are supported for Steam installation."
fi

