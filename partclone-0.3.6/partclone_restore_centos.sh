#! /bin/bash
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo "                        Welcome to partclone restore centos os      "
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo

restore_image_directory="/mnt/image_directory"


check_restore_partition()
{
    echo "check_restore_partition to restore centos server system  when partclone restore"
    fdisk -lu /dev/sdd  > /tmp/sdd_is_restore_partition.info
    fdisk -lu /dev/sdc  > /tmp/sdc_is_restore_partition.info
    fdisk -lu /dev/sdb  > /tmp/sdb_is_restore_partition.info
    fdisk -lu /dev/sda  > /tmp/sda_is_restore_partition.info
    if [[ ! -z $(cat /tmp/sdd_is_restore_partition.info | grep sdd7) ]]
    then
        type=sdd
    elif [[ ! -z $(cat /tmp/sdc_is_restore_partition.info | grep sdc7) ]]
    then
        type=sdc
    elif [[ ! -z $(cat /tmp/sdb_is_restore_partition.info | grep sdb7) ]]
    then
        type=sdb
    elif [[ ! -z $(cat /tmp/sda_is_restore_partition.info | grep sda7) ]]
    then
        type=sda
    fi
}

check_restore_partition
echo "Restore Partition Hard  Disk Type ="$type
echo "restore_image_directory ="$restore_image_directory

do_partclone_restore_sda()
{
	echo "do_partclone_restore_sda"
	# partclone restore centos_boot_partition.img
	partclone.extfs -r -d -s $restore_image_directory/centos_boot_partition.img -o /dev/sda1
	# partclone restore centos_root_partition.img
	partclone.extfs -r -d -s $restore_image_directory/centos_root_partition.img -o /dev/sda2

}

do_partclone_restore_sdb()
{
	echo "do_partclone_restore_sdb"
	# partclone restore centos_boot_partition.img
	partclone.extfs -r -d -s $restore_image_directory/centos_boot_partition.img -o /dev/sdb1
	# partclone restore centos_root_partition.img
	partclone.extfs -r -d -s $restore_image_directory/centos_root_partition.img -o /dev/sdb2
	
}

do_partclone_restore_sdc()
{
	echo "do_partclone_restore_sdc"
	# partclone restore centos_boot_partition.img
	partclone.extfs -r -d -s $restore_image_directory/centos_boot_partition.img -o /dev/sdc1
	# partclone restore centos_root_partition.img
	partclone.extfs -r -d -s $restore_image_directory/centos_root_partition.img -o /dev/sdc2
	
	
}

do_partclone_restore_sdd()
{
	echo "do_partclone_restore_sdd"
	# partclone restore centos_boot_partition.img
	partclone.extfs -r -d -s $restore_image_directory/centos_boot_partition.img -o /dev/sdd1
	# partclone restore centos_root_partition.img
	partclone.extfs -r -d -s $restore_image_directory/centos_root_partition.img -o /dev/sdd2
	
}


main()
{

	case $type in
				sdd*)
						do_partclone_restore_sdd
						exit
						;;
				sdc*)
						do_partclone_restore_sdc
						exit
						;;
				sdb*)
						do_partclone_restore_sdb
						exit
						;;
				sda*)
						do_partclone_restore_sda
						exit
						;;
				*)
						echo "Hard Disk 系统类型出错."
						;;
	esac

}
main





