```bash
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
echo "---------------------"
```