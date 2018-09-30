#!/bin/bash

# fdisk: o, n, p, t, c, w
# wiki.archlinux.org/index.php/Fdisk

SDX="/dev/sdb"
SDY="${SDX}1"
S64=$(blockdev --getsize64 ${SDX})

# Root privileges required
[[ "${UID}" -ne 0 ]] && exit 0 || clear
# Zero-fill data
dd if=/dev/zero of=${SDX} bs=4096 count=${S64} iflag=count_bytes status=progress
# Create and format the new partition
fdisk ${SDX} && mkfs.vfat -F32 ${SDY}

