#!/bin/bash

# Stage 1
#
# Partitions layout should be something like this:
#
# Device     Boot   Size  Id   Type
# /dev/sda1  *      256M  83   Linux
# /dev/sda2          20G  8e   Linux LVM


echo "Creating LVM..."
pvcreate /dev/sda2
vgcreate vgstorage /dev/sda2
lvcreate -L5G -n lvroot vgstorage
lvcreate -L1G -n lvswap vgstorage
lvcreate -l100%FREE -n lvhome vgstorage
vgchange -a y vgstorage


echo "Creating filesystems..."
mkfs.ext2 /dev/sda1
mkfs.ext4 /dev/vgstorage/lvroot
mkfs.ext4 /dev/vgstorage/lvhome
mkswap /dev/vgstorage/lvswap

echo "Done."
