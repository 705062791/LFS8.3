```bash
cd /sources &&
tar xvJf gzip-1.9.tar.xz &&
cd gzip-1.9 &&

sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' lib/*.c &&
echo "#define _IO_IN_BACKUP 0x100" >> lib/stdio-impl.h &&
./configure --prefix=/usr &&
make && make install &&
mv -v /usr/bin/gzip /bin &&

cd /sources &&
rm -rf gzip-1.9 &&
echo "sucessful install gzip-1.9" && 
echo "---------------------"
```