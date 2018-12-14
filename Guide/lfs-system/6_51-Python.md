```bash
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
echo "---------------------"
```