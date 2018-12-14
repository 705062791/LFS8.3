```bash
cd /sources &&
tar xvJf inetutils-1.9.4.tar.xz &&
cd inetutils-1.9.4 &&
./configure --prefix=/usr \
--localstatedir=/var \
--disable-logger \
--disable-whois \
--disable-rcp \
--disable-rexec \
--disable-rlogin \
--disable-rsh \
--disable-servers &&

make && make install &&
mv -v /usr/bin/{hostname,ping,ping6,traceroute} /bin &&
mv -v /usr/bin/ifconfig /sbin &&
cd /sources &&
rm -rf inetutils-1.9.4 &&
echo "sucessful install inetutils-1.9.4" && 
echo "---------------------"
```