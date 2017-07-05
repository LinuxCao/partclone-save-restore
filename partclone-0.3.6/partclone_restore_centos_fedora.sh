#! /bin/bash
# delete sda partition
# default delete sda1 sda2 sda3 sda5 sda6 sda7
# delete extended sda4
echo "d

d

d

d

d

d

d

w
" | fdisk /dev/sda

# delete sdb partition
# default delete sdb1
echo "d

w
" | fdisk /dev/sdb

# delete sdc partition
# default delete sdc1
echo "d

w
" | fdisk /dev/sdc




# update kernel partition tabel
#sudo partprobe

# add new sda partition 
# default add sda1 sda2 sda3 sda4 sda5 sda6 sda7 partition
# add centos_boot_partition sda1
echo "n
p
1
2048
1026047
w
" | fdisk /dev/sda

# add centos_root_partition sda2
echo "n
p
2
1026048
44038143
w
" | fdisk /dev/sda

# add centos_swap_partition sda3
echo "n
p
3
44038144
48234495
t
3
L
82
w
" | fdisk /dev/sda

# add Extended Partition sda4
echo "n
e
48234496
83886079
w
" | fdisk /dev/sda

# add fedora_boot_partition sda5
echo "n
48238592
49262591
w
" | fdisk /dev/sda

# add fedora_root_partition sda6
echo "n
49264640
80320511
w
" | fdisk /dev/sda

# add fedora_swap_partition sda7
echo "n
80322560
83886079
t
7
L
82
w
" | fdisk /dev/sda


# add opt_sata_partition sdb1
echo "n
p
1
2048
16779263
w
" | fdisk /dev/sdb


# add opt_ssd_partition sdc1
echo "n
p
1
2048
16779263
w
" | fdisk /dev/sdc




# format sda partititon
# format centos_boot_partition sda1
echo "y
" | mkfs -t ext4 /dev/sda1

# format centos_root_partition sda2
echo "y
" | mkfs -t ext4 /dev/sda2

# format fedora_boot_partition sda5
echo "y
" | mkfs -t ext4 /dev/sda5

# format fedora_root_partition sda6
echo "y
" | mkfs -t ext4 /dev/sda6

# format sdb partition
# format centos_opt_sata_partition sdb1
echo "y
" | mkfs -t ext4 /dev/sdb1

# format centos_opt_ssd_partition sdc1
echo "y
" | mkfs -t ext4 /dev/sdc1

# restore sda sdb sdc partition use of partclone.extfs command
partclone.extfs -r -s /run/media/liveuser/Fedora-23/mnt/image_directory/centos_boot_sda1.img -o /dev/sda1
partclone.extfs -r -s /run/media/liveuser/Fedora-23/mnt/image_directory/centos_root_sda2.img -o /dev/sda2
partclone.extfs -r -s /run/media/liveuser/Fedora-23/mnt/image_directory/centos_opt_sata_sdb1.img -o /dev/sdb1
partclone.extfs -r -s /run/media/liveuser/Fedora-23/mnt/image_directory/centos_opt_ssd_sdc1.img -o /dev/sdc1
partclone.extfs -r -s /run/media/liveuser/Fedora-23/mnt/image_directory/fedora_boot_sda5.img -o /dev/sda5
partclone.extfs -r -s /run/media/liveuser/Fedora-23/mnt/image_directory/fedora_root_sda6.img -o /dev/sda6




# comment swap UUID but /dev/sdaX table within etc/fstab because of reboot problem
mount /dev/sda2 /mnt
mount /dev/sda1 /mnt/boot
sed -i "s/UUID=.* swap/#UUID=.* swap/g" /mnt/etc/fstab
echo "/dev/sda3 swap swap defaults 0 0" >> /mnt/etc/fstab
umount /mnt/boot
umount /mnt

mount /dev/sda6 /mnt
mount /dev/sda5 /mnt/boot
sed -i "s/UUID=.* swap/#UUID=.* swap/g" /mnt/etc/fstab
echo "/dev/sda7 swap swap defaults 0 0" >> /mnt/etc/fstab
umount /mnt/boot
umount /mnt

