*libstdc++是gcc的一部分*
```bash
cd $LFS/sources 
[ -e gcc-8.2.0 ] && rm -rf gcc-8.2.0
tar xvf gcc-8.2.0.tar.xz &&
cd gcc-8.2.0 &&
mkdir -v build &&
cd       build &&
../libstdc++-v3/configure           \
    --host=$LFS_TGT                 \
    --prefix=/tools                 \
    --disable-multilib              \
    --disable-nls                   \
    --disable-libstdcxx-threads     \
    --disable-libstdcxx-pch         \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/8.2.0 &&
make &&
make install &&
cd $LFS/sources &&
rm -rf gcc-8.2.0 &&
echo "sucessful install gcc-8.2.0" &&
echo "---------------------------------"
```
