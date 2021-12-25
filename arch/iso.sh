#!/bin/bash

SDX='/dev/sdc'
VER="2021.12.01"
ISO="archlinux-${VER}-x86_64.iso"
URL="http://archlinux.polymorf.fr/iso/${VER}"
SHA="e303b93788220dbe8e0ba1804c90beebe432cf63"

clear
# Download the new arch iso
curl --progress-bar --remote-name ${URL}/${ISO}
# Check the SHA1 sum
echo "${SHA} ${ISO}" | sha1sum --check -
# Copy the iso to the usb drive
sudo dd bs=4M if=${ISO} of=${SDX} status=progress && sync

