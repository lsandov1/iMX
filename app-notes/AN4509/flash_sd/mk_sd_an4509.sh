#!/usr/bin/env bash        

if [ -z $1 ]; then
  echo "Usage: $0 /dev/sbX"
  exit -1
fi

dev=$1


# by default, all operations are 'quiet', no ouput log
# Comment out the above lines in case you need to a verbose log
wget_verbose_level= #"--quiet"
curl_verbose_level= #"--silent"
tar_verbose_level= #"v"


# Create a temporal folder
tmp_folder=`mktemp -d`
cd $tmp_folder

echo "Download scripts"
$DEBUG curl    $curl_verbose_level https://raw.github.com/lsandoval/iMX/master/flash/mk_mx_sd > mk_mx_sd
$DEBUG curl    $curl_verbose_level https://raw.github.com/lsandoval/iMX/master/app-notes/AN4509/flash_sd/mk_image > mk_image

chmod +x ./mk_mx_sd ./mk_image
           
echo "Download binaries: u-boot and kernels"
# u-boot and kernels
$DEBUG wget    $wget_verbose_level \
        https://community.freescale.com/servlet/JiveServlet/downloadBody/93998-102-1-4230/u-boot.bin.zip \
        https://community.freescale.com/servlet/JiveServlet/downloadBody/93999-102-1-4231/uImage.zip \
        https://community.freescale.com/servlet/JiveServlet/downloadBody/94000-102-1-4232/uImageMaxPower.zip \

# filesystem
echo "Download binaries: filesystem"
$DEBUG wget    $wget_verbose_level \
        https://community.freescale.com/servlet/JiveServlet/downloadBody/94001-102-1-4233/xaa.zip \
        https://community.freescale.com/servlet/JiveServlet/downloadBody/94002-102-1-4234/xab.zip \
        https://community.freescale.com/servlet/JiveServlet/downloadBody/94013-102-1-4235/xac.zip \
        https://community.freescale.com/servlet/JiveServlet/downloadBody/94014-102-1-4236/xad.zip \
        https://community.freescale.com/servlet/JiveServlet/downloadBody/94009-102-1-4238/xae.zip \
        https://community.freescale.com/servlet/JiveServlet/downloadBody/94010-102-1-4239/xaf.zip \
        https://community.freescale.com/servlet/JiveServlet/downloadBody/94011-102-1-4240/xag.zip \
        https://community.freescale.com/servlet/JiveServlet/downloadBody/94012-102-1-4241/xah.zip


echo "Unzip downloaded files"
for i in u*.zip; do $DEBUG unzip $i; done
rootfs=rootfs.tar.bz2; for i in xa*.zip; do $DEBUG gunzip $i -c >> $rootfs; done

tmp_rootfs_folder=`mktemp -d`
$DEBUG sudo tar "xjf$tar_verbose_level" $rootfs -C $tmp_rootfs_folder
                
echo "Flash the SD"
$DEBUG sudo ./mk_image $dev \
                u-boot.bin \
                uImage \
                uImageMaxPower  \
                $tmp_rootfs_folder

#echo "Clean up: remove temporal folders"
$DEBUG cd -

echo "Temporal folders created:"
echo "binaries: $tmp_folder"
echo "rootfs: $tmp_rootfs_folder"
echo
echo "Following steps:"
echo
echo "1. Plug the SD on the target (i.MX6)"
echo "2. Select the correct boot-mode thorugh the Dip switch"
echo "3. Power on"
echo
