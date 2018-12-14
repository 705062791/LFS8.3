```bash
cd $LFS/sources &&
[ -e bison-3.0.5 ] && rm -rf bison-3.0.5
tar xvf bison-3.0.5.tar.xz &&
cd bison-3.0.5 &&
./configure --prefix=/tools &&
make && make install &&
cd $LFS/sources &&
rm -rvf bison-3.0.5
```
