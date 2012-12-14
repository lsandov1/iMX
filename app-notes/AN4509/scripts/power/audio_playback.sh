#!/bin/sh

echo 1 > /sys/class/graphics/fb0/blank
echo 1 > /sys/class/graphics/fb1/blank
echo 1 > /sys/class/graphics/fb2/blank
echo 1 > /sys/class/graphics/fb3/blank
#ifconfig eth0 down
echo 1 > /sys/devices/platform/imx_busfreq.0/enable
echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 996000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
echo 198000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
echo interactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor


gplay friends_48k_128kbps.mp3

