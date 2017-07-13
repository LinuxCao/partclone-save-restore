#! /bin/bash
clear
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo "                        Welcome to partclone restore centos os                         "
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo

# restore sda sdb sdc partition use of partclone.extfs command
partclone.extfs -r -d -s /mnt/image_directory/centos_boot_sda1.img -o /dev/sda1

partclone.extfs -r -d -s /mnt/image_directory/centos_root_sda2.img -o /dev/sda2

# comment swap UUID but /dev/sdaX table within etc/fstab because of reboot problem
mount /dev/sda2 /mnt
mount /dev/sda1 /mnt/boot
#sed -i "s/UUID=.* swap/#UUID=.* swap/g" /mnt/etc/fstab
#echo "/dev/sda3 swap swap defaults 0 0" >> /mnt/etc/fstab
cp -f /opt/partclone-0.3.6/centos_etc_fstab /mnt/etc/fstab
umount /mnt/boot
umount /mnt

reboot
exit
