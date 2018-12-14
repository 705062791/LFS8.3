```bash
cd $LFS/sources 
[ -e perl-5.28.0 ] && rm -rf perl-5.28.0
tar xvf perl-5.28.0.tar.xz &&
cd perl-5.28.0 &&
sh Configure -des -Dprefix=/tools -Dlibs=-lm -Uloclibpth -Ulocincpth &&
make &&
cp -v perl cpan/podlators/scripts/pod2man /tools/bin &&
mkdir -pv /tools/lib/perl5/5.28.0 &&
cp -Rv lib/* /tools/lib/perl5/5.28.0 &&
cd $LFS/sources &&
rm -rvf perl-5.28.0
```
