#! /bin/bash
#Created a new DOS disklabel with disk
echo "o

w
" | fdisk /dev/sda


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
21997567
w
" | fdisk /dev/sda

# add centos_swap_partition sda3
echo "n
p
3
21997568
26191871
t
3
82
w
" | fdisk /dev/sda

# add Extended Partition sda4
echo "n
e
26191872
61865983
w
" | fdisk /dev/sda

# add fedora_boot_partition sda5
echo "n
26195968
27219967
w
" | fdisk /dev/sda

# add fedora_root_partition sda6
echo "n
27222016
58298367
w
" | fdisk /dev/sda

# add fedora_swap_partition sda7
echo "n
58300416
61865983
t
7
82
w
" | fdisk /dev/sda


# specifies the flag for the boot partition default = /dev/sda5
echo "a
5

w
" | fdisk /dev/sda

# check /dev/sda partition information
echo "p
" | fdisk /dev/sda


# format sda partititon
# format centos_boot_partition sda1
echo "y
" | mkfs -t ext4 /dev/sda1

# format centos_root_partition sda2
echo "y
" | mkfs -t ext4 /dev/sda2

# format centos swap partition sda3
swapoff /dev/sda3
mkswap /dev/sda3

# format fedora_boot_partition sda5
echo "y
" | mkfs -t ext4 /dev/sda5

# format fedora_root_partition sda6
echo "y
" | mkfs -t ext4 /dev/sda6

# format fedora_swap_partition sda7
swapoff /dev/sda7
mkswap /dev/sda7



# restore sda sdb sdc partition use of partclone.extfs command
partclone.extfs -r -s /run/media/liveuser/Fedora-23/mnt/image_directory/centos_boot_sda1.img -o /dev/sda1
partclone.extfs -r -s /run/media/liveuser/Fedora-23/mnt/image_directory/centos_root_sda2.img -o /dev/sda2
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


# Copy the centos image file to the fedora root partition
mount /dev/sda6 /mnt
mount /dev/sda5 /mnt/boot
mkdir -p /mnt/mnt/image_directory
echo "Copying the centos image file to the fedora root partition.......Please wait a while for 5 minutes..."
/bin/cp -f /run/media/liveuser/Fedora-23/mnt/image_directory/centos_boot_sda1.img /mnt/mnt/image_directory/
/bin/cp -f /run/media/liveuser/Fedora-23/mnt/image_directory/centos_root_sda2.img /mnt/mnt/image_directory/
umount /mnt/boot
umount /mnt

# specifies bootloader driver when boot system
mount /dev/sda6 /mnt
mount /dev/sda5 /mnt/boot
grub2-install --root-directory=/mnt /dev/sda
umount /mnt/boot
umount /mnt


echo "Partclone finshed! Please Reboot!"
