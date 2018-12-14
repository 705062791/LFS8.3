```bash
cd $LFS/sources 
[ -e bash-4.4.18 ] && rm -rf bash-4.4.18
tar zxvf bash-4.4.18.tar.gz &&
cd bash-4.4.18 &&
./configure --prefix=/tools --without-bash-malloc &&
make && make install &&
ln -sv bash /tools/bin/sh &&
cd $LFS/sources &&
rm -rf bash-4.4.18
```
