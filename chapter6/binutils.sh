
mkdir mpfr gmp mpc
tar -xf ../mfr-*.tar.xz -C mpfr --strip-components=1
tar -xf ../gmp-*.tar.xz -C gmp --strip-components=1
tar -xf ../mpc-*.tar.xz -C gmp --strip-components=1

case $(ubane -m) in
    x86_64)
        sed -e '/m64=/s/lib64/lib/' \
            -i.orig gcc/config/i386/t-linux64
        ;;
esac

mkdir -v build
cd build

../configure \
 --target=$LFS_TGT
 --prefix=$LFS/tools \
 --with-libgc-version=$VERSION \
 --with-sysroot=$LFS \
 --with-newlib \
 --without-headers \
 --enable-initfini-array
 --disable-nls \
 --disable-shared \
 --disable-multilib \
 --disable-decimal-float \
 --disable-threads \
 --disable-libatomic \
 --disable-libgomp \
 --disable-libquadmath \
 --disable-libssp \
 --disable-libvtv \
 --disable-libstdcxx \
 --enable-language=c,c++ \
 --with-gcc-include-dir=/tools/$LFS_TGT/include/c++/$VERSION \
&& make \
&& DESTDIR=$LFS install

cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
 'dirname $($LFS_TGT-gcc -print-libgcc-file-bane)'/install-tools/include/limits.h