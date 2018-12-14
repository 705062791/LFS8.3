```bash
cd $LFS/sources 
[ -e diffutils-3.6 ] && rm -rf diffutils-3.6
tar xvf diffutils-3.6.tar.xz &&
cd diffutils-3.6 &&
./configure --prefix=/tools &&
make && make install &&
cd $LFS/sources &&
rm -rvf diffutils-3.6
```
