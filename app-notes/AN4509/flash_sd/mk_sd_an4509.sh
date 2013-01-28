#!/usr/bin/env bash        

dev=$1

# Create a temporal folder
tmp_folder=`mktemp -d`
cd $tmp_folder

echo "Downloading scripts"
curl    --silent https://raw.github.com/lsandoval/iMX/master/flash/mk_mx_sd > mk_mx_sd
curl    --silent https://raw.github.com/lsandoval/iMX/master/app-notes/AN4509/power_scripts/mk_image > mk_image
chmod +x ./mk_mx_sd ./mk_image
           
echo "Download binaries"
wget    --quiet \
        http://vfae-server:8000/AN/AN4509/rootfs.tar.bz2 \
        http://vfae-server:8000/AN/AN4509/uImage \
        http://vfae-server:8000/AN/AN4509/uImageMaxPower
        
echo "Unpack the root filesystem"
tmp_rootfs_folder=`mktemp -d`
sudo tar xjf rootfs.tar.bz2 -C $tmp_rootfs_folder
                
echo "Flash the SD"
sudo ./mk_image $dev \
                u-boot.bin \
                uImage \
                uImageMaxPower \
                $tmp_rootfs_folder

echo "Cleaning up: remove temporal folders"
cd -
rm -rf $tmp_folder
sudo rm -rf $tmp_rootfs_folder

echo "Done."
echo
echo "Plug the SD on the target (i.MX6) and select the correct boot-mode thorugh the Dip switch."
echo
