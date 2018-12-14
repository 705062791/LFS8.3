# 编译临时系统
------------------------------------------------
#### *[[上一页](001-prepare-host-system.md)] [[下一页](003-build-lfs-system.md)]*
------------------------------------------------
### 1) 准备
*1.切换到lfs用户*
```bash
su - lfs
```
*2.检查LFS变量(输出应该是 /mnt/lfs )*
```bash
echo $LFS
```
### 2) 编译 <- 5.4~5.34
**想偷懒可以`wget https://raw.githubusercontent.com/Jefung/LFS8.3/master/Scripts/compile_tmp_sys.sh && bash compile_tmp_sys.sh`
一键安装, 不过不知道会不会出先问题,我自己没测试过,而且,脚本没进行`check`**

*SBU 时间单位，以编译binutils为一个单位*

*开头的数字对应`LFS8.3`PDF中的章节*

*有些软件可以多开终端, 都是用`lfs`来进行同步编译安装*
#### 5.4.[Binutils-2.31.1 - Pass 1](tmp-system/001-binutils-pass1.md)———1 SBU
#### 5.5.[GCC-8.2.0 - Pass 1](tmp-system/002-gcc-pass1.md)———14.3 SBU
#### 5.6.[Linux-4.18.5 API Headers](tmp-system/003-linux-header.md)———0.1 SBU(可以和1,2一起运行)
#### 5.7.[Glibc-2.28](tmp-system/004-glibc.md)———4.7 SBU(必须按照顺序来安装)
#### 5.8.[Libstdc++ from GCC-8.2.0](tmp-system/005-libstdc++.md)———0.5 SBU(必须按照顺序来安装)
#### 5.9.[Binutils-2.31.1 - Pass 2](tmp-system/006-binutils-paas2.md)———1.1 SBU(必须按照顺序来安装)
#### 5.10.[GCC-8.2.0 - Pass 2](tmp-system/007-gcc-pass2.md)———11 SBU(必须按照顺序来安装)
#### 5.11.[Tcl-8.6.8](tmp-system/008-tcl.md)———0.9 SBU
#### 5.12.[Expect-5.45.4](tmp-system/009-expect.md)———0.1 SBU
#### 5.13.[DejaGNU-1.6.1](tmp-system/010-dejagnu.md)——— <0.1 SBU
#### 5.14.[M4-1.4.18](tmp-system/011-m4.md)———0.2 SBU
#### 5.15.[Ncurses-6.1](tmp-system/012-ncurses.md)———0.6 SBU
#### 5.16.[Bash-4.4.18](tmp-system/013-bash.md)———0.4 SBU
#### 5.17.[Bison-3.0.5](tmp-system/014-bison.md)———0.3 SBU
#### 5.18.[Bzip2-1.0.6](tmp-system/015-bzip.md)——— <0.1 SBU
#### 5.19.[Coreutils-8.30](tmp-system/016-coreutils.md)———0.7 SBU
#### 5.20.[Diffutils-3.6](tmp-system/017-diffutils.md)———0.2 SBU
#### 5.21.[File-5.34](tmp-system/018-file.md)———0.1 SBU
#### 5.22.[Findutils-4.6.0](tmp-system/019-findutils.md)———0.3 SBU
#### 5.23.[Gawk-4.2.1](tmp-system/020-gawk.md)———0.2 SBU
#### 5.24.[Gettext-0.19.8.1](tmp-system/021-gettext.md)———0.9 SBU
#### 5.25.[Grep-3.1](tmp-system/022-grep.md)———0.2 SBU
#### 5.26.[Gzip-1.9](tmp-system/023-gzip.md)———0.1 SBU
#### 5.27.[Make-4.2.1](tmp-system/024-make.md)———0.1 SBU
#### 5.28.[Patch-2.7.6](tmp-system/025-patch.md)———0.2 SBU
#### 5.29.[Perl-5.28.0](tmp-system/026-perl.md)———1.5 SBU
#### 5.30.[Sed-4.5](tmp-system/027-sed.md)———0.2 SBU
#### 5.31.[Tar-1.30](tmp-system/028-tar.md)———0.4 SBU
#### 5.32.[Texinfo-6.5](tmp-system/029-texinfo.md)———0.2 SBU
#### 5.33.[Util-linux-2.32.1](tmp-system/030-util.md)———1 SBU
#### 5.34.[Xz-5.2.4](tmp-system/031-xz.md)———0.2 SBU

### 3) 清理无用内容(可跳过) <- 5.35
```bash
cd $LFS
strip --strip-debug /tools/lib/*
/usr/bin/strip --strip-unneeded /tools/{,s}bin/*
rm -rf /tools/{,share}/{info,man,doc}
find /tools/{lib,libexec} -name \*.la -delete
```
### 4) 更改工具链属组（root用户下执行）<- 5.36
1. 切换`root`: `su root`
2. 将 $LFS/tools 目录的属主改为 root 用户: `chown -R root:root $LFS/tools`
------------------------------------------------
*[[上一页](001-prepare-host-system.md)]  [[下一页](003-build-lfs-system.md)]
