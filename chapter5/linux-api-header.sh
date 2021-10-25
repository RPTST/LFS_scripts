
make mrproper

make headers
find usr/include -name '.*' -delete
rm usr/include/Makefile
cd -rv usr/include $LFS/usr

mkdir -v build
cd build

../libstdc++v3/configure \
 --host=$LFS_TGT \
 --build=$(../config.guest) \
 --prefix=/usr \
 --disable-multilib \
 --disable-nls \
 --disable-libstdcxx-pch \
 --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/10.2.0
# && make \
# && make install