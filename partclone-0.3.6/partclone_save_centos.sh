#! /bin/bash
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo "                        Welcome to partclone save centos os                         "
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo


save_image_directory="/run/media/liveuser/OSEASY/mnt/image_directory"


check_save_partition()
{
    echo "check_save_partition to save centos server system when partclone save"
    fdisk -lu /dev/sdd  > /tmp/sdd_is_save_partition.info
    fdisk -lu /dev/sdc  > /tmp/sdc_is_save_partition.info
    fdisk -lu /dev/sdb  > /tmp/sdb_is_save_partition.info
    fdisk -lu /dev/sda  > /tmp/sda_is_save_partition.info
    if [[ ! -z $(cat /tmp/sdd_is_save_partition.info | grep sdd3) ]]
    then
        type=sdd
    elif [[ ! -z $(cat /tmp/sdc_is_save_partition.info | grep sdc3) ]]
    then
        type=sdc
    elif [[ ! -z $(cat /tmp/sdb_is_save_partition.info | grep sdb3) ]]
    then
        type=sdb
    elif [[ ! -z $(cat /tmp/sda_is_save_partition.info | grep sda3) ]]
    then
        type=sda
    fi
}

check_save_partition
echo "Save Partition Hard  Disk Type ="$type
echo "save_image_directory ="$save_image_directory

do_partclone_save_sda()
{
	echo "do_partclone_save_sda"
	mkdir -p $save_image_directory
	
	# partclone save centos_boot_partition.img
	rm -fr $save_image_directory/centos_boot_partition.img
	fsck /dev/sda1
	partclone.extfs -c -d -s /dev/sda1 -o $save_image_directory/centos_boot_partition.img


	# partclone save centos_root_partition.img
	rm -fr $save_image_directory/centos_root_partition.img
	fsck /dev/sda2
	partclone.extfs -c -d -s /dev/sda2 -o $save_image_directory/centos_root_partition.img
	# gzip centos_root_partition.img
	echo "gzip the centos_root_partition.img to centos_root_partition.img.gz.......Please wait a while for 5 minutes..."
	gzip -c -1 $save_image_directory/centos_root_partition.img > $save_image_directory/centos_root_partition.img.gz
	
}

do_partclone_save_sdb()
{
	echo "do_partclone_save_sdb"
	mkdir -p $save_image_directory
	
	# partclone save centos_boot_partition.img
	rm -fr $save_image_directory/centos_boot_partition.img
	fsck /dev/sdb1
	partclone.extfs -c -d -s /dev/sdb1 -o $save_image_directory/centos_boot_partition.img


	# partclone save centos_root_partition.img
	rm -fr $save_image_directory/centos_root_partition.img
	fsck /dev/sdb2
	partclone.extfs -c -d -s /dev/sdb2 -o $save_image_directory/centos_root_partition.img
	# gzip centos_root_partition.img
	echo "gzip the centos_root_partition.img to centos_root_partition.img.gz.......Please wait a while for 5 minutes..."
	gzip -c -1 $save_image_directory/centos_root_partition.img > $save_image_directory/centos_root_partition.img.gz
	
}

do_partclone_save_sdc()
{
	echo "do_partclone_save_sdc"
	mkdir -p $save_image_directory
	
	# partclone save centos_boot_partition.img
	rm -fr $save_image_directory/centos_boot_partition.img
	fsck /dev/sdc1
	partclone.extfs -c -d -s /dev/sdc1 -o $save_image_directory/centos_boot_partition.img


	# partclone save centos_root_partition.img
	rm -fr $save_image_directory/centos_root_partition.img
	fsck /dev/sdc2
	partclone.extfs -c -d -s /dev/sdc2 -o $save_image_directory/centos_root_partition.img
	# gzip centos_root_partition.img
	echo "gzip the centos_root_partition.img to centos_root_partition.img.gz.......Please wait a while for 5 minutes..."
	gzip -c -1 $save_image_directory/centos_root_partition.img > $save_image_directory/centos_root_partition.img.gz
	
}

do_partclone_save_sdd()
{
	echo "do_partclone_save_sdd"
	mkdir -p $save_image_directory
	
	# partclone save centos_boot_partition.img
	rm -fr $save_image_directory/centos_boot_partition.img
	fsck /dev/sdd1
	partclone.extfs -c -d -s /dev/sdd1 -o $save_image_directory/centos_boot_partition.img


	# partclone save centos_root_partition.img
	rm -fr $save_image_directory/centos_root_partition.img
	fsck /dev/sdd2
	partclone.extfs -c -d -s /dev/sdd2 -o $save_image_directory/centos_root_partition.img
	# gzip centos_root_partition.img
	echo "gzip the centos_root_partition.img to centos_root_partition.img.gz.......Please wait a while for 5 minutes..."
	gzip -c -1 $save_image_directory/centos_root_partition.img > $save_image_directory/centos_root_partition.img.gz
	
}


main()
{

	case $type in
				sdd*)
						do_partclone_save_sdd
						exit
						;;
				sdc*)
						do_partclone_save_sdc
						exit
						;;
				sdb*)
						do_partclone_save_sdb
						exit
						;;
				sda*)
						do_partclone_save_sda
						exit
						;;
				*)
						echo "Hard Disk 系统类型出错."
						;;
	esac

}
main

