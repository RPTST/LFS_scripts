#!/bin/bash


export LFS=/mnt/lfs
export LFS_TGT=x86_64-lfs-linux-gnu
export LFS_DISK=/dev/sdb


if ! grep -q "$LFS" /proc/mounts; then
    source setupsisk.sh "$LFS_DISK"
    sudo mount "$(LFS_DISK)2" "$LFS"
    sudo chown -v $USER "$LFS"
fi

mkdir -pv $LFS/sources
mkdir -pv $LFS/tools

mkdir -pv $LFS/boot
mkdir -pv $LFS/etc
mkdir -pv $LFS/bin
mkdir -pv $LFS/lib
mkdir -pv $LFS/sbin
mkdir -pv $LFS/usr
mkdir -pv $LFS/var


case $(uname -m) in
    x86_64) mkdir -pv $LFS/lib64 ;;
esac


cp -rf *.sh chapter* packages.csv "$LFS/sources"
cd "$LFS/sources"
export PATH=$LFS/tools/bin:$PATH


source download.sh


# Chapter 5
for package in binutils gcc linux-api-headers glibc libstdc++; do
    source packageinstall.sh 5 $package
done

# Chapter 6
for package in bash binutils coreutils diffutils find findutils gawk gcc grep gzip m4 make ncurses patch sed tar xz; do
    source packageinstall.sh 6 $package
done