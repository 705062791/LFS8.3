cd /sources &&
tar xvf linux-4.18.5.tar.xz &&
cd linux-4.18.5 &&
make mrproper &&
make INSTALL_HDR_PATH=dest headers_install &&
find dest/include \( -name .install -o -name ..install.cmd \) -delete &&
cp -rv dest/include/* /usr/include &&
cd /sources &&
rm -rf linux-4.18.5 &&
echo "sucessful install: 6.7.[Linux-4.18.5 API Headers]" &&
echo "---------------------------------------" &&

cd /sources &&
tar xvf man-pages-4.16.tar.xz &&
cd man-pages-4.16 &&
make install &&
cd /sources &&
rm -rvf man-pages-4.16 &&
echo "sucessful install: 6.8.[Man-pages-4.16]" &&
echo "---------------------------------------" &&


cd /sources &&
tar xvf glibc-2.28.tar.xz &&
cd glibc-2.28 &&
patch -Np1 -i ../glibc-2.28-fhs-1.patch &&
ln -sfv /tools/lib/gcc /usr/lib &&
case $(uname -m) in
    i?86)    GCC_INCDIR=/usr/lib/gcc/$(uname -m)-pc-linux-gnu/8.2.0/include
            ln -sfv ld-linux.so.2 /lib/ld-lsb.so.3
    ;;
    x86_64) GCC_INCDIR=/usr/lib/gcc/x86_64-pc-linux-gnu/8.2.0/include
            ln -sfv ../lib/ld-linux-x86-64.so.2 /lib64
            ln -sfv ../lib/ld-linux-x86-64.so.2 /lib64/ld-lsb-x86-64.so.3
    ;;
esac &&
rm -f /usr/include/limits.h &&
mkdir -v build &&
cd       build &&
CC="gcc -isystem $GCC_INCDIR -isystem /usr/include" \
../configure --prefix=/usr                          \
             --disable-werror                       \
             --enable-kernel=3.2                    \
             --enable-stack-protector=strong        \
             libc_cv_slibdir=/lib &&
unset GCC_INCDIR &&
make &&
touch /etc/ld.so.conf &&
sed '/test-installation/s@$(PERL)@echo not running@' -i ../Makefile &&
make install &&
cp -v ../nscd/nscd.conf /etc/nscd.conf &&
mkdir -pv /var/cache/nscd &&

# *安装语言环境*
mkdir -pv /usr/lib/locale &&
localedef -i cs_CZ -f UTF-8 cs_CZ.UTF-8
localedef -i de_DE -f ISO-8859-1 de_DE
localedef -i de_DE@euro -f ISO-8859-15 de_DE@euro
localedef -i de_DE -f UTF-8 de_DE.UTF-8
localedef -i en_GB -f UTF-8 en_GB.UTF-8
localedef -i en_HK -f ISO-8859-1 en_HK
localedef -i en_PH -f ISO-8859-1 en_PH
localedef -i en_US -f ISO-8859-1 en_US
localedef -i en_US -f UTF-8 en_US.UTF-8
localedef -i es_MX -f ISO-8859-1 es_MX
localedef -i fa_IR -f UTF-8 fa_IR
localedef -i fr_FR -f ISO-8859-1 fr_FR
localedef -i fr_FR@euro -f ISO-8859-15 fr_FR@euro
localedef -i fr_FR -f UTF-8 fr_FR.UTF-8
localedef -i it_IT -f ISO-8859-1 it_IT
localedef -i it_IT -f UTF-8 it_IT.UTF-8
localedef -i ja_JP -f EUC-JP ja_JP
localedef -i ru_RU -f KOI8-R ru_RU.KOI8-R
localedef -i ru_RU -f UTF-8 ru_RU.UTF-8
localedef -i tr_TR -f UTF-8 tr_TR.UTF-8
localedef -i zh_CN -f GB18030 zh_CN.GB18030

# 配置glibc
cat > /etc/nsswitch.conf << "EOF"
# Begin /etc/nsswitch.conf

passwd: files
group: files
shadow: files

hosts: files dns
networks: files

protocols: files
services: files
ethers: files
rpc: files

# End /etc/nsswitch.conf
EOF

# 添加时区数据*
tar -xf ../../tzdata2018e.tar.gz &&

ZONEINFO=/usr/share/zoneinfo &&
mkdir -pv $ZONEINFO/{posix,right} &&

for tz in etcetera southamerica northamerica europe africa antarctica  \
          asia australasia backward pacificnew systemv; do
    zic -L /dev/null   -d $ZONEINFO       -y "sh yearistype.sh" ${tz}
    zic -L /dev/null   -d $ZONEINFO/posix -y "sh yearistype.sh" ${tz}
    zic -L leapseconds -d $ZONEINFO/right -y "sh yearistype.sh" ${tz}
done

cp -v zone.tab zone1970.tab iso3166.tab $ZONEINFO &&
zic -d $ZONEINFO -p America/New_York &&
unset ZONEINFO &&

# *选择时区设置*
# tzselect
cp -v /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# *配置加载*
cat > /etc/ld.so.conf << "EOF"
# Begin /etc/ld.so.conf
/usr/local/lib
/opt/lib

EOF

cat >> /etc/ld.so.conf << "EOF"
# Add an include directory
include /etc/ld.so.conf.d/*.conf

EOF
mkdir -pv /etc/ld.so.conf.d &&
# *清理*
cd /sources &&
rm -rvf glibc-2.28 &&
echo "sucessful install: 6.9.[Glibc-2.28]" &&
echo "---------------------------------------" &&


# 6.10.[调整工具链](../Guide/lfs-system/004-adjust-tool.md)

echo "sucessful install: 6.10.[调整工具链]" &&
echo "---------------------------------------" &&





# 6.11.[Zlib-1.2.11](../Guide/lfs-system/005-zlib.md)—— <0.1 SBU
cd /sources &&
tar xvf zlib-1.2.11.tar.xz &&
cd zlib-1.2.11 &&
./configure --prefix=/usr &&
make &&
make install &&
mv -v /usr/lib/libz.so.* /lib &&
ln -sfv ../../lib/$(readlink /usr/lib/libz.so) /usr/lib/libz.so &&
cd /sources &&
rm -rvf zlib-1.2.11 &&
echo "sucessful install: 6.11.[Zlib-1.2.11]" &&
echo "---------------------------------------" &&


# 6.12.[File-5.34](../Guide/lfs-system/006-file.md)—— 0.1 SBU
cd /sources &&
tar zxvf file-5.34.tar.gz &&
cd file-5.34 &&
./configure --prefix=/usr &&
make && make install &&
cd /sources &&
rm -rvf file-5.34 &&
echo "sucessful install: 6.12.[File-5.34]" &&
echo "---------------------------------------" &&


# 6.13.[Readline-7.0](../Guide/lfs-system/007-readline.md)—— 0.1 SBU
cd /sources &&
tar zxvf readline-7.0.tar.gz &&
cd readline-7.0
sed -i '/MV.*old/d' Makefile.in &&
sed -i '/{OLDSUFF}/c:' support/shlib-install &&
./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/readline-7.0 &&
make SHLIB_LIBS="-L/tools/lib -lncursesw" &&
make SHLIB_LIBS="-L/tools/lib -lncurses" install &&
mv -v /usr/lib/lib{readline,history}.so.* /lib &&
chmod -v u+w /lib/lib{readline,history}.so.* &&
ln -sfv ../../lib/$(readlink /usr/lib/libreadline.so) /usr/lib/libreadline.so &&
ln -sfv ../../lib/$(readlink /usr/lib/libhistory.so ) /usr/lib/libhistory.so &&
cd /sources &&
rm -rvf readline-7.0 &&
echo "sucessful install: 6.13.[Readline-7.0]" &&
echo "---------------------------------------" &&

# 6.14.[M4-1.4.18](../Guide/lfs-system/008-m4.md)—— 0.4 SBU
cd /sources &&
tar xvf m4-1.4.18.tar.xz &&
cd m4-1.4.18 &&
sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' lib/*.c &&
echo "#define _IO_IN_BACKUP 0x100" >> lib/stdio-impl.h &&
./configure --prefix=/usr &&
make &&
make install &&
cd /sources &&
rm -rvf m4-1.4.18 &&
echo "sucessful install: 6.14.[M4-1.4.18]" &&
echo "---------------------------------------" &&


# 6.15.[Bc-1.07.1](../Guide/lfs-system/009-bc.md)—— 0.1 SBU
cd /sources &&
tar zxvf bc-1.07.1.tar.gz &&
cd bc-1.07.1 &&
cat > bc/fix-libmath_h << "EOF"
#! /bin/bash
sed -e '1   s/^/{"/' \
    -e     's/$/",/' \
    -e '2,$ s/^/"/'  \
    -e   '$ d'       \
    -i libmath.h

sed -e '$ s/$/0}/' \
    -i libmath.h
EOF

ln -sv /tools/lib/libncursesw.so.6 /usr/lib/libncursesw.so.6 &&
ln -sfv libncurses.so.6 /usr/lib/libncurses.so &&
sed -i -e '/flex/s/as_fn_error/: ;; # &/' configure &&
./configure --prefix=/usr           \
            --with-readline         \
            --mandir=/usr/share/man \
            --infodir=/usr/share/info &&
make && make install &&
cd /sources &&
rm -rvf bc-1.07.1 &&
echo "sucessful install: 6.15.[Bc-1.07.1]" &&
echo "---------------------------------------" &&

# 6.16.[Binutils-2.31.1](../Guide/lfs-system/010-binutils.md)—— 6.6 SBU
cd /sources &&
tar xvf binutils-2.31.1.tar.xz &&
cd binutils-2.31.1 &&
expect -c "spawn ls" &&
mkdir -v build &&
cd       build &&
../configure --prefix=/usr       \
             --enable-gold       \
             --enable-ld=default \
             --enable-plugins    \
             --enable-shared     \
             --disable-werror    \
             --enable-64-bit-bfd \
             --with-system-zlib &&
make tooldir=/usr &&
make tooldir=/usr install &&
cd /sources &&
rm -rvf binutils-2.31.1 &&
echo "sucessful install: 6.16.[Binutils-2.31.1]" &&
echo "---------------------------------------" &&


# 6.17.[GMP-6.1.2](../Guide/lfs-system/011-gmp.md)—— 1.3 SBU
cd /sources &&
tar xvf gmp-6.1.2.tar.xz &&
cd gmp-6.1.2 &&
cp -v configfsf.guess config.guess &&
cp -v configfsf.sub   config.sub &&
./configure --prefix=/usr    \
            --enable-cxx     \
            --disable-static \
            --docdir=/usr/share/doc/gmp-6.1.2 &&
make && make install &&
cd /sources &&
rm -rvf  gmp-6.1.2
echo "sucessful install: 6.17.[GMP-6.1.2]" &&
echo "---------------------------------------" &&


# 6.18.[MPFR-4.0.1](../Guide/lfs-system/012-mpfr.md)—— 1.1 SBU
cd /sources &&
tar xvf mpfr-4.0.1.tar.xz &&
cd mpfr-4.0.1 &&
./configure --prefix=/usr        \
            --disable-static     \
            --enable-thread-safe \
            --docdir=/usr/share/doc/mpfr-4.0.1 &&
make && make install &&
cd /sources &&
rm -rvf mpfr-4.0.1 &&
echo "sucessful install: 6.18.[MPFR-4.0.1]" &&
echo "---------------------------------------" &&


# 6.19.[MPC-1.1.0](../Guide/lfs-system/013-mpc.md)—— 0.3 SBU
cd /sources &&
tar zxvf mpc-1.1.0.tar.gz &&
cd mpc-1.1.0 &&
./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/mpc-1.1.0 &&
make && make install &&
cd /sources &&
rm -rvf mpc-1.1.0 &&
echo "sucessful install: 6.19.[MPC-1.1.0]" &&
echo "---------------------------------------" &&


# 6.20.[Shadow-4.6](../Guide/lfs-system/014-shadow.md)—— 0.2 SBU
cd /sources &&
tar xvf shadow-4.6.tar.xz &&
cd shadow-4.6 &&
sed -i 's/groups$(EXEEXT) //' src/Makefile.in &&
find man -name Makefile.in -exec sed -i 's/groups\.1 / /'   {} \; &&
find man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \; &&
find man -name Makefile.in -exec sed -i 's/passwd\.5 / /'   {} \; &&
sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@' \
       -e 's@/var/spool/mail@/var/mail@' etc/login.defs &&
sed -i 's@DICTPATH.*@DICTPATH\t/lib/cracklib/pw_dict@' etc/login.defs &&
sed -i 's/1000/999/' etc/useradd &&
./configure --sysconfdir=/etc --with-group-name-max-length=32 --with-libcrack &&
make && make install &&
mv -v /usr/bin/passwd /bin &&
pwconv && grpconv &&
sed -i 's/yes/no/' /etc/default/useradd &&
cd /sources &&
rm -rvf shadow-4.6 &&
echo "sucessful install: 6.20.[Shadow-4.6]" &&
echo "---------------------------------------" &&


# 6.21.[GCC-8.2.0](../Guide/lfs-system/015-gcc.md)—— 92 SBU
cd /sources &&
tar xvf gcc-8.2.0.tar.xz &&
cd gcc-8.2.0 &&
case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
  ;;
esac &&
rm -f /usr/lib/gcc &&
mkdir -v build &&
cd       build &&
SED=sed                               \
../configure --prefix=/usr            \
             --enable-languages=c,c++ \
             --disable-multilib       \
             --disable-bootstrap      \
             --disable-libmpx         \
             --with-system-zlib &&
make &&
make install &&
ln -sv ../usr/bin/cpp /lib &&
ln -sv gcc /usr/bin/cc &&
install -v -dm755 /usr/lib/bfd-plugins &&
ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/8.2.0/liblto_plugin.so \
        /usr/lib/bfd-plugins/ &&
mkdir -pv /usr/share/gdb/auto-load/usr/lib &&
mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib &&
cd /sources &&
rm -rvf gcc-8.2.0 &&
echo "sucessful install: 6.21.[GCC-8.2.0]" &&
echo "---------------------------------------" &&


cd /sources &&
tar zxvf bzip2-1.0.6.tar.gz &&
cd bzip2-1.0.6
patch -Np1 -i ../bzip2-1.0.6-install_docs-1.patch &&
sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile &&
sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile &&
make -f Makefile-libbz2_so &&
make clean &&
make &&
make PREFIX=/usr install &&
cp -v bzip2-shared /bin/bzip2 &&
cp -av libbz2.so* /lib &&
ln -sv ../../lib/libbz2.so.1.0 /usr/lib/libbz2.so &&
rm -v /usr/bin/{bunzip2,bzcat,bzip2} &&
ln -sv bzip2 /bin/bunzip2 &&
ln -sv bzip2 /bin/bzcat &&
cd /sources &&
rm -rvf bzip2-1.0.6 &&
echo "sucessful install: 6.22.[Bzip2-1.0.6]" &&
echo "---------------------------------------" &&


cd /sources &&
tar zxvf pkg-config-0.29.2.tar.gz &&
cd pkg-config-0.29.2 &&
./configure --prefix=/usr              \
            --with-internal-glib       \
            --disable-host-tool        \
            --docdir=/usr/share/doc/pkg-config-0.29.2 &&
make && make install &&
cd /sources &&
rm -rvf pkg-config-0.29.2 &&
echo "sucessful install: 6.23.[Pkg-config-0.29.2]" &&
echo "---------------------------------------" &&

cd /sources &&
tar zxvf ncurses-6.1.tar.gz &&
cd ncurses-6.1 &&
sed -i '/LIBTOOL_INSTALL/d' c++/Makefile.in &&
./configure --prefix=/usr           \
            --mandir=/usr/share/man \
            --with-shared           \
            --without-debug         \
            --without-normal        \
            --enable-pc-files       \
            --enable-widec &&
make && make install &&
mv -v /usr/lib/libncursesw.so.6* /lib &&
ln -sfv ../../lib/$(readlink /usr/lib/libncursesw.so) /usr/lib/libncursesw.so &&
for lib in ncurses form panel menu ; do
    rm -vf                    /usr/lib/lib${lib}.so
    echo "INPUT(-l${lib}w)" > /usr/lib/lib${lib}.so
    ln -sfv ${lib}w.pc        /usr/lib/pkgconfig/${lib}.pc
done &&
rm -vf                     /usr/lib/libcursesw.so &&
echo "INPUT(-lncursesw)" > /usr/lib/libcursesw.so &&
ln -sfv libncurses.so      /usr/lib/libcurses.so &&
make distclean &&
./configure --prefix=/usr    \
            --with-shared    \
            --without-normal \
            --without-debug  \
            --without-cxx-binding \
            --with-abi-version=5  &&
make sources libs &&
cp -av lib/lib*.so.5* /usr/lib &&
cd /sources &&
rm -rvf ncurses-6.1 &&
echo "sucessful install: 6.24.[Ncurses-6.1]" &&
echo "---------------------------------------" &&


cd /sources &&
tar -zxvf attr-2.4.48.tar.gz &&
cd attr-2.4.48 &&
./configure --prefix=/usr \
--disable-static \
--sysconfdir=/etc \
--docdir=/usr/share/doc/attr-2.4.48 &&
make && make install &&
mv -v /usr/lib/libattr.so.* /lib &&
ln -sfv ../../lib/$(readlink /usr/lib/libattr.so) /usr/lib/libattr.so &&

cd /sources &&
rm -rf attr-2.4.48 &&
echo "sucessful install attr-2.4.48" &&
echo "---------------------" &&


cd /sources &&
tar -zxvf acl-2.2.53.tar.gz &&
cd acl-2.2.53 &&
./configure --prefix=/usr \
--disable-static \
--libexecdir=/usr/lib \
--docdir=/usr/share/doc/acl-2.2.53 &&
make && make install &&
mv -v /usr/lib/libacl.so.* /lib &&
ln -sfv ../../lib/$(readlink /usr/lib/libacl.so) /usr/lib/libacl.so &&
cd /sources &&
rm -rf acl-2.2.53 &&
echo "sucessful install acl-2.2.53" &&
echo "---------------------" &&

cd /sources &&
tar xvJf libcap-2.25.tar.xz &&
cd libcap-2.25 &&

sed -i '/install.*STALIBNAME/d' libcap/Makefile &&
make &&
make RAISE_SETFCAP=no lib=lib prefix=/usr install &&
chmod -v 755 /usr/lib/libcap.so &&
mv -v /usr/lib/libcap.so.* /lib &&
ln -sfv ../../lib/$(readlink /usr/lib/libcap.so) /usr/lib/libcap.so &&

cd /sources &&
rm -rf libcap-2.25 &&
echo "sucessful install libcap-2.25" &&
echo "---------------------" &&

cd /sources &&
tar xvJf sed-4.5.tar.xz &&
cd sed-4.5 &&

sed -i 's/usr/tools/' build-aux/help2man &&
sed -i 's/testsuite.panic-tests.sh//' Makefile.in &&
./configure --prefix=/usr --bindir=/bin &&
make && make install &&
install -d -m755 /usr/share/doc/sed-4.5 &&
cd /sources &&
rm -rf sed-4.5 &&
echo "sucessful install sed-4.5" &&
echo "---------------------" &&

cd /sources &&
tar xvJf psmisc-23.1.tar.xz &&
cd psmisc-23.1 &&

./configure --prefix=/usr &&
make && make install &&
mv -v /usr/bin/fuser /bin &&
mv -v /usr/bin/killall /bin &&

cd /sources &&
rm -rf psmisc-23.1 &&
echo "sucessful install psmisc-23.1" &&
echo "---------------------" &&

cd /sources &&
tar -jxvf iana-etc-2.30.tar.bz2 &&
cd iana-etc-2.30 &&
make &&
make install &&
cd /sources &&
rm -rf iana-etc-2.30 &&
echo "sucessful install iana-etc-2.30" &&
echo "---------------------" &&


cd /sources &&
tar xvJf bison-3.0.5.tar.xz &&

cd bison-3.0.5 &&
./configure --prefix=/usr --docdir=/usr/share/doc/bison-3.0.5 &&
make && make install &&
cd /sources &&
rm -rf bison-3.0.5 &&
echo "sucessful install bison-3.0.5" &&
echo "---------------------" &&


cd /sources &&
tar -zxvf flex-2.6.4.tar.gz &&
cd flex-2.6.4 &&
sed -i "/math.h/a #include <malloc.h>" src/flexdef.h  &&
HELP2MAN=/tools/bin/true \
./configure --prefix=/usr --docdir=/usr/share/doc/flex-2.6.4 &&
make && make install &&
ln -sv flex /usr/bin/lex &&
cd /sources &&
rm -rf flex-2.6.4 &&
echo "sucessful install flex-2.6.4" &&
echo "---------------------" &&

cd /sources &&
tar xvJf grep-3.1.tar.xz &&
cd grep-3.1 &&
./configure --prefix=/usr --bindir=/bin &&
make && make install &&
cd /sources &&
rm -rf grep-3.1 &&
echo "sucessful install grep-3.1" &&
echo "---------------------" &&


cd /sources &&
tar -zxvf bash-4.4.18.tar.gz &&
cd bash-4.4.18 &&
./configure --prefix=/usr \
--docdir=/usr/share/doc/bash-4.4.18 \
--without-bash-malloc \
--with-installed-readline &&

make && make install &&
mv -vf /usr/bin/bash /bin &&
exec /bin/bash --login +h &&
cd /sources &&
rm -rf bash-4.4.18 &&
echo "sucessful install bash-4.4.18" &&
echo "---------------------" &&


cd /sources &&
tar xvJf libtool-2.4.6.tar.xz &&
cd libtool-2.4.6 &&
./configure --prefix=/usr &&
make && make install &&
cd /sources &&
rm -rf libtool-2.4.6 &&
echo "sucessful install libtool-2.4.6" &&
echo "---------------------" &&

cd /sources &&


tar -zxvf gdbm-1.17.tar.gz &&
cd gdbm-1.17 &&
./configure --prefix=/usr \
--disable-static \
--enable-libgdbm-compat &&

make && make install &&
cd /sources &&
rm -rf gdbm-1.17 &&
echo "sucessful install gdbm-1.17" &&
echo "---------------------" &&

cd /sources &&
tar -zxvf gperf-3.1.tar.gz &&
cd gperf-3.1 &&
./configure --prefix=/usr --docdir=/usr/share/doc/gperf-3.1 &&
make && make install &&
cd /sources &&
rm -rf gperf-3.1 &&
echo "sucessful install gperf-3.1" &&
echo "---------------------" &&

cd /sources &&
tar -jxvf expat-2.2.6.tar.bz2 &&
cd expat-2.2.6 &&
sed -i 's|usr/bin/env |bin/|' run.sh.in &&
./configure --prefix=/usr \
--disable-static \
--docdir=/usr/share/doc/expat-2.2.6 &&
make && make install &&
install -v -m644 doc/*.{html,png,css} /usr/share/doc/expat-2.2.6 &&
cd /sources &&
rm -rf expat-2.2.6 &&
echo "sucessful install expat-2.2.6" &&
echo "---------------------" &&


cd /sources &&
tar xvJf inetutils-1.9.4.tar.xz &&
cd inetutils-1.9.4 &&
./configure --prefix=/usr \

--localstatedir=/var \
--disable-logger \
--disable-whois \
--disable-rcp \
--disable-rexec \
--disable-rlogin \
--disable-rsh \
--disable-servers &&

make && make install &&
mv -v /usr/bin/{hostname,ping,ping6,traceroute} /bin &&
mv -v /usr/bin/ifconfig /sbin &&
cd /sources &&
rm -rf inetutils-1.9.4 &&
echo "sucessful install inetutils-1.9.4" &&
echo "---------------------" &&

cd /sources &&
tar xvJf perl-5.28.0.tar.xz &&
cd perl-5.28.0 &&
echo "127.0.0.1 localhost $(hostname)" > /etc/hosts &&
export BUILD_ZLIB=False &&
export BUILD_BZIP2=0 &&
sh Configure -des -Dprefix=/usr \
-Dvendorprefix=/usr \
-Dman1dir=/usr/share/man/man1 \
-Dman3dir=/usr/share/man/man3 \
-Dpager="/usr/bin/less -isR" \
-Duseshrplib \
-Dusethreads &&


make && make install &&
unset BUILD_ZLIB BUILD_BZIP2 &&
cd /sources &&
rm -rf perl-5.28.0 &&
echo "sucessful install perl-5.28.0" &&
echo "---------------------" &&

cd /sources &&
tar -zxvf XML-Parser-2.44.tar.gz &&
cd XML-Parser-2.44 &&
perl Makefile.PL&&
make && make install &&
cd /sources &&
rm -rf XML-Parser-2.44 &&
echo "sucessful install XML-Parser-2.44" &&
echo "---------------------" &&

cd /sources &&
tar -zxvf intltool-0.51.0.tar.gz &&
cd intltool-0.51.0 &&
sed -i 's:\\\${:\\\$\\{:' intltool-update.in &&
./configure --prefix=/usr &&
make && make install &&
install -v -Dm644 doc/I18N-HOWTO /usr/share/doc/intltool-0.51.0/I18N-HOWTO &&

cd /sources &&
rm -rf intltool-0.51.0 &&
echo "sucessful install intltool-0.51.0" &&
echo "---------------------" &&

cd /sources &&
tar xvJf autoconf-2.69.tar.xz &&
cd autoconf-2.69 &&
./configure --prefix=/usr &&
make && make install &&
cd /sources &&
rm -rf autoconf-2.69 &&
echo "sucessful install autoconf-2.69" &&
echo "---------------------" &&

cd /sources &&
tar xvJf automake-1.16.1.tar.xz &&
cd automake-1.16.1 &&
./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.16.1 &&
make && make install &&
cd /sources &&
rm -rf automake-1.16.1 &&
echo "sucessful install automake-1.16.1" &&
echo "---------------------" &&


cd /sources &&
tar xvJf xz-5.2.4.tar.xz &&
cd xz-5.2.4 &&
./configure --prefix=/usr \
--disable-static \
--docdir=/usr/share/doc/xz-5.2.4 &&

make && make install &&
mv -v /usr/bin/{lzma,unlzma,lzcat,xz,unxz,xzcat} /bin &&
mv -v /usr/lib/liblzma.so.* /lib &&
ln -svf ../../lib/$(readlink /usr/lib/liblzma.so) /usr/lib/liblzma.so &&
cd /sources &&
rm -rf xz-5.2.4 &&
echo "sucessful install xz-5.2.4" &&
echo "---------------------" &&

cd /sources &&
tar xvJf kmod-25.tar.xz &&
cd kmod-25 &&
./configure --prefix=/usr \
--bindir=/bin \
--sysconfdir=/etc \
--with-rootlibdir=/lib \
--with-xz \
--with-zlib &&

make && make install &&
for target in depmod insmod lsmod modinfo modprobe rmmod; do
ln -sfv ../bin/kmod /sbin/$target
done &&
ln -sfv kmod /bin/lsmod &&
cd /sources &&
rm -rf kmod-25 &&
echo "sucessful install kmod-25" &&
echo "---------------------" &&


cd /sources &&
tar xvJf gettext-0.19.8.1.tar.xz &&
cd gettext-0.19.8.1 &&
sed -i '/^TESTS =/d' gettext-runtime/tests/Makefile.in &&
sed -i 's/test-lock..EXEEXT.//' gettext-tools/gnulib-tests/Makefile.in &&
sed -e '/AppData/{N;N;p;s/\.appdata\./.metainfo./}' \
-i gettext-tools/its/appdata.loc &&
./configure --prefix=/usr \
--disable-static \
--docdir=/usr/share/doc/gettext-0.19.8.1 &&
make && make install &&
chmod -v 0755 /usr/lib/preloadable_libintl.so &&
cd /sources &&
rm -rf gettext-0.19.8.1 &&
echo "sucessful install gettext-0.19.8.1" &&
echo "---------------------" &&

cd /sources &&
tar -jxvf elfutils-0.173.tar.bz2 &&
cd elfutils-0.173 &&
./configure --prefix=/usr &&
make && make -C libelf install &&

install -vm644 config/libelf.pc /usr/lib/pkgconfig &&
cd /sources &&
rm -rf elfutils-0.173 &&
echo "sucessful install elfutils-0.173" &&
echo "---------------------" &&

cd /sources &&
tar -zxvf libffi-3.2.1.tar.gz &&
cd libffi-3.2.1 &&
sed -e '/^includesdir/ s/$(libdir).*$/$(includedir)/' \
-i include/Makefile.in &&
sed -e '/^includedir/ s/=.*$/=@includedir@/' \
-e 's/^Cflags: -I${includedir}/Cflags:/' \
-i libffi.pc.in &&
./configure --prefix=/usr --disable-static --with-gcc-arch=native &&

make && make install &&
cd /sources &&
rm -rf libffi-3.2.1 &&
echo "sucessful install libffi-3.2.1" &&
echo "---------------------" &&

cd /sources &&
tar -zxvf openssl-1.1.0i.tar.gz &&
cd openssl-1.1.0i &&
./config --prefix=/usr \
--openssldir=/etc/ssl \
--libdir=lib \
shared \
zlib-dynamic &&
make &&
sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile &&
make MANSUFFIX=ssl install &&
cd /sources &&
rm -rf openssl-1.1.0i &&

echo "sucessful install openssl-1.1.0i" &&
echo "---------------------" &&

cd /sources &&
tar xvJf Python-3.7.0.tar.xz &&
cd Python-3.7.0 &&

./configure --prefix=/usr \
--enable-shared \
--with-system-expat \
--with-system-ffi \
--with-ensurepip=yes &&
make && make install &&
chmod -v 755 /usr/lib/libpython3.7m.so &&
chmod -v 755 /usr/lib/libpython3.so &&

cd /sources &&
rm -rf Python-3.7.0 &&
echo "sucessful install Python-3.7.0" &&
echo "---------------------" &&


cd /sources &&
tar -zxvf ninja-1.8.2.tar.gz &&
cd ninja-1.8.2 &&

patch -Np1 -i ../ninja-1.8.2-add_NINJAJOBS_var-1.patch  &&
python3 configure.py --bootstrap &&
install -vm755 ninja /usr/bin/ &&
install -vDm644 misc/bash-completion /usr/share/bash-completion/completions/ninja &&
install -vDm644 misc/zsh-completion /usr/share/zsh/site-functions/_ninja &&

cd /sources &&
rm -rf ninja-1.8.2 &&
echo "sucessful install ninja-1.8.2" &&
echo "---------------------" &&

cd /sources &&
tar -zxvf meson-0.47.1.tar.gz &&
cd meson-0.47.1 &&

python3 setup.py build &&
python3 setup.py install --root=dest &&
cp -rv dest/* / &&


cd /sources &&
rm -rf meson-0.47.1 &&
echo "sucessful install meson-0.47.1" &&
echo "---------------------" &&


cd /sources &&
tar -zxvf systemd-239.tar.gz &&
cd systemd-239 &&

ln -sf /tools/bin/true /usr/bin/xsltproc &&
tar -xf ../systemd-man-pages-239.tar.xz &&
sed '166,$ d' -i src/resolve/meson.build &&
patch -Np1 -i ../systemd-239-glibc_statx_fix-1.patch &&
sed -i 's/GROUP="render", //' rules/50-udev-default.rules.in &&
mkdir -p build &&
cd build &&
LANG=en_US.UTF-8 \
meson --prefix=/usr \
--sysconfdir=/etc \
--localstatedir=/var \
-Dblkid=true \
-Dbuildtype=release \
-Ddefault-dnssec=no \
-Dfirstboot=false \
-Dinstall-tests=false \
-Dkill-path=/bin/kill \
-Dkmod-path=/bin/kmod \
-Dldconfig=false \
-Dmount-path=/bin/mount \
-Drootprefix= \
-Drootlibdir=/lib \
-Dsplit-usr=true \
-Dsulogin-path=/sbin/sulogin \
-Dsysusers=false \
-Dumount-path=/bin/umount \
-Db_lto=false \
..
LANG=en_US.UTF-8 ninja &&
LANG=en_US.UTF-8 ninja install &&
rm -rfv /usr/lib/rpm &&
rm -f /usr/bin/xsltproc &&
systemd-machine-id-setup &&
cat > /lib/systemd/systemd-user-sessions << "EOF"
#!/bin/bash
rm -f /run/nologin
EOF

chmod 755 /lib/systemd/systemd-user-sessions &&

cd /sources &&
rm -rf systemd-239 &&
echo "sucessful install systemd-239" &&
echo "---------------------" &&

cd /sources &&
tar xvJf procps-ng-3.3.15.tar.xz &&
cd procps-ng-3.3.15 &&

./configure --prefix=/usr \
--exec-prefix= \
--libdir=/usr/lib \
--docdir=/usr/share/doc/procps-ng-3.3.15 \
--disable-static \
--disable-kill \
--with-systemd &&

make && make install &&
mv -v /usr/lib/libprocps.so.* /lib &&
ln -sfv ../../lib/$(readlink /usr/lib/libprocps.so) /usr/lib/libprocps.so &&


cd /sources &&
rm -rf procps-ng-3.3.15 &&
echo "sucessful install procps-ng-3.3.15" &&
echo "---------------------" &&


cd /sources &&
tar -zxvf e2fsprogs-1.44.3.tar.gz &&
cd e2fsprogs-1.44.3 &&

mkdir -v build &&
cd build &&
../configure --prefix=/usr \
--bindir=/bin \
--with-root-prefix="" \
--enable-elf-shlibs \
--disable-libblkid \
--disable-libuuid \
--disable-uuidd \
--disable-fsck &&

make && make install &&
make install-libs &&


cd /sources &&
rm -rf e2fsprogs-1.44.3 &&
echo "sucessful install e2fsprogs-1.44.3" &&
echo "---------------------" &&


cd /sources &&
tar xvf coreutils-8.30.tar.xz &&
cd coreutils-8.30 &&
patch -Np1 -i ../coreutils-8.30-i18n-1.patch &&
sed -i '/test.lock/s/^/#/' gnulib-tests/gnulib.mk &&
autoreconf -fiv &&
FORCE_UNSAFE_CONFIGURE=1 ./configure \
--prefix=/usr \
--enable-no-install-program=kill,uptime &&
FORCE_UNSAFE_CONFIGURE=1 make &&
make install &&
mv -v /usr/bin/{cat,chgrp,chmod,chown,cp,date,dd,df,echo} /bin &&
mv -v /usr/bin/{false,ln,ls,mkdir,mknod,mv,pwd,rm} /bin &&
mv -v /usr/bin/{rmdir,stty,sync,true,uname} /bin &&
mv -v /usr/bin/chroot /usr/sbin &&
mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8 &&
sed -i s/\"1\"/\"8\"/1 /usr/share/man/man8/chroot.8 &&
mv -v /usr/bin/{head,sleep,nice} /bin &&

cd /sources &&
rm -rf coreutils-8.30 &&
echo "sucessful install coreutils-8.30" &&
echo "---------------------" &&

cd /sources &&
tar -zxvf check-0.12.0.tar.gz &&
cd check-0.12.0 &&

./configure --prefix=/usr &&
make && make install &&
sed -i '1 s/tools/usr/' /usr/bin/checkmk &&

cd /sources &&
rm -rf check-0.12.0 &&
echo "sucessful install check-0.12.0" &&
echo "---------------------" &&

cd /sources &&
tar xvJf diffutils-3.6.tar.xz &&
cd diffutils-3.6 &&

./configure --prefix=/usr &&
make && make install &&


cd /sources &&
rm -rf diffutils-3.6 &&
echo "sucessful install diffutils-3.6" &&
echo "---------------------" &&

cd /sources &&
tar xvJf gawk-4.2.1.tar.xz &&
cd gawk-4.2.1 &&
sed -i 's/extras//' Makefile.in &&
./configure --prefix=/usr &&
make && make install &&
./configure --prefix=/usr &&
mkdir -v /usr/share/doc/gawk-4.2.1 &&
cp -v doc/{awkforai.txt,*.{eps,pdf,jpg}} /usr/share/doc/gawk-4.2.1 &&
cd /sources &&
rm -rf gawk-4.2.1 &&
echo "sucessful install gawk-4.2.1" &&
echo "---------------------" &&


cd /sources &&
tar -zxvf findutils-4.6.0.tar.gz &&
cd findutils-4.6.0 &&

sed -i 's/test-lock..EXEEXT.//' tests/Makefile.in &&
sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' gl/lib/*.c &&
sed -i '/unistd/a #include <sys/sysmacros.h>' gl/lib/mountlist.c &&
echo "#define _IO_IN_BACKUP 0x100" >> gl/lib/stdio-impl.h &&
./configure --prefix=/usr --localstatedir=/var/lib/locate &&
make && make install &&
mv -v /usr/bin/find /bin &&
sed -i 's|find:=${BINDIR}|find:=/bin|' /usr/bin/updatedb &&


cd /sources &&
rm -rf findutils-4.6.0 &&
echo "sucessful install findutils-4.6.0" &&
echo "---------------------" &&

cd /sources &&
tar -zxvf groff-1.22.3.tar.gz &&
cd groff-1.22.3 &&

PAGE=A4 ./configure --prefix=/usr &&
make -j1 && make install &&


cd /sources &&
rm -rf groff-1.22.3 &&
echo "sucessful install groff-1.22.3" &&
echo "---------------------" &&

cd /sources &&
tar xvJf grub-2.02.tar.xz &&
cd grub-2.02 &&

./configure --prefix=/usr \
--sbindir=/sbin \
--sysconfdir=/etc \
--disable-efiemu \
--disable-werror &&

make && make install &&


cd /sources &&
rm -rf grub-2.02 &&
echo "sucessful install grub-2.02" &&
echo "---------------------" &&

cd /sources &&
tar -zxvf less-530.tar.gz &&
cd less-530 &&

./configure --prefix=/usr --sysconfdir=/etc &&
make && make install &&


cd /sources &&
rm -rf less-530 &&
echo "sucessful install less-530" &&
echo "---------------------" &&

cd /sources &&
tar xvJf gzip-1.9.tar.xz &&
cd gzip-1.9 &&

sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' lib/*.c &&
echo "#define _IO_IN_BACKUP 0x100" >> lib/stdio-impl.h &&
./configure --prefix=/usr &&
make && make install &&
mv -v /usr/bin/gzip /bin &&

cd /sources &&
rm -rf gzip-1.9 &&
echo "sucessful install gzip-1.9" &&
echo "---------------------" &&

cd /sources &&
tar xvJf iproute2-4.18.0.tar.xz &&
cd iproute2-4.18.0 &&

sed -i /ARPD/d Makefile &&
rm -fv man/man8/arpd.8 &&
sed -i 's/.m_ipt.o//' tc/Makefile &&
make && make DOCDIR=/usr/share/doc/iproute2-4.18.0 install &&


cd /sources &&
rm -rf iproute2-4.18.0 &&
echo "sucessful install iproute2-4.18.0" &&
echo "---------------------" &&


cd /sources &&
tar xvJf kbd-2.0.4.tar.xz &&
cd kbd-2.0.4 &&

patch -Np1 -i ../kbd-2.0.4-backspace-1.patch &&
sed -i 's/\(RESIZECONS_PROGS=\)yes/\1no/g' configure &&
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in &&
PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr --disable-vlock &&

make && make install &&


cd /sources &&
rm -rf kbd-2.0.4 &&
echo "sucessful install kbd-2.0.4" &&
echo "---------------------" &&

cd /sources &&
tar -zxvf libpipeline-1.5.0.tar.gz &&
cd libpipeline-1.5.0 &&
./configure --prefix=/usr &&
make && make install &
cd /sources &&
rm -rf libpipeline-1.5.0 &&
echo "sucessful install libpipeline-1.5.0" &&
echo "---------------------" &&

cd /sources &&
tar -jxvf make-4.2.1.tar.bz2 &&
cd make-4.2.1 &&

sed -i '211,217 d; 219,229 d; 232 d' glob/glob.c &&
./configure --prefix=/usr &&
make && make install &&

cd /sources &&
rm -rf make-4.2.1 &&
echo "sucessful install make-4.2.1" &&
echo "---------------------" &&

cd /sources &&
tar xvJf patch-2.7.6.tar.xz &&
cd patch-2.7.6 &&

./configure --prefix=/usr &&
make && make install &&


cd /sources &&
rm -rf patch-2.7.6 &&
echo "sucessful install patch-2.7.6" &&
echo "---------------------" &&

cd /sources &&
tar -zxvf dbus-1.12.10.tar.gz &&
cd dbus-1.12.10 &&

./configure --prefix=/usr \
--sysconfdir=/etc \
--localstatedir=/var \
--disable-static \
--disable-doxygen-docs \
--disable-xml-docs \
--docdir=/usr/share/doc/dbus-1.12.10 \
--with-console-auth-dir=/run/console &&
make && make install &&
mv -v /usr/lib/libdbus-1.so.* /lib &&
ln -sfv ../../lib/$(readlink /usr/lib/libdbus-1.so) /usr/lib/libdbus-1.so &&
ln -sfv /etc/machine-id /var/lib/dbus &&
cd /sources &&
rm -rf dbus-1.12.10 &&
echo "sucessful install dbus-1.12.10" &&
echo "---------------------" &&

cd /sources &&
tar xvJf util-linux-2.32.1.tar.xz &&
cd util-linux-2.32.1 &&

mkdir -pv /var/lib/hwclock &&
rm -vf /usr/include/{blkid,libmount,uuid} &&
./configure ADJTIME_PATH=/var/lib/hwclock/adjtime \
--docdir=/usr/share/doc/util-linux-2.32.1 \
--disable-chfn-chsh \
--disable-login \
--disable-nologin \
--disable-su \
--disable-setpriv \
--disable-runuser \
--disable-pylibmount \
--disable-static \
--without-python &&
make && make install &&


cd /sources &&
rm -rf util-linux-2.32.1 &&
echo "sucessful install util-linux-2.32.1" &&
echo "---------------------" &&


cd /sources &&
tar xvJf man-db-2.8.4.tar.xz &&
cd man-db-2.8.4 &&

./configure --prefix=/usr \
--docdir=/usr/share/doc/man-db-2.8.4 \
--sysconfdir=/etc \
--disable-setuid \
--enable-cache-owner=bin \
--with-browser=/usr/bin/lynx \
--with-vgrind=/usr/bin/vgrind \
--with-grap=/usr/bin/grap &&
make && make install &&


cd /sources &&
rm -rf man-db-2.8.4 &&
echo "sucessful install man-db-2.8.4" &&
echo "---------------------" &&

cd /sources &&
tar xvJf tar-1.30.tar.xz &&
cd tar-1.30 &&

FORCE_UNSAFE_CONFIGURE=1 \
./configure --prefix=/usr \
--bindir=/bin &&

make && make install &&


cd /sources &&
rm -rf tar-1.30 &&
echo "sucessful install tar-1.30" &&
echo "---------------------" &&

cd /sources &&
tar xvJf texinfo-6.5.tar.xz &&
cd texinfo-6.5 &&

sed -i '5481,5485 s/({/(\\{/' tp/Texinfo/Parser.pm &&
./configure --prefix=/usr --disable-static &&
make && make install &&
make TEXMF=/usr/share/texmf install-tex &&



cd /sources &&
rm -rf texinfo-6.5 &&
echo "sucessful install texinfo-6.5" &&
echo "---------------------" &&

cd /sources &&
tar -jxvf vim-8.1.tar.bz2 &&
cd vim81 &&

echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h &&
./configure --prefix=/usr &&
make && make install &&
ln -sv vim /usr/bin/vi &&
for L in /usr/share/man/{,*/}man1/vim.1; do
ln -sv vim.1 $(dirname $L)/vi.1
done &&
ln -sv ../vim/vim81/doc /usr/share/doc/vim-8.1 &&
cat > /etc/vimrc << "EOF"
" Begin /etc/vimrc
" Ensure defaults are set before customizing settings, not after
source $VIMRUNTIME/defaults.vim
let skip_defaults_vim=1
set nocompatible
set backspace=2
set mouse=
syntax on
if (&term == "xterm") || (&term == "putty")
set background=dark
endif
" End /etc/vimrc
EOF



cd /sources &&
rm -rf vim-8.1 &&
echo "sucessful install vim-8.1" &&
echo "---------------------"