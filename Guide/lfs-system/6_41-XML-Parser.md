```bash
cd /sources &&
tar -zxvf XML-Parser-2.44.tar.gz &&
cd XML-Parser-2.44 &&
perl Makefile.PL&&
make && make install &&
cd /sources &&
rm -rf XML-Parser-2.44 &&
echo "sucessful install XML-Parser-2.44" && 
echo "---------------------"
```