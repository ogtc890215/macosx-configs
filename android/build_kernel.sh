#!/bin/bash
# Kernel building-config, please see:
# 'http://source.android.com/source/building-kernels.html#figuring-out-which-kernel-to-build'
DEFAULT_KERNEL_DIR=msm
DEFAULT_KERNEL_CONFIG=sdm660_defconfig

function default_make_config()
{
	KERNEL_DIR=$DEFAULT_KERNEL_DIR
	KERNEL_CONFIG=$DEFAULT_KERNEL_CONFIG
}

function select_kernel_dir()
{
	local variant
	if [ -z "$1" ]; then
		KERNEL_DIR=$DEFAULT_KERNEL_DIR
		return
	else
		variant=$1
	fi

	case $variant in
	"hikey")
		KERNEL_DIR="hikey-linaro"
		;;
	"angler" | "bullhead" | "shamu" | \
	"hammerhead" | "flo" | "deb" | "mako")
		KERNEL_DIR="msm"
		;;
	"fugu")
		KERNEL_DIR="x86_64"
		;;
	"volantis" | "grouper" | "tilapia" | \
	"stingray" | "wingray")
		KERNEL_DIR="tegra"
		;;
	"manta")
		KERNEL_DIR="exynos"
		;;
	"maguro" | "toro" | "panda")
		KERNEL_DIR="omap"
		;;
	"crespo" | "crespo4g")
		KERNEL_DIR="samsung"
		;;
	esac
}

function select_kernel_config()
{
	local variant
	if [ -z "$1" ]; then
		KERNEL_CONFIG=$DEFAULT_KERNEL_CONFIG
		return
	else
		variant=$1
	fi

	case $variant in
	"hikey")
		KERNEL_CONFIG="hikey_defconfig"
		;;
	"angler")
		KERNEL_CONFIG="angler_defconfig"
		;;
	"bullhead")
		KERNEL_CONFIG="bullhead_defconfig"
		;;
	"shamu")
		KERNEL_CONFIG="shamu_defconfig"
		;;
	"fugu")
		KERNEL_CONFIG="fugu_defconfig"
		;;
	"volantis")
		KERNEL_CONFIG="flounder_defconfig"
		;;
	"hammerhead")
		KERNEL_CONFIG="hammerhead_defconfig"
		;;
	"flo" | "deb")
		KERNEL_CONFIG="flo_defconfig"
		;;
	"manta")
		KERNEL_CONFIG="manta_defconfig"
		;;
	"mako")
		KERNEL_CONFIG="mako_defconfig"
		;;
	"grouper" | "tilapia")
		KERNEL_CONFIG="tegra3_android_defconfig"
		;;
	"maguro" | "toro")
		KERNEL_CONFIG="tuna_defconfig"
		;;
	"panda")
		KERNEL_CONFIG="panda_defconfig"
		;;
	"stingray" | "wingray")
		KERNEL_CONFIG="stingray_defconfig"
		;;
	"crespo" | "crespo4g")
		KERNEL_CONFIG="herring_defconfig"
		;;
	esac
}

## main function begin
# for osx, /usr/include lacks some necessary header files.
export C_INCLUDE_PATH=$(pwd)/include

export PATH=$(pwd)/../prebuilts/gcc/darwin-x86/aarch64/aarch64-linux-android-4.9/bin:$PATH
export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-android-

if [ $# -ne 1 ]
then
	default_make_config
else
	select_kernel_dir $1
	select_kernel_config $1
fi

# config test
#echo "$KERNEL_DIR/$KERNEL_CONFIG"
cd $KERNEL_DIR
make $KERNEL_CONFIG
make -j4
## main function end
