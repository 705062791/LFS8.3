```bash
cd /sources &&
tar -zxvf gdbm-1.17.tar.gz &&
cd gdbm-1.17 &&
./configure --prefix=/usr \
--disable-static \
--enable-libgdbm-compat &&

make && make install &&
cd /sources &&
rm -rf gdbm-1.17 &&
echo "sucessful install gdbm-1.17" && 
echo "---------------------"
```