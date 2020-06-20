#!/bin/bash

# bios: 1.24
# geteltorito: 0.6
# userpages.uni-koblenz.de/~krienke/ftp/noarch/geteltorito/geteltorito/geteltorito.pl
# wiki.archlinux.org/index.php/Flashing_BIOS_from_Linux#Bootable_optical_disk_emulation
# pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-l-series-laptops/thinkpad-l380-type-20m5-20m6/downloads

SDX='/dev/sdb'
IMG='l380.img'
ISO='r0rur17w.iso'
URL='https://download.lenovo.com/pccbbs/mobiles'
SHA='af6ff2cff405b984f22412edaf7c0860790af70278a11b8ca82d4117696f7987'

# Geteltorito is required
[[ ! -e geteltorito.pl ]] && exit 0 || clear
# Download the new bios
curl --progress-bar --remote-name ${URL}/${ISO}
# Check the SHA256 sum
echo "${SHA} ${ISO}" | sha256sum --check -
# Extract the image from iso file
chmod +x geteltorito.pl && ./geteltorito.pl -o ${IMG} ${ISO}
# Copy the image to the usb drive
sudo dd bs=4M if=${IMG} of=${SDX} status=progress && sync

