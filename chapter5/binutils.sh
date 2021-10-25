mkdir -v build
cd build

.//configure --prefix=$LFS/tools \
 --with-sysroot=$LFS \
 --target=$LFS_TGT \
 --disble-nls \
 --disable-werror \
&& make \
&& make install