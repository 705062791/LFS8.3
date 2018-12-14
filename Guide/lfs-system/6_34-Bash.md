```bash
cd /sources &&
tar -zxvf bash-4.4.18.tar.gz &&
cd bash-4.4.18 &&
./configure --prefix=/usr \
--docdir=/usr/share/doc/bash-4.4.18 \
--without-bash-malloc \
--with-installed-readline &&

make && make install &&
mv -vf /usr/bin/bash /bin &&
exec /bin/bash --login +h &&
cd /sources &&
rm -rf bash-4.4.18 &&
echo "sucessful install bash-4.4.18" && 
echo "---------------------"
```