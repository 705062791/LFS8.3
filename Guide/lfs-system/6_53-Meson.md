```bash
cd /sources &&
tar -zxvf meson-0.47.1.tar.gz &&
cd meson-0.47.1 &&

python3 setup.py build &&
python3 setup.py install --root=dest &&
cp -rv dest/* / &&


cd /sources &&
rm -rf meson-0.47.1 &&
echo "sucessful install meson-0.47.1" && 
echo "---------------------"
```