#!/bin/sh -x
echo 0 > /sys/class/graphics/fb0/blank
echo 0 > /sys/class/graphics/fb4/blank
echo 0 > /sys/class/graphics/fb2/blank
a_stream_path=./Avatar_1920x1080_30fpsH264_2x44100AAC_3.6Mbps_246sec.mp4

while true
do
  /unit_tests/mxc_vpu_test.out -D "-f 2 -i ${a_stream_path}" &
  /unit_tests/mxc_vpu_test.out -D "-f 2 -i ${a_stream_path} -x 19 "
done

