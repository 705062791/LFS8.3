```bash
cd /sources &&
tar -jxvf expat-2.2.6.tar.bz2 &&
cd expat-2.2.6 &&
sed -i 's|usr/bin/env |bin/|' run.sh.in &&
./configure --prefix=/usr \
--disable-static \
--docdir=/usr/share/doc/expat-2.2.6 &&
make && make install &&
install -v -m644 doc/*.{html,png,css} /usr/share/doc/expat-2.2.6 &&
cd /sources &&
rm -rf expat-2.2.6 &&
echo "sucessful install expat-2.2.6" && 
echo "---------------------"
```