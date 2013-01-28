#!/usr/bin/env bash        

dev=$1

# Create a temporal folder
tmp_folder=`mktemp -d`
cd $tmp_folder

# Download scripts
curl    https://raw.github.com/lsandoval/iMX/master/flash/mk_mx_sd > mk_mx_sd
curl    https://raw.github.com/lsandoval/iMX/master/app-notes/AN4509/scripts/mk_image > mk_image
chmod +x ./mk_mx_sd ./mk_image
           
# Download the binaries located on 
wget    http://vfae-server:8000/AN/AN4509/rootfs.tar.bz2 \
        http://vfae-server:8000/AN/AN4509/uImage \
        http://vfae-server:8000/AN/AN4509/uImageMaxPower
        
# Untar the filesystem
tmp_rootfs_folder=`mktemp -d`
sudo tar xjvf rootfs.tar.bz2 -C $tmp_rootfs_folder
                
# Flash the SD
sudo ./mk_image $dev \
                u-boot.bin \
                uImage \
                uImageMaxPower \
                $tmp_rootfs_folder

#remove temporal folders
cd -
rm -rf $tmp_folder
sudo rm -rf $tmp_rootfs_folder
