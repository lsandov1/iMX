#!/bin/sh

answer=y
clk_en_answer=0
clk_answer=0
graphics_answer=0
video_answer=0
temp=""
str_temp=""

#Here we mount the GPU module
modprobe galcore

mknod /dev/amfm_dev c 60 0
insmod amfm_drv.ko

while [ $answer != x ]
do
    clear
    echo "Select the following option"
    echo "a) Play video"
    echo "b) Play Graphics 3D demo"
    echo "c) Play Audio"
    echo "d) Low Power activation"
    echo "e) Max Power Test"
    echo "f) Dhrystone"
    echo "g) file transfer"
    echo "C) Camera encoding"
    echo "x) Exit"
    echo "?"
    read answer

    case $answer in
        "a") 
		while [ 1 ]; do
		#clear
		echo "Select Display Option:"	
		echo "1 HDMI"
		echo "2 LVDS"
		echo "r Return"
		echo "?"
		
		read video_answer

		
		

		if [ $video_answer = r ]
			then 
				break;
			fi

		if [ $video_answer = 1 ]
			then 
				#Please select the correct bootargs for HDMI					
				echo "Playing video on HDMI"
				cd power
				./video_playback_hdmi.sh
				cd -
			fi
		if [ $video_answer = 2 ]
			then	
				#Please select the correct bootargs for LVDS
				echo "Playing video on LVDS"
				cd power
				./video_playback_lvds.sh
				cd -
			fi
	     done;;


        "b") 
	     while [ 1 ]; do
	     clear
	     echo "-------3D Graphics Benchmarks-------"
	     echo "Select the following option:"
	     echo "1.- 3D Gaming benchmark MM06"
	     echo "2.- 3D Gaming benchmark MM07"
	     echo "r.- Return last menu"
	     echo "?"
             read graphics_answer

	      if [ $graphics_answer = 1 ]
	     then
		 echo "1.- Starting 3D Gaming bechmark MM06"
		 echo 1 > /sys/class/graphics/fb1/blank
		echo 1 > /sys/class/graphics/fb2/blank
		echo 1 > /sys/class/graphics/fb3/blank
		#ifconfig eth0 down
		echo 1 > /sys/devices/platform/imx_busfreq.0/enable
		echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
		echo 198000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
		echo 0 > /sys/class/graphics/fb0/blank
		cd 3DMarkMobile/fsl_imx_linux/
		./fm_oes_player
		cd -		
	      fi 
              if [ $graphics_answer = 2 ]
	     then
		 echo "2.- Starting 3D Gaming bechmark MM07"
		 echo "When the menu loads, press d and then enter to begin the demo."
		 echo 1 > /sys/class/graphics/fb1/blank
		echo 1 > /sys/class/graphics/fb2/blank
		echo 1 > /sys/class/graphics/fb3/blank
		#If you are using NFS to test, please comment the following line
		#ifconfig eth0 down
		echo 1 > /sys/devices/platform/imx_busfreq.0/enable
		echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
		echo 198000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
		echo 0 > /sys/class/graphics/fb0/blank
		 cd mm07_v21/
		./fm_oes2_mobile_player
		cd -
	      fi 
	     done;;	     

        "c") 
	     clear
	     echo "--------Playing Audio--------"
	     cd power
	     ./audio_playback.sh
	     cd -
	     ;;            
        "d") 
	     while [ 1 ]; do
             clear
             echo "-------Low Power Menu-------"
             echo "Select the following option:"
             echo "1.- System Idle mode"
             echo "2.- Deep Sleep Mode"
	     echo "3.- User Idle Mode"
             echo "r.- Return to last menu"
             echo "?"
             read low_power_answer
             if [ $low_power_answer = r  ]
             then
                 break;
             fi
             if [ $low_power_answer = 1 ]
	     then
		 echo "1.- Enabling System Idle mode"
                 echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
		 echo 198000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
		 echo 1 > /sys/class/graphics/fb0/blank
		 echo 1 > /sys/class/graphics/fb1/blank
		 echo 1 > /sys/class/graphics/fb2/blank
		 echo 1 > /sys/class/graphics/fb3/blank
		 echo 1 > /sys/class/graphics/fb4/blank
		 ./uart_off.sh
		 echo "Use case is running, measurements can be taken now."
             fi
             if [ $low_power_answer = 2 ]
             then
                 echo "1.- Enabling Deep Sleep Mode"
		 echo "Use case is running, measurements can be taken now."
                 echo mem > /sys/power/state
             fi
	     if [ $low_power_answer = 3 ]
             then
                 echo "1.- Enabling User Idle Mode"
                 echo "This low power mode needs that bootargs are modified:"
		 echo "setenv bootargs_base \'setenv bootargs ${bootargs} fec_mac=${ethaddr} ${lvds_mode}\'"
		 echo 1 > /sys/class/graphics/fb0/blank
		 echo 1 > /sys/class/graphics/fb1/blank
		 echo 1 > /sys/class/graphics/fb2/blank
		 echo 1 > /sys/class/graphics/fb3/blank
		 echo 1 > /sys/class/graphics/fb4/blank
		 #If you are using NFS to test, please comment the following line
		 ifconfig eth0 down
		 echo 0 > /sys/class/graphics/fb0/blank
		 echo 1 > /sys/devices/platform/imx_busfreq.0/enable
		 echo "Use case is running, measurements can be taken now."
             fi

             done;;
        "e") echo "-------Executing Max power test-------"
	      cd power
	     ./power_measure1.sh &
	     ./power_measure2.sh &
	     ./power_measure3.sh 
	      cd -
	;;
	"f") echo "-------Executing Dhryhstone test ------"
	     cd power
	     ./dhrystone.sh
	     cd -
	;;
	"g") echo "-------Executing File transfer Test--"		
	     cd power
	     ./non-multimedia.sh 
             cd -
	;;
	"C") echo "-------Executing Camera Encoding--"		
		while [ 1 ]; do
		#clear
		echo "Select Camera Encoding Option:"	
		echo "1 Single camera displaying capture data"
		echo "2 Dual Camera displaying capture data"
		echo "3 Triple Camera displaying capture data"
		echo "4 Single camera without displaying capture data"
		echo "5 Dual Camera without capture data"
		echo "6 Triple Camera without displaying capture data"
		echo "?"
		
		read answer

		if [ $answer = r ]
			then 
				break;
			fi

		if [ $answer = 1 ]
			then 
				#Please select the correct bootargs for HDMI					
				echo "Playing video on HDMI"
				cd power
				./video_playback_hdmi.sh
				cd -
			fi
		if [ $video_answer = 2 ]
			then	
				#Please select the correct bootargs for LVDS
				echo "Playing video on LVDS"
				cd power
				./video_playback_lvds.sh
				cd -
			fi
	     done;;
	     cd power
	     ./non-multimedia.sh 
             cd -
	;;
	
    esac
done
rmmod amfm_drv.ko
