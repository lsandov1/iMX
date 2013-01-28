AN4509 (i.MX 6Dual/6Quad Power Consumption Measurement Scripts and Image)
======

This folder contains all SW (filesystem, scripts, u-boot settings) needed to 
have a Linux system running to do the proper measurements.

Flashing
--------

1. Plug the SD into your host computer and figure out the device node given
    
        $ dmesg | tail
   
   Notes: 
    Make sure the SD is **NOT** mounted
    Make sure the device is not the hard disk where your host filesystem
    resides. Host filesystem are tipically mounted from `/dev/sda`


1. Run the flashing script

        $ source flash_sd/mk_sd_an4509.sh /dev/sdX

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
