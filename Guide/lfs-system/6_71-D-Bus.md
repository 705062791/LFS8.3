```bash
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
echo "---------------------"
```