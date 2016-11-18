#!/bin/bash

#set -x
# update.img out dir
UPDATES_GEN_DIR="/home/zeroway/updates"

# meta image for update.img
KERNEL_IMG="$UPDATES_GEN_DIR/Image/kernel.img"
RESOURCE_IMG="$UPDATES_GEN_DIR/Image/resource.img"
RECOVERY_IMG="$UPDATES_GEN_DIR/Image/recovery.img"
SYSTEM_IMG="$UPDATES_GEN_DIR/Image/system.img"
BOOT_IMG="$UPDATES_GEN_DIR/Image/boot.img"
PACKAGE_FILE="$UPDATES_GEN_DIR/package-file"
PARAMETER="$UPDATES_GEN_DIR/parameter"
UBOOT_IMG="$UPDATES_GEN_DIR/Image/uboot.img"
MISC_IMG="$UPDATES_GEN_DIR/Image/misc.img"
TRUCT_IMG="$UPDATES_GEN_DIR/Image/trust.img"

make_update_3288()
{
	# 3288 target images
	TARGET_KERNEL_IMG="/home/zeroway/3288/51/src/3288_5.1_v2/out/target/product/rk3288/obj/KERNEL/kernel.img"
	TARGET_RESOURCE_IMG="/home/zeroway/3288/51/src/3288_5.1_v2/out/target/product/rk3288/obj/KERNEL/resource.img"
	TARGET_RECOVERY_IMG="/home/zeroway/3288/51/src/3288_5.1_v2/rockdev/Image-rk3288/recovery.img"
	TARGET_SYSTEM_IMG="/home/zeroway/3288/51/src/3288_5.1_v2/rockdev/Image-rk3288/system.img"
	TARGET_BOOT_IMG="/home/zeroway/3288/51/src/3288_5.1_v2/rockdev/Image-rk3288/boot.img"
	TARGET_MISC_IMG="/home/zeroway/3288/51/src/3288_5.1_v2/rockdev/Image-rk3288/misc.img"
	TARGET_PACKAGE_FILE="$UPDATES_GEN_DIR/package-file_3288"
	TARGET_PARAMETER_FILE="$UPDATES_GEN_DIR/parameter_3288"

	make_links_files=(
		$KERNEL_IMG
		$RESOURCE_IMG
		$RECOVERY_IMG
		$SYSTEM_IMG
		$BOOT_IMG
		$PACKAGE_FILE
		$PARAMETER
		$MISC_IMG
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
	ln -s $TARGET_PACKAGE_FILE $PACKAGE_FILE
	ln -s $TARGET_PARAMETER_FILE $PARAMETER
	ln -s $TARGET_MISC_IMG $MISC_IMG

	echo "make 3288 5.1 update.img"
	$UPDATES_GEN_DIR/afptool -pack $UPDATES_GEN_DIR/ $UPDATES_GEN_DIR/Image/update.img || pause
	$UPDATES_GEN_DIR/rkImageMaker -RK32 RK3288UbootLoader_V2.19.10.bin $UPDATES_GEN_DIR/Image/update.img update.img -os_type:androidos || pause
}

make_update_3368()
{
	# 3368 target images
	TARGET_KERNEL_IMG="/home/zeroway/3368/src/3368/kernel/kernel.img"
	TARGET_RESOURCE_IMG="/home/zeroway/3368/src/3368/kernel/resource.img"
	TARGET_RECOVERY_IMG="/home/zeroway/3368/src/3368/rockdev/Image-rk3368_32/recovery.img"
	TARGET_SYSTEM_IMG="/home/zeroway/3368/src/3368/rockdev/Image-rk3368_32/system.img"
	TARGET_BOOT_IMG="/home/zeroway/3368/src/3368/rockdev/Image-rk3368_32/boot.img"
	TARGET_MISC_IMG="/home/zeroway/3368/src/3368/rockdev/Image-rk3368_32/misc.img"
	TARGET_TRUST_IMG="/home/zeroway/3368/src/3368/u-boot/trust.img"
	TARGET_PACKAGE_FILE="$UPDATES_GEN_DIR/package-file_3368"
	TARGET_PARAMETER_FILE="$UPDATES_GEN_DIR/parameter_3368"
	TARGET_UBOOT_IMG="/home/zeroway/3368/src/3368/u-boot/uboot.img"

	make_links_files=(
		$KERNEL_IMG
		$RESOURCE_IMG
		$RECOVERY_IMG
		$SYSTEM_IMG
		$BOOT_IMG
		$PACKAGE_FILE
		$PARAMETER
		$UBOOT_IMG
		$MISC_IMG
		$TRUCT_IMG
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
	ln -s $TARGET_PACKAGE_FILE $PACKAGE_FILE
	ln -s $TARGET_PARAMETER_FILE $PARAMETER
	ln -s $TARGET_UBOOT_IMG $UBOOT_IMG
	ln -s $TARGET_MISC_IMG $MISC_IMG
	ln -s $TARGET_TRUST_IMG $TRUCT_IMG

	echo "make 3368 5.1 update.img"
	$UPDATES_GEN_DIR/afptool -pack $UPDATES_GEN_DIR/ $UPDATES_GEN_DIR/Image/update.img || pause
	$UPDATES_GEN_DIR/rkImageMaker -RK330A RK3368MiniLoaderAll_V2.40.bin $UPDATES_GEN_DIR/Image/update.img update.img -os_type:androidos || pause
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
