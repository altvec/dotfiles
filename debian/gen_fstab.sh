#!/bin/bash

$T="/etc/fstab"

echo "/dev/sda1                     /boot       ext2    defaults                    0 0" >> $T
echo "/dev/mapper/vgstorage-lvroot  /           ext4    errors=remount-ro,relatime  0 1" >> $T
echo "/dev/mapper/vgstorage-lvhome  /home       xfs     defaults,relatime           0 0" >> $T
echo "/dev/mapper/vgstorage-lvswa   nonep       swap    sw                          0 0" >> $T
echo "proc                          /proc       proc    defaults                    0 0" >> $T
echo "sysfs                         /sys        sysfs   defaults                    0 0" >> $T
echo "tmpfs                         /dev/shm    tmpfs   defaults                    0 0" >> $T
echo "devpts                        /dev/pts    devpts  defaults                    0 0" >> $T

