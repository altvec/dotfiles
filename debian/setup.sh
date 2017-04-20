#!/bin/bash

source ./post_install.sh

echo "Chrooting to new system..."
env LANG=C env HOME=/root chroot $TARGET /bin/bash /post_install.sh
