#! /bin/bash
# delete sda partition
# default delete sda1 sda2 sda3
echo "d

d

d

w
" | fdisk /dev/sda

# add new sda partition
# default add sda1 sda2 sda3 partition
# add sda1 partition
echo "n
p
1
2048
1026047
w
" | fdisk /dev/sda

# add sda2 partition
echo "n
p
2
1026048
4155391
w
" | fdisk /dev/sda

# add sda3 partition
echo "n
p
3
4155392
31277055
w
" | fdisk /dev/sda

# format sda partition 
# format sda1 partition
echo "y
" | mkfs -t ext4 /dev/sda1

# format sda3 partition
echo "y
" | mkfs -t ext4 /dev/sda3

# restore sda partition within sda.img use of partclone.extfs command
partclone.extfs -r -s /run/initramfs/live/boot_sda1.img -o /dev/sda1
partclone.extfs -r -s /run/initramfs/live/root_sda3.img -o /dev/sda3

# comment swap UUID within etc/fstab because of reboot problem
mount /dev/sda3 /mnt
mount /dev/sda1 /mnt/boot
sed -i "s/UUID=.* swap/#UUID=.* swap/g" /mnt/etc/fstab
umount /mnt/boot
umount /mnt
