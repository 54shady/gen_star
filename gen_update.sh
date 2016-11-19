#!/bin/bash

#set -x

# android top directory
ANDROID_TOP_DIR_3288="/home/zeroway/3288/51/src/3288_5.1_v2"
ANDROID_TOP_DIR_3368="/home/zeroway/3368/src/3368"

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

# pack images
pack_images()
{
	$UPDATES_GEN_DIR/afptool -pack $UPDATES_GEN_DIR/ $UPDATES_GEN_DIR/Image/update.img || pause
	$UPDATES_GEN_DIR/rkImageMaker $PLATFORM $TARGET_BOOTLOADER_IMG $UPDATES_GEN_DIR/Image/update.img update.img -os_type:androidos || pause
}

# make links
make_links()
{
	# clean the Image directory
	rm -rvf $UPDATES_GEN_DIR/Image
	mkdir $UPDATES_GEN_DIR/Image

	# make links files to target
	cd $UPDATES_GEN_DIR/Image/
	for file in ${target_imgs[@]}
	do
		ln -s $file
	done
	cd $UPDATES_GEN_DIR/

	# chose package-file and parameter
	if [ -h $PACKAGE_FILE ]
	then
		rm $PACKAGE_FILE
	fi
	if [ -h $PARAMETER ]
	then
		rm $PARAMETER
	fi
	ln -s $TARGET_PACKAGE_FILE $PACKAGE_FILE
	ln -s $TARGET_PARAMETER_FILE $PARAMETER
}

make_update_3288()
{
	# 3288 target images
	TARGET_KERNEL_IMG="$ANDROID_TOP_DIR_3288/out/target/product/rk3288/obj/KERNEL/kernel.img"
	TARGET_RESOURCE_IMG="$ANDROID_TOP_DIR_3288/out/target/product/rk3288/obj/KERNEL/resource.img"
	TARGET_RECOVERY_IMG="$ANDROID_TOP_DIR_3288/rockdev/Image-rk3288/recovery.img"
	TARGET_SYSTEM_IMG="$ANDROID_TOP_DIR_3288/rockdev/Image-rk3288/system.img"
	TARGET_BOOT_IMG="$ANDROID_TOP_DIR_3288/rockdev/Image-rk3288/boot.img"
	TARGET_MISC_IMG="$ANDROID_TOP_DIR_3288/rockdev/Image-rk3288/misc.img"
	target_imgs=(
		$TARGET_KERNEL_IMG
		$TARGET_RESOURCE_IMG
		$TARGET_RECOVERY_IMG
		$TARGET_SYSTEM_IMG
		$TARGET_BOOT_IMG
		$TARGET_MISC_IMG
	)

	TARGET_PACKAGE_FILE="$UPDATES_GEN_DIR/package-file_3288"
	TARGET_PARAMETER_FILE="$UPDATES_GEN_DIR/parameter_3288"
	TARGET_BOOTLOADER_IMG="$UPDATES_GEN_DIR/RK3288UbootLoader_V2.19.10.bin"

	# make links for the metadata
	make_links

	echo "make 3288 5.1 update.img"
	PLATFORM="-RK32"
	pack_images
}

make_update_3368()
{
	# 3368 target images
	TARGET_KERNEL_IMG="$ANDROID_TOP_DIR_3368/kernel/kernel.img"
	TARGET_RESOURCE_IMG="$ANDROID_TOP_DIR_3368/kernel/resource.img"
	TARGET_RECOVERY_IMG="$ANDROID_TOP_DIR_3368/rockdev/Image-rk3368_32/recovery.img"
	TARGET_SYSTEM_IMG="$ANDROID_TOP_DIR_3368/rockdev/Image-rk3368_32/system.img"
	TARGET_BOOT_IMG="$ANDROID_TOP_DIR_3368/rockdev/Image-rk3368_32/boot.img"
	TARGET_MISC_IMG="$ANDROID_TOP_DIR_3368/rockdev/Image-rk3368_32/misc.img"
	TARGET_TRUST_IMG="$ANDROID_TOP_DIR_3368/u-boot/trust.img"
	TARGET_PACKAGE_FILE="$UPDATES_GEN_DIR/package-file_3368"
	TARGET_PARAMETER_FILE="$UPDATES_GEN_DIR/parameter_3368"
	TARGET_UBOOT_IMG="$ANDROID_TOP_DIR_3368/u-boot/uboot.img"
	TARGET_BOOTLOADER_IMG="$UPDATES_GEN_DIR/RK3368MiniLoaderAll_V2.40.bin"
	target_imgs=(
		$TARGET_KERNEL_IMG
		$TARGET_RESOURCE_IMG
		$TARGET_RECOVERY_IMG
		$TARGET_SYSTEM_IMG
		$TARGET_BOOT_IMG
		$TARGET_MISC_IMG
		$TARGET_TRUST_IMG
		$TARGET_UBOOT_IMG
		$TARGET_BOOTLOADER_IMG
	)

	# make links for the metadata
	make_links

	echo "make 3368 5.1 update.img"
	PLATFORM="-RK330A"
	pack_images
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
