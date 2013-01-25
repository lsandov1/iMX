AN4509 (i.MX 6Dual/6Quad Power Consumption Measurement Scripts and Image)
======

This folder contains all SW (filesystem, scripts, u-boot settings) needed to 
have a Linux system running to do the proper measurements.

Flashing
--------

1. Create folder where all binaries will be downloaded

        $ mkdir AN4509 && cd AN4509

1. Download flashing scripts

        $ wget https://raw.github.com/lsandoval/iMX/master/flash/mk_mx_sd
        $ wget https://raw.github.com/lsandoval/iMX/master/app-notes/AN4509/scripts/mk_image
   
1. Plug the SD and figure out the device node 
    
        $ dmesg | tail

1. Flash the SD

        $ . mk_image </dev/sdX>`

   
1. Plug the SD on the target (i.MX6) and select the correct boot-mode thorugh 
   the Dip switch.

1. Power up the board

1. Stop the booting process and setenv the variable 'use_case'
  
        MX6Q SABRESD U-Boot > setenv use_case 'xxxx'
     
     
        Possible options:
          setenv use_case 'deep_sleep'
          setenv use_case 'system_idle'
          setenv use_case 'user_idle'
          setenv use_case 'audio_playback'
          setenv use_case 'video_playback_lvds'
          setenv use_case 'video_playback_hdmi'
          setenv use_case 'dhrystone_quad'
          setenv use_case 'dhrystone_dual'
          setenv use_case 'dhrystone_single'
          setenv use_case '3d_gamming_mm06'
          setenv use_case '3d_gamming_mm07'
          setenv use_case 'max_power'
      setenv use_case 'usb_to_emmc_file_transfer'
 
 
1. Boot the system
 
        MX6Q SABRESD U-Boot > run bootcmd
 
1. Log in to the system (credentials: root/root), and execute the main script
  
        $ ./power_tests.sh
 
1. Follow script instructions
