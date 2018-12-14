```bash
cd $LFS/sources 
[ -e coreutils-8.30 ] && rm -rf coreutils-8.30
tar xvf coreutils-8.30.tar.xz &&
cd coreutils-8.30 &&
./configure --prefix=/tools --enable-install-program=hostname &&
make && make install &&
cd $LFS/sources &&
rm -rvf coreutils-8.30
```
