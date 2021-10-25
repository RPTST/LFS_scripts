mkdir -v build
cd build

../libstdc++-v3/configure \
 --host=$LFS_TGT \
 --build=$(../config.guest) \
 --prefix=/usr \
 --disable-multilib \
 --disable-nls \
 --disable-libstdcxx-pch \
 --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/$VERSION \
&& make \
&& DESTDIR=$LFS install