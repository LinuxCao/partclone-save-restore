#! /bin/bash

SDA='sda'
SDB='sdb'
SDC='sdc'
SDA1='sda1'
SDA2='sda2'
SDA3='sda3'
SDA4='sda4'
SDA5='sda5'
SDA6='sda6'
SDA7='sda7'
SDB1='sdb1'
SDC1='sdc1'

check_sda_sdb_sdc()
{
#检测sda sdb sdc三个磁盘哪个是40 GiB
echo "Detection sda sdb sdc three disk which is 40 GiB"
# Detection sda
fdisk -l /dev/sda | grep -m1 ^Disk | awk '{print $3 " " $4}' | grep 40 > /tmp/sda.info
if [ -z $(cat /tmp/sda.info) ]
then 
	echo "/tmp/sda.info have nothing"
else  
	echo "sda is 40GiB" 
	SDA='sda'
	SDB='sdb'
	SDC='sdc'
	SDA1='sda1'
	SDA2='sda2'
	SDA3='sda3'
	SDA4='sda4'
	SDA5='sda5'
	SDA6='sda6'
	SDA7='sda7'
	SDB1='sdb1'
	SDC1='sdc1'
fi	

# Detection sdb
fdisk -l /dev/sdb | grep -m1 ^Disk | awk '{print $3 " " $4}' | grep 40 > /tmp/sdb.info
if [ -z $(cat /tmp/sdb.info) ]
then
        echo "/tmp/sdb.info have nothing"
else
        echo "sdb is 40GiB"
        SDA='sdb'
        SDB='sda'
        SDC='sdc'
	SDA1='sdb1'
	SDA2='sdb2'
	SDA3='sdb3'
	SDA4='sdb4'
	SDA5='sdb5'
	SDA6='sdb6'
	SDA7='sdb7'
	SDB1='sda1'
	SDC1='sdc1'

fi

# Detection sdc
fdisk -l /dev/sdc | grep -m1 ^Disk | awk '{print $3 " " $4}' | grep 40 > /tmp/sdc.info
if [ -z $(cat /tmp/sdc.info) ]
then
        echo "/tmp/sdc.info have nothing"
else
        echo "sdc is 40GiB"
        SDA='sdc'
        SDB='sdb'
        SDC='sda'
	SDA1='sdc1'
	SDA2='sdc2'
	SDA3='sdc3'
	SDA4='sdc4'
	SDA5='sdc5'
	SDA6='sdc6'
	SDA7='sdc7'
	SDB1='sdb1'
	SDC1='sda1'

fi
}
check_sda_sdb_sdc
echo "SDA ="$SDA
echo "SDB ="$SDB
echo "SDC ="$SDC
echo "SDA1 ="$SDA1
echo "SDA2 ="$SDA2
echo "SDA3 ="$SDA3
echo "SDA4 ="$SDA4
echo "SDA5 ="$SDA5
echo "SDA6 ="$SDA6
echo "SDA7 ="$SDA7
echo "SDB1 ="$SDB1
echo "SDC1 ="$SDC1

#Created a new DOS disklabel with disk
echo "o

w
" | fdisk /dev/$SDA


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
" | fdisk /dev/$SDA


# delete sdb 
echo "d

w
" | fdisk /dev/$SDB

# delete sdc
echo "d

w
" | fdisk /dev/$SDC

# add new sda partition 
# default add sda1 sda2 sda3 sda4 sda5 sda6 sda7 partition
# add centos_boot_partition sda1
echo "n
p
1
2048
1026047
w
" | fdisk /dev/$SDA

# add centos_root_partition sda2
echo "n
p
2
1026048
44038143
w
" | fdisk /dev/$SDA

# add centos_swap_partition sda3
echo "n
p
3
44038144
48232447
t
3
82
w
" | fdisk /dev/$SDA

# add Extended Partition sda4
echo "n
e
48232448
83886079
w
" | fdisk /dev/$SDA

# add fedora_boot_partition sda5
echo "n
48234496
49258495
w
" | fdisk /dev/$SDA

# add fedora_root_partition sda6
echo "n
49260544
80318463
w
" | fdisk /dev/$SDA

# add fedora_swap_partition sda7
echo "n
80320512
83886079
t
7
82
w
" | fdisk /dev/$SDA

# add /opt/sata partition sdb1
echo "n
p
1
2048

w
" | fdisk /dev/$SDB

# add /opt/ssd partition sdc1
echo "n
p
1
2048

w
" | fdisk /dev/$SDC


# specifies the flag for the boot partition default = /dev/sda5
echo "a
5

w
" | fdisk /dev/$SDA

# check /dev/sda partition information
echo "p
" | fdisk /dev/$SDA

echo "p
" | fdisk /dev/$SDB

echo "p
" | fdisk /dev/$SDC

# format sda partititon
# format centos_boot_partition sda1
echo "y
" | mkfs -t ext4 /dev/$SDA1

# format centos_root_partition sda2
echo "y
" | mkfs -t ext4 /dev/$SDA2

# format centos swap partition sda3
swapoff /dev/$SDA3
mkswap /dev/$SDA3

# format fedora_boot_partition sda5
echo "y
" | mkfs -t ext4 /dev/$SDA5

# format fedora_root_partition sda6
echo "y
" | mkfs -t ext4 /dev/$SDA6

# format fedora_swap_partition sda7
swapoff /dev/$SDA7
mkswap /dev/$SDA7

# format centos_opt_sata_partition sdb1
echo "y
" | mkfs -t ext4 /dev/$SDB1

# format centos_opt_ssd_partition sdc1
echo "y
" | mkfs -t ext4 /dev/$SDC1



# restore sda sdb sdc partition use of partclone.extfs command
partclone.extfs -r -s /run/media/liveuser/Fedora-23/mnt/image_directory/centos_boot_sda1.img -o /dev/$SDA1
partclone.extfs -r -s /run/media/liveuser/Fedora-23/mnt/image_directory/centos_root_sda2.img -o /dev/$SDA2
partclone.extfs -r -s /run/media/liveuser/Fedora-23/mnt/image_directory/fedora_boot_sda5.img -o /dev/$SDA5
partclone.extfs -r -s /run/media/liveuser/Fedora-23/mnt/image_directory/fedora_root_sda6.img -o /dev/$SDA6
#partclone.extfs -r -s /run/media/liveuser/Fedora-23/mnt/image_directory/centos_opt_sata_sdb1.img -o /dev/$SDB1
#partclone.extfs -r -s /run/media/liveuser/Fedora-23/mnt/image_directory/centos_opt_ssd_sdc1.img -o /dev/$SDC1

# get all partition UUID
SDA1_UUID=`blkid  /dev/$SDA1 | grep -m1 UUID | awk '{print $2}' | sed 's/\"//g'`
SDA2_UUID=`blkid  /dev/$SDA2 | grep -m1 UUID | awk '{print $2}' | sed 's/\"//g'`
SDA3_UUID=`blkid  /dev/$SDA3 | grep -m1 UUID | awk '{print $2}' | sed 's/\"//g'`
SDB1_UUID=`blkid  /dev/$SDB1 | grep -m1 UUID | awk '{print $2}' | sed 's/\"//g'`
SDC1_UUID=`blkid  /dev/$SDC1 | grep -m1 UUID | awk '{print $2}' | sed 's/\"//g'`
SDA5_UUID=`blkid  /dev/$SDA5 | grep -m1 UUID | awk '{print $2}' | sed 's/\"//g'`
SDA6_UUID=`blkid  /dev/$SDA6 | grep -m1 UUID | awk '{print $2}' | sed 's/\"//g'`
SDA7_UUID=`blkid  /dev/$SDA7 | grep -m1 UUID | awk '{print $2}' | sed 's/\"//g'`

echo "/dev/$SDA1: ""SDA1_UUID="$SDA1_UUID
echo "/dev/$SDA2: ""SDA2_UUID="$SDA2_UUID
echo "/dev/$SDA3: ""SDA3_UUID="$SDA3_UUID
echo "/dev/$SDB1: ""SDB1_UUID="$SDB1_UUID
echo "/dev/$SDC1: ""SDC1_UUID="$SDC1_UUID
echo "/dev/$SDA5: ""SDC1_UUID="$SDA5_UUID
echo "/dev/$SDA6: ""SDC1_UUID="$SDA6_UUID
echo "/dev/$SDA7: ""SDC1_UUID="$SDA7_UUID

# comment swap UUID but /dev/sdaX table within etc/fstab because of reboot problem
mount /dev/$SDA2 /mnt
mount /dev/$SDA1 /mnt/boot
#sed -i "s/UUID=.* swap/#UUID=.* swap/g" /mnt/etc/fstab
#echo "/dev/sda3 swap swap defaults 0 0" >> /mnt/etc/fstab
cp -f /opt/partclone-0.3.6/centos_etc_fstab /mnt/etc/fstab

echo "$SDA2_UUID	/ 	ext4 	defaults 	1 1" >> /mnt/etc/fstab
echo "$SDA1_UUID 	/boot 	ext4 	defaults 	1 2" >> /mnt/etc/fstab
echo "$SDB1_UUID 	/opt/sata 	ext4 	defaults 	1 2" >> /mnt/etc/fstab
echo "$SDC1_UUID 	/opt/ssd 	ext4 	defaults 	1 2" >> /mnt/etc/fstab
echo "$SDA3_UUID 	swap 	swap 	defaults 	0 0" >> /mnt/etc/fstab

umount /mnt/boot
umount /mnt

mount /dev/$SDA6 /mnt
mount /dev/$SDA5 /mnt/boot
#sed -i "s/UUID=.* swap/#UUID=.* swap/g" /mnt/etc/fstab
#echo "/dev/sda7 swap swap defaults 0 0" >> /mnt/etc/fstab
cp -f /opt/partclone-0.3.6/fedora_etc_fstab /mnt/etc/fstab

echo "$SDA6_UUID	/ 	ext4 	defaults 	1 1" >> /mnt/etc/fstab
echo "$SDA5_UUID 	/boot 	ext4 	defaults 	1 2" >> /mnt/etc/fstab
echo "$SDA7_UUID 	swap 	swap 	defaults 	0 0" >> /mnt/etc/fstab

umount /mnt/boot
umount /mnt

# Copy the centos image file to the fedora root partition
mount /dev/$SDA6 /mnt
mount /dev/$SDA5 /mnt/boot
mkdir -p /mnt/mnt/image_directory
echo "Copying the centos image file to the fedora root partition.......Please wait a while for 5 minutes..."
#/bin/cp -f /run/media/liveuser/Fedora-23/mnt/image_directory/centos_boot_sda1.img /mnt/mnt/image_directory/
#/bin/cp -f /run/media/liveuser/Fedora-23/mnt/image_directory/centos_root_sda2.img /mnt/mnt/image_directory/
umount /mnt/boot
umount /mnt

# specifies bootloader driver when boot system
mount /dev/$SDA6 /mnt
mount /dev/$SDA5 /mnt/boot
grub2-install --root-directory=/mnt /dev/$SDA
umount /mnt/boot
umount /mnt

echo "Partclone finshed! Please Reboot!"
