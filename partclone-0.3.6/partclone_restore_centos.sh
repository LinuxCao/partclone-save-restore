#! /bin/bash
clear
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo "                        Welcome to partclone restore centos os                         "
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo

partclone.extfs -r -d -s /mnt/image_directory/centos_boot_sda1.img -o /dev/sda1

partclone.extfs -r -d -s /mnt/image_directory/centos_root_sda2.img -o /dev/sda2


exit
