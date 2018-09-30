#!/bin/bash

SDX='/dev/sdb'
VER="2018.09.01"
ISO="archlinux-${VER}-x86_64.iso"
URL="http://archlinux.polymorf.fr/iso/${VER}"
SHA="1649fa7e68a2c5dcc4e48b36ecbb8e318272e746"

clear
# Download the new arch iso
curl --progress-bar --remote-name ${URL}/${ISO}
# Check the SHA1 sum
echo "${SHA} ${ISO}" | sha1sum --check -
# Copy the iso to the usb drive
sudo dd bs=4M if=${ISO} of=${SDX} status=progress && sync

