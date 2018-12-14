```bash
cd /sources &&
tar xvJf gawk-4.2.1.tar.xz &&
cd gawk-4.2.1 &&
sed -i 's/extras//' Makefile.in &&
./configure --prefix=/usr &&
make && make install &&
./configure --prefix=/usr &&
mkdir -v /usr/share/doc/gawk-4.2.1 &&
cp -v doc/{awkforai.txt,*.{eps,pdf,jpg}} /usr/share/doc/gawk-4.2.1 &&
cd /sources &&
rm -rf gawk-4.2.1 &&
echo "sucessful install gawk-4.2.1" && 
echo "---------------------"
```