```bash
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
echo "---------------------"
```