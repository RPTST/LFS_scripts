

case $(uname -m) in
i786)
 ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
;;
x86_64) 
 ln -sfv ../lib/ld-linux-x86_64.so.2 $LFS/lib64/ld-lsb-x86_64.so.3
;;
esac

patch -NP1 -i ../glibc-2.32-fhs-1.patch

mkdir -v build
cd build

../libstdc++v3/configure \
 --prefix=/usr \
 --host=$LFS_TGT \
 --build=$(../scripts/config.guest) \
 --enable-kernel=3.2 \
 --with-headers=$LFS/usr/include \
 --libc_cv_slibdir=/lib \
&& make \
&& make DESTDIR=$LFS install

echo 'int main () {}' > dummy.c
$LFS_TGT-gcc dummy.c || exit 1
readelf -l a.out | grep '/ld-linux' || exit 1
rm -v dummy.c a.out 
$LFS/tools/libexec/gcc/$LFS_TGT/$VERSION/install-tools/mkheaders
