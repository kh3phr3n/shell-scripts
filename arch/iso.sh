#!/bin/bash

SDX='/dev/sdc'
VER='2024.09.01'
ISO="archlinux-${VER}-x86_64.iso"
URL="https://mirrors.gandi.net/archlinux/iso/${VER}"
SHA='1652f3cee1b9857742123d392bb467bc5472ecd59a977bd6e17b7c379607b20c'

clear
# Download the new arch iso
curl --progress-bar --remote-name ${URL}/${ISO}
# Check the SHA1 sum
echo "${SHA} ${ISO}" | sha256sum --check -
# Copy the iso to the usb drive
sudo dd bs=4M if=${ISO} of=${SDX} status=progress && sync

