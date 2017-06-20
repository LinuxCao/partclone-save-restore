#! /bin/bash
clear
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo "                        Welcome to partclone save os                         "
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo

echo "backup partition boot in partclone save to "/mnt/image_directory/boot_sda1.img""
rm -fr /mnt/image_directory/boot_sda1.img
mkdir -p /mnt/image_directory
./partclone.extfs -c -d -s /dev/sda1 -o /mnt/image_directory/boot_sda1.img

echo "backup partition / in partclone save to "/mnt/image_directory/root_partition_sda2.img""
rm -fr /mnt/image_directory/root_partition_sda2.img
./partclone.extfs -c -d -s /dev/sda2 -o /mnt/image_directory/root_partition_sda2.img
gzip -c -1 /mnt/image_directory/root_partition_sda2.img > /mnt/image_directory/root_partition_sda2.img.gz

#echo "backup partition /opt/ssd in partclone save to "/mnt/image_directory/opt_ssd_sda3.img""
#rm -fr /mnt/image_directory/opt_ssd_sda3.img
#./partclone.extfs -c -d -s /dev/sda3 -o /mnt/image_directory/opt_ssd_sda3.img

exit
