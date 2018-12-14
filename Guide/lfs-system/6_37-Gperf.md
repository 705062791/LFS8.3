```bash
cd /sources &&
tar -zxvf gperf-3.1.tar.gz &&
cd gperf-3.1 &&
./configure --prefix=/usr --docdir=/usr/share/doc/gperf-3.1 &&
make && make install &&
cd /sources &&
rm -rf gperf-3.1 &&
echo "sucessful install gperf-3.1" && 
echo "---------------------"
```