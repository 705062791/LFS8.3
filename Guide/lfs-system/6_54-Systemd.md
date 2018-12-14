```bash
cd /sources &&
tar -zxvf systemd-239.tar.gz &&
cd systemd-239 &&

ln -sf /tools/bin/true /usr/bin/xsltproc &&
tar -xf ../systemd-man-pages-239.tar.xz &&
sed '166,$ d' -i src/resolve/meson.build &&
patch -Np1 -i ../systemd-239-glibc_statx_fix-1.patch &&
sed -i 's/GROUP="render", //' rules/50-udev-default.rules.in &&
mkdir -p build &&
cd build &&
LANG=en_US.UTF-8 \
meson --prefix=/usr \
--sysconfdir=/etc \
--localstatedir=/var \
-Dblkid=true \
-Dbuildtype=release \
-Ddefault-dnssec=no \
-Dfirstboot=false \
-Dinstall-tests=false \
-Dkill-path=/bin/kill \
-Dkmod-path=/bin/kmod \
-Dldconfig=false \
-Dmount-path=/bin/mount \
-Drootprefix= \
-Drootlibdir=/lib \
-Dsplit-usr=true \
-Dsulogin-path=/sbin/sulogin \
-Dsysusers=false \
-Dumount-path=/bin/umount \
-Db_lto=false \
.. 
LANG=en_US.UTF-8 ninja &&
LANG=en_US.UTF-8 ninja install &&
rm -rfv /usr/lib/rpm &&
rm -f /usr/bin/xsltproc &&
systemd-machine-id-setup &&
cat > /lib/systemd/systemd-user-sessions << "EOF"
#!/bin/bash
rm -f /run/nologin
EOF
chmod 755 /lib/systemd/systemd-user-sessions &&

cd /sources &&
rm -rf systemd-239 &&
echo "sucessful install systemd-239" && 
echo "---------------------"
```