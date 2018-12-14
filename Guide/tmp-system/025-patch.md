```bash
cd $LFS/sources 
[ -e patch-2.7.6 ] && rm -rf patch-2.7.6
tar xvf patch-2.7.6.tar.xz &&
cd patch-2.7.6 &&
./configure --prefix=/tools &&
make && make install &&
cd $LFS/sources &&
rm -rvf patch-2.7.6
```
