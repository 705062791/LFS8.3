```bash
cd $LFS/sources 
[ -e file-5.34 ] && rm -rf file-5.34
tar zxvf file-5.34.tar.gz &&
cd file-5.34 &&
./configure --prefix=/tools &&
make && make install &&
cd $LFS/sources &&
rm -rvf file-5.34
```
