```bash
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
echo "---------------------"
```