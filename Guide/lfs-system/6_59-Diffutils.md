```bash
cd /sources &&
tar xvJf diffutils-3.6.tar.xz &&
cd diffutils-3.6 &&

./configure --prefix=/usr &&
make && make install &&


cd /sources &&
rm -rf diffutils-3.6 &&
echo "sucessful install diffutils-3.6" && 
echo "---------------------"
```