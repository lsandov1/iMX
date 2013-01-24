Flashing
--------

Steps to flash an SD with the two uImages (the non-max-power and max-power uImages)

1. Download and give exec permissions to 
   https://github.com/lsandoval/iMX/blob/master/flash/mk_mx_sd
2. Flash the u-boot
   `$ ./mk_mx_sd -d /dev/sdX -u u-boot.bin`
3. Flash the uImage's
   `$ ./mk_mx_sd -d /dev/sdX -k uImage -y 2048`
   `$ ./mk_mx_sd -d /dev/sdX -k uImageMaxPower -y 20480`
4. Flash the root filesystem
   `$ ./mk_mx_sd -d /dev/sdX -r <rootfs-path> -s 409060`
5. Set the U-boot variables following this guide:
   https://github.com/lsandoval/iMX/blob/master/app-notes/AN4509/u-boot/mx6q.envs
