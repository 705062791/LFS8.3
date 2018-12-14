```bash
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
echo "---------------------"
```