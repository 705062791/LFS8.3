```bash
cd $LFS/sources 
[ -e grep-3.1 ] && rm -rf grep-3.1
tar xvf grep-3.1.tar.xz &&
cd grep-3.1 &&
./configure --prefix=/tools &&
make && make install &&
cd $LFS/sources &&
rm -rvf grep-3.1
```
