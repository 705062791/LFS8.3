```bash
cd $LFS/sources 
[ -e gzip-1.9 ] && rm -rf gzip-1.9
tar xvf gzip-1.9.tar.xz &&
cd gzip-1.9 &&
sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' lib/*.c &&
echo "#define _IO_IN_BACKUP 0x100" >> lib/stdio-impl.h &&
./configure --prefix=/tools &&
make && make install &&
cd $LFS/sources &&
rm -rvf gzip-1.9
```
