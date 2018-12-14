```bash
cd $LFS/sources 
[ -e util-linux-2.32.1 ] && rm -rf util-linux-2.32.1
tar xvf util-linux-2.32.1.tar.xz &&
cd util-linux-2.32.1 &&
./configure --prefix=/tools                \
            --without-python               \
            --disable-makeinstall-chown    \
            --without-systemdsystemunitdir \
            --without-ncurses              \
            PKG_CONFIG="" &&
make && make install &&
cd $LFS/sources &&
rm -rvf util-linux-2.32.1
```
