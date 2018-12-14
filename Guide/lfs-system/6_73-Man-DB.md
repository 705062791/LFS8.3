```bash
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
echo "---------------------"
```