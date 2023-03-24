#!/bin/bash

SDX='/dev/sdc'
VER="2023.03.01"
ISO="archlinux-${VER}-x86_64.iso"
URL="https://mirrors.gandi.net/archlinux/iso/${VER}"
SHA="816758ba8fd8a06dff539b9af08eb8100c8bad526ac19ef4486bce99cd3ca18c"

clear
# Download the new arch iso
curl --progress-bar --remote-name ${URL}/${ISO}
# Check the SHA1 sum
echo "${SHA} ${ISO}" | sha256sum --check -
# Copy the iso to the usb drive
sudo dd bs=4M if=${ISO} of=${SDX} status=progress && sync

