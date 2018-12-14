```bash
cd /sources && 
tar -jxvf make-4.2.1.tar.bz2 &&
cd make-4.2.1 &&

sed -i '211,217 d; 219,229 d; 232 d' glob/glob.c &&
./configure --prefix=/usr &&
make && make install &&

cd /sources &&
rm -rf make-4.2.1 &&
echo "sucessful install make-4.2.1" && 
echo "---------------------"
```