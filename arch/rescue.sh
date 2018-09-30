#!/bin/bash

UEFI='1'
UEFIFS='/dev/sda1'
BOOTFS='/dev/sda2'
ROOTFS='/dev/sda3'
LUKSFS='/dev/mapper/r00t'

# Open LUKS container
cryptsetup --verbose luksOpen ${ROOTFS} ${LUKSFS##*/}
# Root partition
mount --verbose ${LUKSFS} /mnt
# Boot partition
mount --verbose ${BOOTFS} /mnt/boot
# EFI partition
[[ "${UEFI}" -ne 0 ]] && mount --verbose ${UEFIFS} /mnt/boot/efi
# Let's Go!
arch-chroot /mnt

# ...

# Unmount partitions
umount --verbose --recursive /mnt
# Close LUKS container
cryptsetup --verbose luksClose ${LUKSFS##*/}

