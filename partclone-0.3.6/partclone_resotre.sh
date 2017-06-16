#! /bin/bash
clear
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo "                        Welcome to partclone save os                         "
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo

echo "restore partition boot in partclone restore from "/mnt/image_directory/boot_sda1.img""
umount /dev/sda1 
./src/partclone.extfs -r -d -s /mnt/image_directory/boot_sda1.img -o /dev/sda1
mount /dev/sda1 /boot
exit
