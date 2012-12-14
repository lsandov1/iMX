#!/bin/sh

TOP=0
LEFT=0
WIDTH=640
HEIGHT=480
FRAMERATE=30
DISPLAY=0

function print_usage() {
    echo -e "\nUsage: $0 [-hTLWHFD]."
        echo -e "               Defaults:"
        echo -e "                       -T $TOP"
        echo -e "                       -L $LEFT"
        echo -e "                       -W $WIDTH"
        echo -e "                       -H $HEIGHT"
        echo -e "                       -F $FRAMERATE"
        echo -e "                       -D $DISPLAY  [values greater than 0 shows camera capture data on display]"
        echo -e "                       -V $VIDEOSRC [indicates the video device number X, the /dev/videoX]"
}

while getopts "hTLWHFDV" Option
do
  case $Option in
    h ) print_usage
        exit 0
        ;;
    T ) TOP="$OPTARG"
        ;;
        L ) LEFT="$OPTARG"
        ;;
        W ) WIDTH="$OPTARG"
        ;;
        H ) HEIGHT="$OPTARG"
        ;;
        F ) FRAMERATE="$OPTARG"
        ;;
        D ) DISPLAY="$OPTARG"
        ;;
        V ) VIDEOSRC="$OPTARG"
        ;;      
  esac
done

if [ "$DISPLAY" -gt "0" ]; then
        DISPLAY='tee name=t ! queue ! mfw_isink axis-top=$TOP axis-left=$LEFT  disp-width=$WIDTH disp-height=$HEIGHT t. '
else
        DISPLAY=''
fi

camera_src_caps='video/x-raw-yuv,format=(fourcc)I420, width=$WIDTH, height=$HEIGHT, framerate=(fraction)$FRAMERATE/1'
gst-launch v4l2src device=/dev/video${VIDEOSRC} num-buffers=-1  ! \
        ${camera_src_caps} ! \
        ${DISPLAY} ! \
        queue ! \
        vpuenc codec=0 ! \
        matroskamux ! \
        filesink location=/dev/null sync=false
