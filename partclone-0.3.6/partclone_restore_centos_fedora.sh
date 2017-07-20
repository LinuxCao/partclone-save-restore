#! /bin/bash
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo "                        Welcome to partclone restore centos os      "
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo
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
standard_disk_size=900.2
restore_image_directory="/run/initramfs/live/mnt/image_directory"

SDA1_START=2048
SDA1_END=1026047
SDA2_START=1026048
SDA2_END=1678747647
SDA3_START=1678747648
SDA3_END=1687136255
SDA4_START=1687136256
SDA4_END=1953523711
SDA5_START=1687138304
SDA5_END=1688162303
SDA6_START=1688164352
SDA6_END=1793021951
SDA7_START=1793024000
SDA7_END=1801412607

check_sda_sdb_sdc()
{
echo "check_sda_sdb_sdc"
#检测sda sdb sdc三个磁盘哪个是40 GiB
echo "Detection sda sdb sdc three disk which is greater than $standard_disk_size GiB standard_disk_size"
# Detection sda
#fdisk -l /dev/sda | grep -m1 ^Disk | awk '{print $3 " " $4}' | grep 40 > /tmp/sda.info
sda_disk_size=`fdisk -l /dev/sda | grep -m1 ^Disk | awk '{print $3}'`
echo "sda_disk_size="$sda_disk_size
if [ `echo "$sda_disk_size < $standard_disk_size" | bc ` -eq 1 ]
then 
	echo "sda_disk_size is smaller than $standard_disk_size GiB standard_disk_size"
else  
	echo "sda_disk_size is greater than $standard_disk_size GiB standard_disk_size"
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
#fdisk -l /dev/sdb | grep -m1 ^Disk | awk '{print $3 " " $4}' | grep 40 > /tmp/sdb.info
sdb_disk_size=`fdisk -l /dev/sdb | grep -m1 ^Disk | awk '{print $3}'`
echo "sdb_disk_size="$sdb_disk_size
if [ `echo "$sdb_disk_size < $standard_disk_size" | bc ` -eq 1 ]
then 
	echo "sdb_disk_size is smaller than $standard_disk_size GiB standard_disk_size"
else  
	echo "sdb_disk_size is greater than $standard_disk_size GiB standard_disk_size"
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
#fdisk -l /dev/sdc | grep -m1 ^Disk | awk '{print $3 " " $4}' | grep 40 > /tmp/sdc.info
sdc_disk_size=`fdisk -l /dev/sdc | grep -m1 ^Disk | awk '{print $3}'`
echo "sdc_disk_size="$sdc_disk_size
if [ `echo "$sdc_disk_size < $standard_disk_size" | bc ` -eq 1 ]
then 
	echo "sdc_disk_size is smaller than $standard_disk_size GiB standard_disk_size"
else  
	echo "sdc_disk_size is greater than $standard_disk_size GiB standard_disk_size"
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
}

check_sdb_sdc_sdd()
{
echo "check_sdb_sdc_sdd"
#检测sdb sdc sdd三个磁盘哪个是40 GiB
echo "Detection sdb sdc sdd three disk which is greater than $standard_disk_size GiB standard_disk_size"
# Detection sdb
#fdisk -l /dev/sdb | grep -m1 ^Disk | awk '{print $3 " " $4}' | grep 40 > /tmp/sdb.info
sdb_disk_size=`fdisk -l /dev/sdb | grep -m1 ^Disk | awk '{print $3}'`
echo "sdb_disk_size="$sdb_disk_size
if [ `echo "$sdb_disk_size < $standard_disk_size" | bc ` -eq 1 ]
then 
	echo "sdb_disk_size is smaller than $standard_disk_size GiB standard_disk_size"
else  
	echo "sdb_disk_size is greater than $standard_disk_size GiB standard_disk_size"
	SDA='sdb'
	SDB='sdc'
	SDC='sdd'
	SDA1='sdb1'
	SDA2='sdb2'
	SDA3='sdb3'
	SDA4='sdb4'
	SDA5='sdb5'
	SDA6='sdb6'
	SDA7='sdb7'
	SDB1='sdc1'
	SDC1='sdd1'
fi	

# Detection sdc
#fdisk -l /dev/sdc | grep -m1 ^Disk | awk '{print $3 " " $4}' | grep 40 > /tmp/sdc.info
sdc_disk_size=`fdisk -l /dev/sdc | grep -m1 ^Disk | awk '{print $3}'`
echo "sdc_disk_size="$sdc_disk_size
if [ `echo "$sdc_disk_size < $standard_disk_size" | bc ` -eq 1 ]
then 
	echo "sdc_disk_size is smaller than $standard_disk_size GiB standard_disk_size"
else  
	echo "sdc_disk_size is greater than $standard_disk_size GiB standard_disk_size"
	SDA='sdc'
	SDB='sdb'
	SDC='sdd'
	SDA1='sdc1'
	SDA2='sdc2'
	SDA3='sdc3'
	SDA4='sdc4'
	SDA5='sdc5'
	SDA6='sdc6'
	SDA7='sdc7'
	SDB1='sdb1'
	SDC1='sdd1'

fi

# Detection sdd
#fdisk -l /dev/sdd | grep -m1 ^Disk | awk '{print $3 " " $4}' | grep 40 > /tmp/sdd.info
sdd_disk_size=`fdisk -l /dev/sdd | grep -m1 ^Disk | awk '{print $3}'`
echo "sdd_disk_size="$sdd_disk_size
if [ `echo "$sdd_disk_size < $standard_disk_size" | bc ` -eq 1 ]
then 
	echo "sdd_disk_size is smaller than $standard_disk_size GiB standard_disk_size"
else  
	echo "sdd_disk_size is greater than $standard_disk_size GiB standard_disk_size"
	SDA='sdd'
	SDB='sdb'
	SDC='sdc'
	SDA1='sdd1'
	SDA2='sdd2'
	SDA3='sdd3'
	SDA4='sdd4'
	SDA5='sdd5'
	SDA6='sdd6'
	SDA7='sdd7'
	SDB1='sdb1'
	SDC1='sdc1'

fi
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
}


check_sda_sdc_sdd()
{
echo "check_sda_sdc_sdd"
#检测sda sdc sdd三个磁盘哪个是40 GiB
echo "Detection sda sdc sdd three disk which is greater than $standard_disk_size GiB standard_disk_size"
# Detection sda
#fdisk -l /dev/sda | grep -m1 ^Disk | awk '{print $3 " " $4}' | grep 40 > /tmp/sda.info
sda_disk_size=`fdisk -l /dev/sda | grep -m1 ^Disk | awk '{print $3}'`
echo "sda_disk_size="$sda_disk_size
if [ `echo "$sda_disk_size < $standard_disk_size" | bc ` -eq 1 ]
then 
	echo "sda_disk_size is smaller than $standard_disk_size GiB standard_disk_size"
else  
	echo "sda_disk_size is greater than $standard_disk_size GiB standard_disk_size"
	SDA='sda'
	SDB='sdd'
	SDC='sdc'
	SDA1='sda1'
	SDA2='sda2'
	SDA3='sda3'
	SDA4='sda4'
	SDA5='sda5'
	SDA6='sda6'
	SDA7='sda7'
	SDB1='sdd1'
	SDC1='sdc1'
fi	

# Detection sdc
#fdisk -l /dev/sdc | grep -m1 ^Disk | awk '{print $3 " " $4}' | grep 40 > /tmp/sdc.info
sdc_disk_size=`fdisk -l /dev/sdc | grep -m1 ^Disk | awk '{print $3}'`
echo "sdc_disk_size="$sdc_disk_size
if [ `echo "$sdc_disk_size < $standard_disk_size" | bc ` -eq 1 ]
then 
	echo "sdc_disk_size is smaller than $standard_disk_size GiB standard_disk_size"
else  
	echo "sdc_disk_size is greater than $standard_disk_size GiB standard_disk_size"
	SDA='sdc'
	SDB='sdd'
	SDC='sda'
	SDA1='sdc1'
	SDA2='sdc2'
	SDA3='sdc3'
	SDA4='sdc4'
	SDA5='sdc5'
	SDA6='sdc6'
	SDA7='sdc7'
	SDB1='sdd1'
	SDC1='sda1'

fi

# Detection sdd
#fdisk -l /dev/sdd | grep -m1 ^Disk | awk '{print $3 " " $4}' | grep 40 > /tmp/sdd.info
sdd_disk_size=`fdisk -l /dev/sdd | grep -m1 ^Disk | awk '{print $3}'`
echo "sdd_disk_size="$sdd_disk_size
if [ `echo "$sdd_disk_size < $standard_disk_size" | bc ` -eq 1 ]
then 
	echo "sdd_disk_size is smaller than $standard_disk_size GiB standard_disk_size"
else  
	echo "sdd_disk_size is greater than $standard_disk_size GiB standard_disk_size"
	SDA='sdd'
	SDB='sda'
	SDC='sdc'
	SDA1='sdd1'
	SDA2='sdd2'
	SDA3='sdd3'
	SDA4='sdd4'
	SDA5='sdd5'
	SDA6='sdd6'
	SDA7='sdd7'
	SDB1='sda1'
	SDC1='sdc1'

fi

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
}


check_sda_sdb_sdd()
{
echo "check_sda_sdb_sdd"
#检测sda sdb sdd三个磁盘哪个是40 GiB
echo "Detection sda sdb sdd three disk which is greater than $standard_disk_size GiB standard_disk_size"
# Detection sda
#fdisk -l /dev/sda | grep -m1 ^Disk | awk '{print $3 " " $4}' | grep 40 > /tmp/sda.info
sda_disk_size=`fdisk -l /dev/sda | grep -m1 ^Disk | awk '{print $3}'`
echo "sda_disk_size="$sda_disk_size
if [ `echo "$sda_disk_size < $standard_disk_size" | bc ` -eq 1 ]
then 
	echo "sda_disk_size is smaller than $standard_disk_size GiB standard_disk_size"
else  
	echo "sda_disk_size is greater than $standard_disk_size GiB standard_disk_size"
	SDA='sda'
	SDB='sdb'
	SDC='sdd'
	SDA1='sda1'
	SDA2='sda2'
	SDA3='sda3'
	SDA4='sda4'
	SDA5='sda5'
	SDA6='sda6'
	SDA7='sda7'
	SDB1='sdb1'
	SDC1='sdd1'
fi	

# Detection sdb
#fdisk -l /dev/sdb | grep -m1 ^Disk | awk '{print $3 " " $4}' | grep 40 > /tmp/sdb.info
sdb_disk_size=`fdisk -l /dev/sdb | grep -m1 ^Disk | awk '{print $3}'`
echo "sdb_disk_size="$sdb_disk_size
if [ `echo "$sdb_disk_size < $standard_disk_size" | bc ` -eq 1 ]
then 
	echo "sdb_disk_size is smaller than $standard_disk_size GiB standard_disk_size"
else  
	echo "sdb_disk_size is greater than $standard_disk_size GiB standard_disk_size"
	SDA='sdb'
	SDB='sdd'
	SDC='sda'
	SDA1='sdb1'
	SDA2='sdb2'
	SDA3='sdb3'
	SDA4='sdb4'
	SDA5='sdb5'
	SDA6='sdb6'
	SDA7='sdb7'
	SDB1='sdd1'
	SDC1='sda1'

fi

# Detection sdd
#fdisk -l /dev/sdd | grep -m1 ^Disk | awk '{print $3 " " $4}' | grep 40 > /tmp/sdd.info
sdd_disk_size=`fdisk -l /dev/sdd | grep -m1 ^Disk | awk '{print $3}'`
echo "sdd_disk_size="$sdd_disk_size
if [ `echo "$sdd_disk_size < $standard_disk_size" | bc ` -eq 1 ]
then 
	echo "sdd_disk_size is smaller than $standard_disk_size GiB standard_disk_size"
else  
	echo "sdd_disk_size is greater than $standard_disk_size GiB standard_disk_size"
	SDA='sdd'
	SDB='sdb'
	SDC='sda'
	SDA1='sdd1'
	SDA2='sdd2'
	SDA3='sdd3'
	SDA4='sdd4'
	SDA5='sdd5'
	SDA6='sdd6'
	SDA7='sdd7'
	SDB1='sdb1'
	SDC1='sda1'

fi

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
}

check_usb_device()
{
    echo "check_usb_device to exclude usb device when partclone"
    ls -l /sys/block/sdd > /tmp/sdd_is_usb.info
    ls -l /sys/block/sdc > /tmp/sdc_is_usb.info
    ls -l /sys/block/sdb > /tmp/sdb_is_usb.info
    ls -l /sys/block/sda > /tmp/sda_is_usb.info
    if [[ ! -z $(cat /tmp/sdd_is_usb.info | grep usb) ]]
    then
        type=sda_sdb_sdc
		usb_type=sdd
    elif [[ ! -z $(cat /tmp/sdc_is_usb.info | grep usb) ]]
    then
        type=sda_sdb_sdd
		usb_type=sdc
    elif [[ ! -z $(cat /tmp/sdb_is_usb.info | grep usb) ]]
    then
        type=sda_sdc_sdd
		usb_type=sdb
    elif [[ ! -z $(cat /tmp/sda_is_usb.info | grep usb) ]]
    then
        type=sdb_sdc_sdd
		usb_type=sda
    fi
}

check_usb_device
echo "Hard Disk Type ="$type
echo "USB Device Type ="$usb_type
echo "restore_image_directory ="$restore_image_directory



do_partclone_restore()
{
echo "do_partclone_restore"

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

d

d

d

d

d

d

w
" | fdisk /dev/$SDB

# delete sdc
echo "d

d

d

d

d

d

d

w
" | fdisk /dev/$SDC

sudo partprobe

# add new sda partition 
# default add sda1 sda2 sda3 sda4 sda5 sda6 sda7 partition
# add centos_boot_partition sda1
echo "n
p
1
$SDA1_START
$SDA1_END
w
" | fdisk /dev/$SDA

# add centos_root_partition sda2
echo "n
p
2
$SDA2_START
$SDA2_END
w
" | fdisk /dev/$SDA

# add centos_swap_partition sda3
echo "n
p
3
$SDA3_START
$SDA3_END
t
3
82
w
" | fdisk /dev/$SDA

# add Extended Partition sda4
echo "n
e
$SDA4_START
$SDA4_END
w
" | fdisk /dev/$SDA

# add fedora_boot_partition sda5
echo "n
$SDA5_START
$SDA5_END
w
" | fdisk /dev/$SDA

# add fedora_root_partition sda6
echo "n
$SDA6_START
$SDA6_END
w
" | fdisk /dev/$SDA

# add fedora_swap_partition sda7
echo "n
$SDA7_START
$SDA7_END
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

sudo partprobe


# specifies the flag for the boot partition default = /dev/sda1
echo "a
1

w
" | fdisk /dev/$SDA

sudo partprobe

# check /dev/sda partition information
echo "p
" | fdisk /dev/$SDA

echo "p
" | fdisk /dev/$SDB

echo "p
" | fdisk /dev/$SDC


sudo partprobe

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

sudo partprobe



# restore sda sdb sdc partition use of partclone.extfs command
# partclone restore centos_boot_partition.img
partclone.extfs -r -d -s $restore_image_directory/centos_boot_partition.img -o /dev/$SDA1
# partclone restore centos_root_partition.img
# gzip centos_root_partition.img
#echo "gunzip the centos_root_partition.img.gz to centos_root_partition.img.......Please wait a while for 5 minutes..."
#gunzip -c $restore_image_directory/centos_root_partition.img.gz > $restore_image_directory/centos_root_partition.img
partclone.extfs -r -d -s $restore_image_directory/centos_root_partition.img -o /dev/$SDA2

# partclone restore fedora_boot_partition.img
partclone.extfs -r -d -s $restore_image_directory/fedora_boot_partition.img -o /dev/$SDA5
# partclone restore fedora_root_partition.img
partclone.extfs -r -d -s $restore_image_directory/fedora_root_partition.img -o /dev/$SDA6


# get all new partition UUID
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
echo "/dev/$SDA5: ""SDA5_UUID="$SDA5_UUID
echo "/dev/$SDA6: ""SDA6_UUID="$SDA6_UUID
echo "/dev/$SDA7: ""SDA7_UUID="$SDA7_UUID


#Mask the old UUID to replace the new UUID instead:swap /opt/sata /opt/ssd centos system
mount /dev/$SDA2 /mnt
mount /dev/$SDA1 /mnt/boot
cp -f /opt/partclone-0.3.6/centos_etc_fstab /mnt/etc/fstab
echo "$SDA1_UUID 	/boot 	ext4 	defaults 	1 2" >> /mnt/etc/fstab
echo "$SDA2_UUID	/ 	ext4 	defaults 	1 1" >> /mnt/etc/fstab
echo "$SDB1_UUID 	/opt/sata 	ext4 	defaults 	1 2" >> /mnt/etc/fstab
echo "$SDC1_UUID 	/opt/ssd 	ext4 	defaults 	1 2" >> /mnt/etc/fstab
echo "$SDA3_UUID 	swap 	swap 	defaults 	0 0" >> /mnt/etc/fstab
umount /mnt/boot
umount /mnt

#Mask the old UUID to replace the new UUID instead:swap fedora system
mount /dev/$SDA6 /mnt
mount /dev/$SDA5 /mnt/boot
cp -f /opt/partclone-0.3.6/fedora_etc_fstab /mnt/etc/fstab
echo "$SDA5_UUID 	/boot 	ext4 	defaults 	1 2" >> /mnt/etc/fstab
echo "$SDA6_UUID	/ 	ext4 	defaults 	1 1" >> /mnt/etc/fstab
echo "$SDA7_UUID 	swap 	swap 	defaults 	0 0" >> /mnt/etc/fstab
umount /mnt/boot
umount /mnt


# Clone the centos image file to the fedora root partition
mount /dev/$SDA6 /mnt
mount /dev/$SDA5 /mnt/boot
mkdir -p /mnt/mnt/image_directory
echo "Clone the centos image file to the fedora root partition.......Please wait a while for 5 minutes..."
rm -fr /mnt/mnt/image_directory/centos_boot_partition.img
fsck /dev/$SDA1
partclone.extfs -c -d -s /dev/$SDA1 -o /mnt/mnt/image_directory/centos_boot_partition.img
rm -fr /mnt/mnt/image_directory/centos_root_partition.img
fsck /dev/$SDA2
partclone.extfs -c -d -s /dev/$SDA2 -o /mnt/mnt/image_directory/centos_root_partition.img
umount /mnt/boot
umount /mnt


# specifies bootloader driver when boot system
mount /dev/$SDA6 /mnt
mount /dev/$SDA5 /mnt/boot
#grub2-install --root-directory=/mnt /dev/$SDA
grub2-install --boot-directory=/mnt/boot /dev/$SDA
umount /mnt/boot
umount /mnt

echo "Partclone finshed! Please Reboot!"

}


main()
{
	#while true; do
			#read -p "请输入需要打包的类型[1~9]:" type
			case $type in
					sda_sdb_sdc*)
							check_sda_sdb_sdc
							do_partclone_restore
							exit
							;;
					sda_sdb_sdd*)
							check_sda_sdb_sdd
							do_partclone_restore
							exit
							;;
					sda_sdc_sdd*)
							check_sda_sdc_sdd
							do_partclone_restore
							exit
							;;
					sdb_sdc_sdd*)
							check_sdb_sdc_sdd
							do_partclone_restore
							exit
							;;
					*)
							echo "Hard Disk 系统类型出错."
							;;
			esac
	#done
}
main



