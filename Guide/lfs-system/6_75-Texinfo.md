```bash
cd /sources &&
tar xvJf texinfo-6.5.tar.xz &&
cd texinfo-6.5 &&

sed -i '5481,5485 s/({/(\\{/' tp/Texinfo/Parser.pm &&
./configure --prefix=/usr --disable-static &&
make && make install &&
make TEXMF=/usr/share/texmf install-tex &&



cd /sources &&
rm -rf texinfo-6.5 &&
echo "sucessful install texinfo-6.5" && 
echo "---------------------"
```