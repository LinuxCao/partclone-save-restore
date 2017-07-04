#! /bin/bash
clear
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo "               Welcome to partclone save centos and fedora double os           "
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo

rm -fr /run/media/liveuser/Fedora-23/mnt/image_directory/centos_boot_sda1.img
mkdir -p /run/media/liveuser/Fedora-23/mnt/image_directory
partclone.extfs -c -d -s /dev/sda1 -o /run/media/liveuser/Fedora-23/mnt/image_directory/centos_boot_sda1.img


rm -fr /run/media/liveuser/Fedora-23/mnt/image_directory/centos_root_sda2.img
partclone.extfs -c -d -s /dev/sda2 -o /run/media/liveuser/Fedora-23/mnt/image_directory/centos_root_sda2.img

rm -fr /run/media/liveuser/Fedora-23/mnt/image_directory/centos_opt_sata_sdb1.img
partclone.extfs -c -d -s /dev/sdb1 -o /run/media/liveuser/Fedora-23/mnt/image_directory/centos_opt_sata_sdb1.img

rm -fr /run/media/liveuser/Fedora-23/mnt/image_directory/centos_opt_ssd_sdc1.img
partclone.extfs -c -d -s /dev/sdc1 -o /run/media/liveuser/Fedora-23/mnt/image_directory/centos_opt_ssd_sdc1.img

rm -fr /run/media/liveuser/Fedora-23/mnt/image_directory/fedora_boot_sda5.img
partclone.extfs -c -d -s /dev/sda5 -o /run/media/liveuser/Fedora-23/mnt/image_directory/fedora_boot_sda5.img


rm -fr /run/media/liveuser/Fedora-23/mnt/image_directory/fedora_root_sda6.img
partclone.extfs -c -d -s /dev/sda6 -o /run/media/liveuser/Fedora-23/mnt/image_directory/fedora_root_sda6.img

exit
