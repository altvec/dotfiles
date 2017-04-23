#!/bin/bash

echo "Creating necessary dirs and mounting filesystems..."
mkdir /mnt/debian
mount /dev/vgstorage/lvroot /mnt/debian
mkdir /mnt/debian/boot
mkdir /mnt/debian/home
mount /dev/sda1 /mnt/debian/boot
mount /dev/vgstorage/lvhome /mnt/debian/home

echo "Done."
