#!/bin/sh

#Turns off all screens
echo 1 > /sys/class/graphics/fb0/blank
echo 1 > /sys/class/graphics/fb1/blank
echo 1 > /sys/class/graphics/fb2/blank
echo 1 > /sys/class/graphics/fb3/blank
echo 1 > /sys/class/graphics/fb4/blank
#If you are using NFS to test, please comment the following line
#ifconfig eth0 down
echo 1 > /sys/devices/platform/imx_busfreq.0/enable
echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 198000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
#Turn on lvds
echo 0 > /sys/class/graphics/fb0/blank
/unit_tests/mxc_vpu_test.out -D "-f 2 -y 1 -i fsl-clip-1080p.264"
