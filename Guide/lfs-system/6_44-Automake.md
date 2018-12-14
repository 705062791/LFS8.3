```bash
cd /sources &&
tar xvJf automake-1.16.1.tar.xz &&
cd automake-1.16.1 &&

./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.16.1 &&

make && make install &&
cd /sources &&
rm -rf automake-1.16.1 &&
echo "sucessful install automake-1.16.1" && 
echo "---------------------"
```