```bash
cd /sources &&
tar -zxvf openssl-1.1.0i.tar.gz &&
cd openssl-1.1.0i &&
./config --prefix=/usr \
--openssldir=/etc/ssl \
--libdir=lib \
shared \
zlib-dynamic &&
make &&
sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile &&
make MANSUFFIX=ssl install &&
cd /sources &&
rm -rf openssl-1.1.0i &&

echo "sucessful install openssl-1.1.0i" && 
echo "---------------------"
```