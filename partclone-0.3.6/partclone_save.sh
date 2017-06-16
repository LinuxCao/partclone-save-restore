#! /bin/bash
clear
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo "                        Welcome to partclone save os                         "
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo

echo "backup partition boot in partclone save to "/mnt/image_directory/boot_sda1.img""
umount /dev/sda1 
rm -fr /mnt/image_directory/boot_sda1.img
mkdir -p /mnt/image_directory
./src/partclone.extfs -c -d -s /dev/sda1 -o /mnt/image_directory/boot_sda1.img
mount /dev/sda1 /boot
exit
