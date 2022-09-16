#!/bin/bash

SDX='/dev/sdc'
VER="2022.09.03"
ISO="archlinux-${VER}-x86_64.iso"
SHA="778b6399dff5955ef0666d4962da2a9c291b59cb"
URL="https://mirrors.gandi.net/archlinux/iso/${VER}"

clear
# Download the new arch iso
curl --progress-bar --remote-name ${URL}/${ISO}
# Check the SHA1 sum
echo "${SHA} ${ISO}" | sha1sum --check -
# Copy the iso to the usb drive
sudo dd bs=4M if=${ISO} of=${SDX} status=progress && sync

