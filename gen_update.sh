#!/bin/bash

# update.img out dir
UPDATES_GEN_DIR="/home/zeroway/updates"

# meta image for update.img
KERNEL_IMG="$UPDATES_GEN_DIR/Image/kernel.img"
RESOURCE_IMG="$UPDATES_GEN_DIR/Image/resource.img"
RECOVERY_IMG="$UPDATES_GEN_DIR/Image/recovery.img"
SYSTEM_IMG="$UPDATES_GEN_DIR/Image/system.img"
BOOT_IMG="$UPDATES_GEN_DIR/Image/boot.img"

make_update_3288()
{
	# 3288 target images
	TARGET_KERNEL_IMG="/home/zeroway/3288/51/src/3288_5.1_v2/out/target/product/rk3288/obj/KERNEL/kernel.img"
	TARGET_RESOURCE_IMG="/home/zeroway/3288/51/src/3288_5.1_v2/out/target/product/rk3288/obj/KERNEL/resource.img"
	TARGET_RECOVERY_IMG="/home/zeroway/3288/51/src/3288_5.1_v2/rockdev/Image-rk3288/recovery.img"
	TARGET_SYSTEM_IMG="/home/zeroway/3288/51/src/3288_5.1_v2/rockdev/Image-rk3288/system.img"
	TARGET_BOOT_IMG="/home/zeroway/3288/51/src/3288_5.1_v2/rockdev/Image-rk3288/boot.img"

	make_links_files=(
		$KERNEL_IMG
		$RESOURCE_IMG
		$RECOVERY_IMG
		$SYSTEM_IMG
		$BOOT_IMG
	)

	# if exist links, delete it
	for file in ${make_links_files[@]}
	do
		if [ -h $file ]
		then
			rm -rvf $file
		fi
	done

	# make links files to target
	ln -s $TARGET_KERNEL_IMG   $KERNEL_IMG
	ln -s $TARGET_RESOURCE_IMG $RESOURCE_IMG
	ln -s $TARGET_RECOVERY_IMG $RECOVERY_IMG
	ln -s $TARGET_SYSTEM_IMG   $SYSTEM_IMG
	ln -s $TARGET_BOOT_IMG   $BOOT_IMG

	echo "make 3288 5.1 update.img"
	$UPDATES_GEN_DIR/afptool -pack $UPDATES_GEN_DIR/ $UPDATES_GEN_DIR/Image/update.img || pause
	$UPDATES_GEN_DIR/rkImageMaker -RK32 RK3288UbootLoader_V2.19.10.bin $UPDATES_GEN_DIR/Image/update.img update.img -os_type:androidos || pause
}

make_update_3368()
{
	echo "make 3368 5.1 update.img"
}

print_usage()
{
	echo "Usage: genupdate <soc_name>"
	echo "genupdate 3288"
	echo "genupdate 3368"
}

if [ "$1" = "3288" ]
then
	# make 3288 5.1 update.img
	make_update_3288
elif [ "$1" = "3368" ]
then
	# make 3368 5.1 update.img
	make_update_3368
else
	# unknow update.img
	print_usage
fi
