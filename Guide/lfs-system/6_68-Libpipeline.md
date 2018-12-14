```bash
cd /sources &&
tar -zxvf libpipeline-1.5.0.tar.gz &&
cd libpipeline-1.5.0 &&

./configure --prefix=/usr &&
make && make install &&


cd /sources &&
rm -rf libpipeline-1.5.0 &&
echo "sucessful install libpipeline-1.5.0" && 
echo "---------------------"
```