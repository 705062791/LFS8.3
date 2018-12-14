```bash
cd /sources &&
tar -zxvf groff-1.22.3.tar.gz &&
cd groff-1.22.3 &&

PAGE=A4 ./configure --prefix=/usr &&
make -j1 && make install &&


cd /sources &&
rm -rf groff-1.22.3 &&
echo "sucessful install groff-1.22.3" && 
echo "---------------------"
```