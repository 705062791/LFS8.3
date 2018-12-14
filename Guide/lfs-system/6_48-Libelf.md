```bash
cd /sources &&
tar -jxvf elfutils-0.173.tar.bz2 &&
cd elfutils-0.173 &&
./configure --prefix=/usr &&
make && make -C libelf install &&

install -vm644 config/libelf.pc /usr/lib/pkgconfig &&
cd /sources &&
rm -rf elfutils-0.173 &&
echo "sucessful install elfutils-0.173" && 
echo "---------------------"
```