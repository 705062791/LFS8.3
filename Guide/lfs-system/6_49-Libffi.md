```bash
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
echo "---------------------"
```