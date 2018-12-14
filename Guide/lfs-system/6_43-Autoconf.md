```bash
cd /sources &&
tar xvJf autoconf-2.69.tar.xz &&
cd autoconf-2.69 &&
./configure --prefix=/usr && 
make && make install &&
cd /sources &&
rm -rf autoconf-2.69 &&
echo "sucessful install autoconf-2.69" && 
echo "---------------------"
```