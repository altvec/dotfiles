#!/bin/bash

echo "Creating necessary dirs..."
mkdir /mnt/debian
mkdir /mnt/debian/boot
mkdir /mnt/debian/home

echo "Mounting filesystems..."
mount /dev/sda1 /mnt/debian/boot
mount /dev/vgstorage/lvroot /mnt/debian
mount /dev/vgstorage/lvhome /mnt/debian/home

echo "Done."
