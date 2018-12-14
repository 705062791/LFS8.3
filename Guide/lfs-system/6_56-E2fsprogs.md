```bash
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
echo "---------------------"
```