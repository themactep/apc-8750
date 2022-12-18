#!/bin/bash
#
# Paul Philippov <paul@themactep.com>
# 2022-12-18
#

# path to toolchain directory
TOOLCHAIN=/opt/toolchains/apc-io/apc-rock-toolchain

# cross-compilation tools prefix
CROSS_COMPILE=arm-none-linux-gnueabi-

# target architecture
ARCH=arm

# clone official toolchain if no toolchain found
if [ ! -d "$TOOLCHAIN" ]; then
    mkdir -p $(dirname $TOOLCHAIN)
    git clone https://github.com/apc-io/apc-rock-toolchain.git $TOOLCHAIN
fi

PATH=$TOOLCHAIN/bin:$PATH

export ARCH
export PATH
export CROSS_COMPILE

case "$1" in
uboot)
    cd u-boot
    make clean
    make wmt_config
    make all
    cd ..
    ;;
kernel)
    cd kernel
    make clean
    make Android_defconfig
    make ubin
    cd ..
    ;;
*)
    echo "Usage: $0 [uboot|kernel]"
    exit 1
esac
