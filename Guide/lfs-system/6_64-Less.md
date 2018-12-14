```bash
cd /sources &&
tar -zxvf less-530.tar.gz &&
cd less-530 &&

./configure --prefix=/usr --sysconfdir=/etc &&
make && make install &&


cd /sources &&
rm -rf less-530 &&
echo "sucessful install less-530" && 
echo "---------------------"
```