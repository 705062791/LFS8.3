```bash
cd /sources &&
tar xvJf libtool-2.4.6.tar.xz &&
cd libtool-2.4.6 &&
./configure --prefix=/usr &&
make && make install &&
cd /sources &&
rm -rf libtool-2.4.6 &&
echo "sucessful install libtool-2.4.6" && 
echo "---------------------"
```