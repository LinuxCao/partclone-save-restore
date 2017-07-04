#! /bin/bash
clear
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo "                        Welcome to partclone restore os                         "
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo

echo "restore partition boot in partclone restore from "/mnt/image_directory/boot_sda1.img""
partclone.extfs -r -d -s /mnt/image_directory/boot_sda1.img -o /dev/sda1

echo "restore partition root in partclone restore from "/mnt/image_directory/root_partition_sda2.img""
#gunzip -c /mnt/image_directory/root_partition_sda2.img.gz > /mnt/image_directory/root_partition_sda2.img
partclone.extfs -r -d -s /mnt/image_directory/root_partition_sda2.img -o /dev/sda2

#echo "restore partition /opt/ssd in partclone restore from "/mnt/image_directory/opt_ssd_sda3.img""
#./partclone.extfs -r -d -s /mnt/image_directory/opt_ssd_sda3.img -o /dev/sda3

exit
