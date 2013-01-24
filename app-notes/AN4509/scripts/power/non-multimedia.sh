#!/bin/sh

# create the mounting points
if [ ! -d "emmc" ]; then

        mkdir emmc

fi

if [ ! -d "usb" ]; then
        mkdir usb
fi

emmc_dir = $(cat /proc/partitions | grep mmcblk.p1 | awk '{print $4}')

# mount the USB and EMMC
mount /dev/$emmc_dir emmc  #mount the emmc
mount /dev/sda1 usb        #mount the usb

# Do the copy, blocks size are 1M, and 1000 of them are copied.
dd if=usb/sample.bin \
   of=emmc/sample.bin \
   bs=1M count=1000
