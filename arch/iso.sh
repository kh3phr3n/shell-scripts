#!/bin/bash

SDX='/dev/sdb'
VER="2018.10.01"
ISO="archlinux-${VER}-x86_64.iso"
URL="http://archlinux.polymorf.fr/iso/${VER}"
SHA="0755f656917eb201bff8f702f33c2e2fe149d69d"

clear
# Download the new arch iso
curl --progress-bar --remote-name ${URL}/${ISO}
# Check the SHA1 sum
echo "${SHA} ${ISO}" | sha1sum --check -
# Copy the iso to the usb drive
sudo dd bs=4M if=${ISO} of=${SDX} status=progress && sync

