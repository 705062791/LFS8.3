#!/bin/bash

cd $LFS/sources &&
tar xvf binutils-2.31.1.tar.xz &&
cd binutils-2.31.1 &&
mkdir -v build &&
cd       build &&
../configure --prefix=/tools            \
             --with-sysroot=$LFS        \
             --with-lib-path=/tools/lib \
             --target=$LFS_TGT          \
             --disable-nls              \
             --disable-werror &&
make &&
case $(uname -m) in
  x86_64) mkdir -v /tools/lib && ln -sv lib /tools/lib64 ;;
esac &&

make install &&
cd $LFS/sources &&
rm -rf bibutils-2.31.1 &&
echo "sucessful install bibutils-2.31.1" &&
echo "---------------------------------" &&


cd $LFS/sources &&
tar xvf gcc-8.2.0.tar.xz &&
cd gcc-8.2.0 &&
tar -xf ../mpfr-4.0.1.tar.xz &&
mv -v mpfr-4.0.1 mpfr &&
tar -xf ../gmp-6.1.2.tar.xz &&
mv -v gmp-6.1.2 gmp &&
tar -xf ../mpc-1.1.0.tar.gz &&
mv -v mpc-1.1.0 mpc &&
for file in gcc/config/{linux,i386/linux{,64}}.h
do
  cp -uv $file{,.orig}
  sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
      -e 's@/usr@/tools@g' $file.orig > $file
  echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
  touch $file.orig
done &&
case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
 ;;
esac &&
mkdir -v build &&
cd       build &&
../configure                                       \
    --target=$LFS_TGT                              \
    --prefix=/tools                                \
    --with-glibc-version=2.11                      \
    --with-sysroot=$LFS                            \
    --with-newlib                                  \
    --without-headers                              \
    --with-local-prefix=/tools                     \
    --with-native-system-header-dir=/tools/include \
    --disable-nls                                  \
    --disable-shared                               \
    --disable-multilib                             \
    --disable-decimal-float                        \
    --disable-threads                              \
    --disable-libatomic                            \
    --disable-libgomp                              \
    --disable-libmpx                               \
    --disable-libquadmath                          \
    --disable-libssp                               \
    --disable-libvtv                               \
    --disable-libstdcxx                            \
    --enable-languages=c,c++ &&
make &&
make install &&
cd $LFS/sources &&
rm -rf gcc-8.2.0 &&
echo "sucessful install gcc-8.2.0" &&
echo "---------------------------------" &&

cd $LFS/sources &&
tar xvf linux-4.18.5.tar.xz &&
cd linux-4.18.5 &&
make mrproper &&
make INSTALL_HDR_PATH=dest headers_install &&
cp -rv dest/include/* /tools/include
cd $LFS/sources &&
rm -rf linux-4.18.5 &&
echo "sucessful install linux-4.18.5" &&
echo "---------------------------------" &&

cd $LFS/sources &&
tar xvf glibc-2.28.tar.xz &&
cd glibc-2.28 &&
mkdir -v build &&
cd       build &&
../configure                             \
      --prefix=/tools                    \
      --host=$LFS_TGT                    \
      --build=$(../scripts/config.guess) \
      --enable-kernel=3.2             \
      --with-headers=/tools/include      \
      libc_cv_forced_unwind=yes          \
      libc_cv_c_cleanup=yes &&
make &&
make install &&
cd $LFS/sources &&
rm -rf glibc-2.28 &&
echo "sucessful install glibc-2.28" &&
echo "---------------------------------" &&

cd $LFS/sources &&
tar xvf binutils-2.31.1.tar.xz &&
cd binutils-2.31.1 &&
mkdir -v build &&
cd       build &&
CC=$LFS_TGT-gcc                \
AR=$LFS_TGT-ar                 \
RANLIB=$LFS_TGT-ranlib         \
../configure                   \
    --prefix=/tools            \
    --disable-nls              \
    --disable-werror           \
    --with-lib-path=/tools/lib \
    --with-sysroot &&
make &&
make install &&
make -C ld clean &&
make -C ld LIB_PATH=/usr/lib:/lib &&
cp -v ld/ld-new /tools/bin &&
cd $LFS/sources &&
rm -rf binutils-2.31.1 &&
echo "sucessful install binutils-2.31.1" &&
echo "---------------------------------" &&


cd $LFS/sources  &&
tar xvf gcc-8.2.0.tar.xz &&
cd gcc-8.2.0 &&
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include-fixed/limits.h &&
for file in gcc/config/{linux,i386/linux{,64}}.h
do
  cp -uv $file{,.orig}
  sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
      -e 's@/usr@/tools@g' $file.orig > $file
  echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
  touch $file.orig
done &&
case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
  ;;
esac &&
tar -xf ../mpfr-4.0.1.tar.xz &&
mv -v mpfr-4.0.1 mpfr &&
tar -xf ../gmp-6.1.2.tar.xz &&
mv -v gmp-6.1.2 gmp &&
tar -xf ../mpc-1.1.0.tar.gz &&
mv -v mpc-1.1.0 mpc &&
mkdir -v build &&
cd       build &&
CC=$LFS_TGT-gcc                                    \
CXX=$LFS_TGT-g++                                   \
AR=$LFS_TGT-ar                                     \
RANLIB=$LFS_TGT-ranlib                             \
../configure                                       \
    --prefix=/tools                                \
    --with-local-prefix=/tools                     \
    --with-native-system-header-dir=/tools/include \
    --enable-languages=c,c++                       \
    --disable-libstdcxx-pch                        \
    --disable-multilib                             \
    --disable-bootstrap                            \
    --disable-libgomp &&
make &&
make install &&
ln -sv gcc /tools/bin/cc &&


cd $LFS/sources &&
tar xvf gcc-8.2.0.tar.xz &&
cd gcc-8.2.0 &&
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include-fixed/limits.h &&
for file in gcc/config/{linux,i386/linux{,64}}.h
do
  cp -uv $file{,.orig}
  sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
      -e 's@/usr@/tools@g' $file.orig > $file
  echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
  touch $file.orig
done &&
case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
  ;;
esac &&
tar -xf ../mpfr-4.0.1.tar.xz &&
mv -v mpfr-4.0.1 mpfr &&
tar -xf ../gmp-6.1.2.tar.xz &&
mv -v gmp-6.1.2 gmp &&
tar -xf ../mpc-1.1.0.tar.gz &&
mv -v mpc-1.1.0 mpc &&
mkdir -v build &&
cd       build &&
CC=$LFS_TGT-gcc                                    \
CXX=$LFS_TGT-g++                                   \
AR=$LFS_TGT-ar                                     \
RANLIB=$LFS_TGT-ranlib                             \
../configure                                       \
    --prefix=/tools                                \
    --with-local-prefix=/tools                     \
    --with-native-system-header-dir=/tools/include \
    --enable-languages=c,c++                       \
    --disable-libstdcxx-pch                        \
    --disable-multilib                             \
    --disable-bootstrap                            \
    --disable-libgomp &&
make &&
make install &&
ln -sv gcc /tools/bin/cc &&
cd $LFS/sources &&
rm -rf gcc-8.2.0 &&
echo "sucessful install gcc-8.2.0" &&
echo "---------------------------------" &&




















# 5.5.[GCC-8.2.0 - Pass 1](../Guide/tmp-system/002-gcc-pass1.md)———14.3 SBU
cd $LFS/sources &&
tar xvf gcc-8.2.0.tar.xz &&
cd gcc-8.2.0 &&
tar -xf ../mpfr-4.0.1.tar.xz &&
mv -v mpfr-4.0.1 mpfr &&
tar -xf ../gmp-6.1.2.tar.xz &&
mv -v gmp-6.1.2 gmp &&
tar -xf ../mpc-1.1.0.tar.gz &&
mv -v mpc-1.1.0 mpc &&
for file in gcc/config/{linux,i386/linux{,64}}.h
do
  cp -uv $file{,.orig}
  sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
      -e 's@/usr@/tools@g' $file.orig > $file
  echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
  touch $file.orig
done &&
case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
 ;;
esac &&
mkdir -v build &&
cd       build &&
../configure                                       \
    --target=$LFS_TGT                              \
    --prefix=/tools                                \
    --with-glibc-version=2.11                      \
    --with-sysroot=$LFS                            \
    --with-newlib                                  \
    --without-headers                              \
    --with-local-prefix=/tools                     \
    --with-native-system-header-dir=/tools/include \
    --disable-nls                                  \
    --disable-shared                               \
    --disable-multilib                             \
    --disable-decimal-float                        \
    --disable-threads                              \
    --disable-libatomic                            \
    --disable-libgomp                              \
    --disable-libmpx                               \
    --disable-libquadmath                          \
    --disable-libssp                               \
    --disable-libvtv                               \
    --disable-libstdcxx                            \
    --enable-languages=c,c++ &&
make &&
make install &&
cd $LFS/sources &&
rm -rf gcc-8.2.0
echo "---------------------------"


# 5.6.[Linux-4.18.5 API Headers](../Guide/tmp-system/003-linux-header.md)———0.1 SBU(可以和1,2一起运行)
cd $LFS/sources
tar xvf linux-4.18.5.tar.xz &&
cd linux-4.18.5 &&
make mrproper &&
make INSTALL_HDR_PATH=dest headers_install &&
cp -rv dest/include/* /tools/include
cd $LFS/sources &&
rm -rf linux-4.18.5
echo "---------------------------" &&

# 5.7.[Glibc-2.28](../Guide/tmp-system/004-glibc.md)———4.7 SBU(必须按照顺序来安装)
cd $LFS/sources &&
tar xvf glibc-2.28.tar.xz &&
cd glibc-2.28 &&
mkdir -v build &&
cd       build &&
../configure                             \
      --prefix=/tools                    \
      --host=$LFS_TGT                    \
      --build=$(../scripts/config.guess) \
      --enable-kernel=3.2             \
      --with-headers=/tools/include      \
      libc_cv_forced_unwind=yes          \
      libc_cv_c_cleanup=yes &&
make &&
make install &&
# skip check
cd $LFS/sources &&
rm -rf glibc-2.25 &&
echo "---------------------------"


# 5.8.[Libstdc++ from GCC-8.2.0](tmp-system/005-libstdc++.md)———0.5 SBU(必须按照顺序来安装)
cd $LFS/sources &&
tar xvf gcc-8.2.0.tar.xz &&
cd gcc-8.2.0 &&
mkdir -v build &&
cd       build &&
../libstdc++-v3/configure           \
    --host=$LFS_TGT                 \
    --prefix=/tools                 \
    --disable-multilib              \
    --disable-nls                   \
    --disable-libstdcxx-threads     \
    --disable-libstdcxx-pch         \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/8.2.0 &&
make &&
make install &&
cd $LFS/sources &&
rm -rf gcc-8.2.0 &&
echo "sucessful install: gcc-8.2.0" &&
echo "----------------------------" &&

# 5.9.[Binutils-2.31.1 - Pass 2](../Guide/tmp-system/006-binutils-paas2.md)———1.1 SBU(必须按照顺序来安装)
cd $LFS/sources &&
tar xvf binutils-2.31.1.tar.xz &&
cd binutils-2.31.1 &&
mkdir -v build &&
cd       build &&
CC=$LFS_TGT-gcc                \
AR=$LFS_TGT-ar                 \
RANLIB=$LFS_TGT-ranlib         \
../configure                   \
    --prefix=/tools            \
    --disable-nls              \
    --disable-werror           \
    --with-lib-path=/tools/lib \
    --with-sysroot &&
make &&
make install &&
make -C ld clean &&
make -C ld LIB_PATH=/usr/lib:/lib &&
cp -v ld/ld-new /tools/bin &&
cd $LFS/sources &&
rm -rf binutils-2.31.1
echo "---------------------------"

# 5.10.[GCC-8.2.0 - Pass 2](../Guide/tmp-system/007-gcc-pass2.md)———11 SBU(必须按照顺序来安装)
cd $LFS/sources &&
tar xvf gcc-8.2.0.tar.xz &&
cd gcc-8.2.0 &&
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include-fixed/limits.h &&
for file in gcc/config/{linux,i386/linux{,64}}.h
do
  cp -uv $file{,.orig}
  sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
      -e 's@/usr@/tools@g' $file.orig > $file
  echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
  touch $file.orig
done &&
case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
  ;;
esac &&
tar -xf ../mpfr-4.0.1.tar.xz &&
mv -v mpfr-4.0.1 mpfr &&
tar -xf ../gmp-6.1.2.tar.xz &&
mv -v gmp-6.1.2 gmp &&
tar -xf ../mpc-1.1.0.tar.gz &&
mv -v mpc-1.1.0 mpc &&
mkdir -v build &&
cd       build &&
CC=$LFS_TGT-gcc                                    \
CXX=$LFS_TGT-g++                                   \
AR=$LFS_TGT-ar                                     \
RANLIB=$LFS_TGT-ranlib                             \
../configure                                       \
    --prefix=/tools                                \
    --with-local-prefix=/tools                     \
    --with-native-system-header-dir=/tools/include \
    --enable-languages=c,c++                       \
    --disable-libstdcxx-pch                        \
    --disable-multilib                             \
    --disable-bootstrap                            \
    --disable-libgomp &&
make &&
make install &&
ln -sv gcc /tools/bin/cc
# skip check
cd $LFS/sources &&
rm -rf gcc-8.2.0 &&
echo "sucessful install: gcc-8.2.0" &&
echo "---------------------------" &&





cd $LFS/sources &&
tar zxvf tcl8.6.8-src.tar.gz &&
cd tcl8.6.8 &&
cd unix &&
./configure --prefix=/tools &&
make &&
make install &&
chmod -v u+w /tools/lib/libtcl8.6.so &&
make install-private-headers &&
ln -sv tclsh8.6 /tools/bin/tclsh &&
cd $LFS/sources &&
rm -rf tcl8.6.8 &&
echo "sucessful install: tcl8.6.8" &&
echo "---------------------------" &&



cd $LFS/sources &&
tar zxvf expect5.45.4.tar.gz &&
cd expect5.45.4 &&
cp -v configure{,.orig} &&
sed 's:/usr/local/bin:/bin:' configure.orig > configure &&
./configure --prefix=/tools       \
            --with-tcl=/tools/lib \
            --with-tclinclude=/tools/include &&
make &&
make SCRIPTS="" install &&
cd $LFS/sources &&
rm -rf expect5.45.4 &&
echo "sucessful install: expect5.45.4" &&
echo "---------------------------" &&


cd $LFS/sources &&
tar zxvf dejagnu-1.6.1.tar.gz &&
cd dejagnu-1.6.1 &&
./configure --prefix=/tools &&
make install &&
cd $LFS/sources &&
rm -rf dejagnu-1.6.1 &&
echo "sucessful install dejagnu-1.6.1" &&
echo "---------------------------" &&


cd $LFS/sources &&
tar xvf m4-1.4.18.tar.xz &&
cd m4-1.4.18 &&
sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' lib/*.c &&
echo "#define _IO_IN_BACKUP 0x100" >> lib/stdio-impl.h &&
./configure --prefix=/tools &&
make &&
make install &&
cd $LFS/sources &&
rm -rf m4-1.4.18 &&
echo "sucessful install m4-1.4.18" &&
echo "---------------------------" &&

cd $LFS/sources &&
tar zxvf ncurses-6.1.tar.gz &&
cd ncurses-6.1 &&
sed -i s/mawk// configure &&
./configure --prefix=/tools \
            --with-shared   \
            --without-debug \
            --without-ada   \
            --enable-widec  \
            --enable-overwrite &&
make && make install &&
cd $LFS/sources &&
rm -rf ncurses-6.1 &&
echo "sucessful install ncurses-6.1" &&
echo "---------------------------" &&




cd $LFS/sources  &&
tar zxvf bash-4.4.18.tar.gz &&
cd bash-4.4.18 &&
./configure --prefix=/tools --without-bash-malloc &&
make && make install &&
ln -sv bash /tools/bin/sh &&
cd $LFS/sources &&
rm -rf bash-4.4.18 &&
echo "sucessful install bash-4.4.18" &&
echo "---------------------------" &&


cd $LFS/sources &&
tar xvf bison-3.0.5.tar.xz &&
cd bison-3.0.5 &&
./configure --prefix=/tools &&
make && make install &&
cd $LFS/sources &&
rm -rvf bison-3.0.5 &&
echo "sucessful install bison-3.0.5" &&
echo "---------------------------" &&


cd $LFS/sources &&
tar xvf bzip2-1.0.6.tar.gz &&
cd bzip2-1.0.6 &&
make && make PREFIX=/tools install &&
cd $LFS/sources &&
rm -rvf bzip2-1.0.6 &&
echo "sucessful install bzip2-1.0.6" &&
echo "---------------------------" &&
cd $LFS/sources &&


tar xvf coreutils-8.30.tar.xz &&
cd coreutils-8.30 &&
./configure --prefix=/tools --enable-install-program=hostname &&
make && make install &&
cd $LFS/sources &&
rm -rvf coreutils-8.30 &&
echo "sucessful install coreutils-8.30" &&
echo "---------------------------" &&


cd $LFS/sources &&
tar xvf diffutils-3.6.tar.xz &&
cd diffutils-3.6 &&
./configure --prefix=/tools &&
make && make install &&
cd $LFS/sources &&
rm -rvf diffutils-3.6 &&
echo "sucessful install diffutils-3.6" &&
echo "---------------------------" &&


cd $LFS/sources &&
tar zxvf file-5.34.tar.gz &&
cd file-5.34 &&
./configure --prefix=/tools &&
make && make install &&
cd $LFS/sources &&
rm -rvf file-5.34 &&
echo "sucessful install file-5.34 " &&
echo "---------------------------" &&




cd $LFS/sources &&
tar zxvf findutils-4.6.0.tar.gz &&
cd findutils-4.6.0 &&
sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' gl/lib/*.c &&
sed -i '/unistd/a #include <sys/sysmacros.h>' gl/lib/mountlist.c &&
echo "#define _IO_IN_BACKUP 0x100" >> gl/lib/stdio-impl.h &&
./configure --prefix=/tools &&
make && make install &&
cd $LFS/sources &&
rm -rvf findutils-4.6.0 &&
echo "sucessful install gcc-8.2.0" &&
echo "---------------------------" &&


cd $LFS/sources&&
tar xvf gawk-4.2.1.tar.xz &&
cd gawk-4.2.1 &&
./configure --prefix=/tools &&
make && make install &&
cd $LFS/sources &&
rm -rvf gawk-4.2.1 &&
echo "sucessful install gawk-4.2.1" &&
echo "---------------------------" &&



cd $LFS/sources &&
tar xvf gettext-0.19.8.1.tar.xz &&
cd gettext-0.19.8.1 &&
cd gettext-tools &&
EMACS="no" ./configure --prefix=/tools --disable-shared &&
make -C gnulib-lib &&
make -C intl pluralx.c &&
make -C src msgfmt &&
make -C src msgmerge &&
make -C src xgettext &&
cp -v src/{msgfmt,msgmerge,xgettext} /tools/bin &&
cd $LFS/sources &&
rm -rvf gettext-0.19.8.1 &&
echo "sucessful install gettext-0.19.8.1" &&
echo "---------------------------" &&

cd $LFS/sources &&
tar xvf grep-3.1.tar.xz &&
cd grep-3.1 &&
./configure --prefix=/tools &&
make && make install &&
cd $LFS/sources &&
rm -rvf grep-3.1 &&
echo "sucessful install grep-3.1" &&
echo "---------------------------" &&

cd $LFS/sources &&
tar xvf gzip-1.9.tar.xz &&
cd gzip-1.9 &&
sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' lib/*.c &&
echo "#define _IO_IN_BACKUP 0x100" >> lib/stdio-impl.h &&
./configure --prefix=/tools &&
make && make install &&
cd $LFS/sources &&
rm -rvf gzip-1.9 &&
echo "sucessful install gzip-1.9" &&
echo "---------------------------" &&


cd $LFS/sources &&
tar xvf make-4.2.1.tar.bz2 &&
cd make-4.2.1 &&
sed -i '211,217 d; 219,229 d; 232 d' glob/glob.c &&
./configure --prefix=/tools --without-guile &&
make && make install &&
cd $LFS/sources &&
rm -rvf make-4.2.1 &&
echo "sucessful install gzip-1.9" &&
echo "---------------------------" &&


cd $LFS/sources &&
tar xvf patch-2.7.6.tar.xz &&
cd patch-2.7.6 &&
./configure --prefix=/tools &&
make && make install &&
cd $LFS/sources &&
rm -rvf patch-2.7.6 &&
echo "sucessful install patch-2.7.6" &&
echo "---------------------------" &&


cd $LFS/sources &&
tar xvf perl-5.28.0.tar.xz &&
cd perl-5.28.0 &&
sh Configure -des -Dprefix=/tools -Dlibs=-lm -Uloclibpth -Ulocincpth &&
make &&
cp -v perl cpan/podlators/scripts/pod2man /tools/bin &&
mkdir -pv /tools/lib/perl5/5.28.0 &&
cp -Rv lib/* /tools/lib/perl5/5.28.0 &&
cd $LFS/sources &&
rm -rvf perl-5.28.0 &&
echo "sucessful install perl-5.28.0" &&
echo "---------------------------" &&


cd $LFS/sources &&
tar xvf sed-4.5.tar.xz &&
cd sed-4.5 &&
./configure --prefix=/tools &&
make && make install &&
cd $LFS/sources &&
rm -rvf sed-4.5 &&
echo "sucessful install sed-4.5" &&
echo "---------------------------" &&


cd $LFS/sources &&
tar xvf tar-1.30.tar.xz &&
cd tar-1.30 &&
./configure --prefix=/tools &&
make && make install &&
cd $LFS/sources &&
rm -rvf tar-1.30 &&
echo "sucessful install tar-1.30" &&
echo "---------------------------" &&


cd $LFS/sources &&
tar xvf texinfo-6.5.tar.xz &&
cd texinfo-6.5 &&
./configure --prefix=/tools &&
make && make install &&
cd $LFS/sources &&
rm -rvf texinfo-6.5 &&
echo "sucessful install texinfo-6.5" &&
echo "---------------------------" &&


cd $LFS/sources &&
tar xvf util-linux-2.32.1.tar.xz &&
cd util-linux-2.32.1 &&
./configure --prefix=/tools                \
            --without-python               \
            --disable-makeinstall-chown    \
            --without-systemdsystemunitdir \
            --without-ncurses              \
            PKG_CONFIG="" &&
make && make install &&
cd $LFS/sources &&
rm -rvf util-linux-2.32.1 &&
echo "sucessful install util-linux-2.32.1" &&
echo "---------------------------" &&


cd $LFS/sources &&
tar xvf xz-5.2.4.tar.xz &&
cd xz-5.2.4 &&
./configure --prefix=/tools &&
make && make install &&
cd $LFS/sources &&
rm -rvf xz-5.2.4 &&
echo "sucessful install xz-5.2.4" &&
echo "---------------------------"
