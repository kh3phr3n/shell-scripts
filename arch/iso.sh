#!/bin/bash

SDX='/dev/sdb'
VER="2018.11.01"
ISO="archlinux-${VER}-x86_64.iso"
URL="http://archlinux.polymorf.fr/iso/${VER}"
SHA="2d8f56bda0fbfba0ca6162f35c5950e314a8b8f8"

clear
# Download the new arch iso
curl --progress-bar --remote-name ${URL}/${ISO}
# Check the SHA1 sum
echo "${SHA} ${ISO}" | sha1sum --check -
# Copy the iso to the usb drive
sudo dd bs=4M if=${ISO} of=${SDX} status=progress && sync

