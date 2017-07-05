#! /bin/bash
clear
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo "                        Welcome to partclone save centos os                         "
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo

rm -fr /mnt/image_directory/centos_boot_sda1.img
mkdir -p /mnt/image_directory
partclone.extfs -c -d -s /dev/sda1 -o /mnt/image_directory/centos_boot_sda1.img

rm -fr /mnt/image_directory/centos_root_sda2.img
partclone.extfs -c -d -s /dev/sda2 -o /mnt/image_directory/centos_root_sda2.img


exit
