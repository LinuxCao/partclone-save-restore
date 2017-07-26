#! /bin/bash
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo "                        Welcome to partclone restore centos os      "
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo
#Set the default value
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

#Device     Boot      Start        End    Sectors  Size Id Type
#/dev/sda1  *          2048    1026047    1024000  500M 83 Linux
#/dev/sda2          1026048 1846519807 1845493760  880G 83 Linux
#/dev/sda3       1846519808 1888462847   41943040   20G 82 Linux swap / Solaris
#/dev/sda4       1888462848 1953523711   65060864   31G  5 Extended
#/dev/sda5       1888466944 1889490943    1024000  500M 83 Linux
#/dev/sda6       1889492992 1946150911   56657920   27G 83 Linux
#/dev/sda7       1946152960 1953523711    7370752  3.5G 82 Linux swap / Solaris

SDA1_START=2048
SDA1_END=1026047
SDA2_START=1026048
SDA2_END=1846519807
SDA3_START=1846519808
SDA3_END=1888462847
SDA4_START=1888462848
SDA4_END=1953523711
SDA5_START=1888466944
SDA5_END=1889490943
SDA6_START=1889492992
SDA6_END=1946150911
SDA7_START=1946152960
SDA7_END=1953523711

sata_standard_disk_size=900.2
ssd_standard_disk_size=350.2
restore_image_directory="/run/initramfs/live/mnt/image_directory"
#restore_image_directory=" /run/media/liveuser/OSEASY/mnt/image_directory"
centos_root_partition_restore_image_directory="/run/initramfs"
#centos_root_partition_restore_image_directory="/run/media/liveuser/OSEASY/mnt/image_directory"

type="success"

ls /sys/block > /tmp/disk.info

#Print defaults
echo "sata_standard_disk_size ="$sata_standard_disk_size
echo "ssd_standard_disk_size ="$ssd_standard_disk_size
echo "restore_image_directory ="$restore_image_directory
echo "centos_root_partition_restore_image_directory ="$centos_root_partition_restore_image_directory

confirm_sda()
{
echo "confirm_sda"
# Confirm sda  1T SATA
for disk_name in `cat /tmp/disk.info`
do
	echo "disk_name == "$disk_name
	disk_size=`fdisk -l /dev/$disk_name | grep -m1 ^Disk | awk '{print $3}'`
	disk_unit=`fdisk -lu /dev/$disk_name | grep -m1 ^Disk | awk '{print $4}' | tr -d ","`
	disk_type=`cat /sys/block/$disk_name/queue/rotational`	
	echo "disk_size == "$disk_size" "$disk_unit "disk_type =="$disk_type
	if [ `echo "$disk_size < $sata_standard_disk_size" | bc ` -eq 1 ]
	then 
		echo "$disk_name disk_size $disk_size is smaller than $sata_standard_disk_size GiB sata_standard_disk_size"
	else 
		if [ $disk_unit = "GiB" ]
		then
			echo "$disk_name disk_size $disk_size is greater than $sata_standard_disk_size GiB sata_standard_disk_size"
			if [ $disk_type = "1" ]
			then
				echo "$disk_name is sata disk type"
				SDA=$disk_name
				SDA1=$disk_name"1"
                SDA2=$disk_name"2"
				SDA3=$disk_name"3"
				SDA4=$disk_name"4"
				SDA5=$disk_name"5"
				SDA6=$disk_name"6"
				SDA7=$disk_name"7"
			else
				echo "disk_name is ssd disk type"
			fi
		else
			echo "$disk_name disk_size $disk_size is smaller than $sata_standard_disk_size GiB sata_standard_disk_size"
		fi
	fi
done
echo "SDA ="$SDA
echo "SDA1 ="$SDA1
echo "SDA2 ="$SDA2
echo "SDA3 ="$SDA3
echo "SDA4 ="$SDA4
echo "SDA5 ="$SDA5
echo "SDA6 ="$SDA6
echo "SDA7 ="$SDA7
}


confirm_sdb()
{
echo "confirm_sdb"
# Confirm sdb 1T SATA /opt/sata Partition
for disk_name in `cat /tmp/disk.info`
do
        echo "disk_name == "$disk_name
        disk_size=`fdisk -l /dev/$disk_name | grep -m1 ^Disk | awk '{print $3}'`
        disk_unit=`fdisk -lu /dev/$disk_name | grep -m1 ^Disk | awk '{print $4}' | tr -d ","`
        disk_type=`cat /sys/block/$disk_name/queue/rotational`
        echo "disk_size == "$disk_size" "$disk_unit "disk_type =="$disk_type
        if [ `echo "$disk_size < $sata_standard_disk_size" | bc ` -eq 1 ]
        then
                echo "$disk_name disk_size $disk_size is smaller than $sata_standard_disk_size GiB sata_standard_disk_size"
        else
                if [ $disk_unit = "GiB" ]
                then
                        echo "$disk_name disk_size $disk_size is greater than $sata_standard_disk_size GiB sata_standard_disk_size"
                        if [ $disk_type = "1" -a $disk_name != $SDA ]
                        then
                                echo "$disk_name is sata disk type"
                                SDB=$disk_name
                                SDB1=$disk_name"1"
                        
                        else
                                echo "disk_name is ssd disk type"
                        fi
                else
                        echo "$disk_name disk_size $disk_size is smaller than $sata_standard_disk_size GiB sata_standard_disk_size"
                fi
        fi
done
echo "SDB ="$SDB
echo "SDB1 ="$SDB1
}


confirm_sdc()
{
echo "confirm_sdc"
# Confirm sdc or nvme0n1 400G SSD /opt/ssd Partition
for disk_name in `cat /tmp/disk.info`
do
        echo "disk_name == "$disk_name
        disk_size=`fdisk -l /dev/$disk_name | grep -m1 ^Disk | awk '{print $3}'`
        disk_unit=`fdisk -lu /dev/$disk_name | grep -m1 ^Disk | awk '{print $4}' | tr -d ","`
        disk_type=`cat /sys/block/$disk_name/queue/rotational`
        echo "disk_size == "$disk_size" "$disk_unit "disk_type =="$disk_type
        if [ `echo "$disk_size < $ssd_standard_disk_size" | bc ` -eq 1 ]
		then
                echo "$disk_name disk_size $disk_size is smaller than $ssd_standard_disk_size GiB ssd_standard_disk_size"
        else
                if [ $disk_unit = "GiB"  -a $disk_type = "0" ]
                then
                        if [[ $disk_name =~  "sd" ]]
						then	
							echo "$disk_name disk_size $disk_size is greater than $ssd_standard_disk_size GiB ssd_standard_disk_size"
							echo "$disk_name is ssd disk type with sdX type"
							SDC=$disk_name
							SDC1=$disk_name"1"

						elif [[ $disk_name =~ "nvme" ]] 
						then
							echo "$disk_name disk_size $disk_size is greater than $ssd_standard_disk_size GiB ssd_standard_disk_size"
							echo "$disk_name is ssd disk type with nvme0n1 type"
							SDC=$disk_name
							SDC1=$disk_name"p1"
						else
							echo "this  ssd disk is wrong"
						fi
                        
                else
                        echo "this is not ssd disk"
                fi
        fi
done
echo "SDC ="$SDC
echo "SDC1 ="$SDC1
}

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
echo "gunzip the centos_root_partition.img.gz to centos_root_partition.img.......Please wait a while for 5 minutes..."
gunzip -c $restore_image_directory/centos_root_partition.img.gz > $centos_root_partition_restore_image_directory/centos_root_partition.img
partclone.extfs -r -d -s $centos_root_partition_restore_image_directory/centos_root_partition.img -o /dev/$SDA2

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
					success*)
							confirm_sda
							confirm_sdb
							confirm_sdc
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



