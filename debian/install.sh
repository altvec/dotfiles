#!/bin/bash

ARCH=amd64
OS=debian
DISTR=stable

TARGET=/mnt/debian
export $TARGET

echo "Bootstrapping system..."
debootstrap --include=sudo,vim,wget --arch $ARCH $DISTR $TARGET http://deb.debian.org/$OS

echo "Mounting /dev and /sys to new root../"
mount -o bind /dev $TARGET/dev
mount -o bind /sys $TARGET/sys

echo "Done."

