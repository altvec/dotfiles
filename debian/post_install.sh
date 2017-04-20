#!/bin/bash

# Vars
readonly HOST="bebian"
readonly USER="skali"
readonly ARCH="amd64"

echo "Updating repos..."
apt-get update

echo "Setup time zones..."
dpkg-reconfigure tzdata

echo "Mounting file systems..."
mount -t proc /proc /proc
mount -a

echo "Configuring hostname..."
echo $HOST > /etc/hostname
echo -e "\n127.0.0.1 localhost $HOST" >> /etc/hosts

echo "Adding new user as  $USER..."
adduser $USER
usermod -a -G sudo $USER

echo "Root password setup..."
passwd

echo "Installing packages..."
apt-get -y install linux-base linux-image-$ARCH linux-headers grub-pc lvm2 sudo openssh-server

echo "Grub setup..."
grub-install /dev/sda
update-grub
