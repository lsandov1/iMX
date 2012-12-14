Steps
=====

1. Move the patch to the Kernel Source Folder
2. Patch:
    patch -p0 < max_power.patch
3. Rebuilt uImage
    make ARCH=arm CROSS_COMPILE=$TOOLCHAIN uImage


NOTE: Patched tests for kernel version 3.0.35-imx_12.09.
