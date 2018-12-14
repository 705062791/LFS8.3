```bash
cd /sources &&
tar -jxvf iana-etc-2.30.tar.bz2 &&
cd iana-etc-2.30 &&

make && make install

cd /sources &&
rm -rf iana-etc-2.30 &&
echo "sucessful install iana-etc-2.30" && 
echo "---------------------"
```