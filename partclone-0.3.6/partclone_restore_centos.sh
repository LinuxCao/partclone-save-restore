#! /bin/bash
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo "                        Welcome to partclone restore centos os                         "
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo

do_partclone_restore_sda()
{
    echo "do_partclone_restore_sda"
    partclone.extfs -r -s /mnt/image_directory/centos_root_partition.img -o /dev/sda2
    partclone.extfs -r -s /mnt/image_directory/centos_boot_partition.img -o /dev/sda1
}


do_partclone_restore_sdb()
{
    echo "do_partclone_restore_sdb"
    partclone.extfs -r -s /mnt/image_directory/centos_root_partition.img -o /dev/sdb2
    partclone.extfs -r -s /mnt/image_directory/centos_boot_partition.img -o /dev/sdb1
}

do_partclone_restore_sdc()
{
    echo "do_partclone_restore_sdc"
    partclone.extfs -r -s /mnt/image_directory/centos_root_partition.img -o /dev/sdc2
    partclone.extfs -r -s /mnt/image_directory/centos_boot_partition.img -o /dev/sdc1
}

do_partclone_restore_sdd()
{
    echo "do_partclone_restore_sdd"
    partclone.extfs -r -s /mnt/image_directory/centos_root_partition.img -o /dev/sdd2
    partclone.extfs -r -s /mnt/image_directory/centos_boot_partition.img -o /dev/sdd1
}






check_restore_partition()
{
    echo "check_restore_parition to restore centos server system when partclone restore"
    fdisk -lu /dev/sdd  > /tmp/sdd_is_restore_partition.info
    fdisk -lu /dev/sdc  > /tmp/sdc_is_restore_partition.info
    fdisk -lu /dev/sdb  > /tmp/sdb_is_restore_partition.info
    fdisk -lu /dev/sda  > /tmp/sda_is_restore_partition.info
    if [[ ! -z $(cat /tmp/sdd_is_restore_partition.info | grep sdd5) ]]
    then
        type=sdd
    elif [[ ! -z $(cat /tmp/sdc_is_restore_partition.info | grep sdc5) ]]
    then
        type=sdc
    elif [[ ! -z $(cat /tmp/sdb_is_restore_partition.info | grep sdb5) ]]
    then
        type=sdb
    elif [[ ! -z $(cat /tmp/sda_is_restore_partition.info | grep sda5) ]]
    then
        type=sda
    fi
}

check_restore_partition
echo "Restore Partition Type ="$type


main()
{

	case $type in
				sda*)
						do_partclone_restore_sda
						exit
						;;
				sdb*)
						do_partclone_restore_sdb
						exit
						;;
				sdc*)
						do_partclone_restore_sdc
						exit
						;;
				sdd*)
						do_partclone_restore_sdd
						exit
						;;
				*)
						echo "Hard Disk 系统类型出错."
						;;
	esac

}
main

