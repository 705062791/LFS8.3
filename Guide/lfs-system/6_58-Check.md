```bash
cd /sources &&
tar -zxvf check-0.12.0.tar.gz &&
cd check-0.12.0 &&

./configure --prefix=/usr &&
make && make install &&
sed -i '1 s/tools/usr/' /usr/bin/checkmk &&

cd /sources &&
rm -rf check-0.12.0 &&
echo "sucessful install check-0.12.0" && 
echo "---------------------"
```