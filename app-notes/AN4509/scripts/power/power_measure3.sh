#!/bin/sh

if lsmod | grep galcore; then
	echo "galcore is already loaded"
else
	modprobe galcore
fi

export FB_FRAMEBUFFER_0=/dev/fb2
cd ~/3DMarkMobile/fsl_imx_linux
~/3DMarkMobile/fsl_imx_linux/fm_oes_player
