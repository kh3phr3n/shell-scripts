#!/bin/bash

SDX='/dev/sdc'
VER="2020.11.01"
ISO="archlinux-${VER}-x86_64.iso"
URL="http://archlinux.polymorf.fr/iso/${VER}"
SHA="739fab8d23430a01629a131ae02713a09af86968"

clear
# Download the new arch iso
curl --progress-bar --remote-name ${URL}/${ISO}
# Check the SHA1 sum
echo "${SHA} ${ISO}" | sha1sum --check -
# Copy the iso to the usb drive
sudo dd bs=4M if=${ISO} of=${SDX} status=progress && sync

