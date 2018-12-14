# 创建LFS系统
------------------------------------------------
#### *[[上一页](002-prepare-tmp-system.md)] [[下一页](004-configure-lfs-system.md)]*
------------------------------------------------
## 部分 III. 构建 LFS 系统: 第 6 章 Installing Basic System Software
### 1. 准备虚拟内核文件系统 <- 6.2

切换用户:
```
su root
```

```bash
mkdir -pv $LFS/{dev,proc,sys,run} 
mknod -m 600 $LFS/dev/console c 5 1 
mknod -m 666 $LFS/dev/null c 1 3 
mount -v --bind /dev $LFS/dev
mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620 
mount -vt proc proc $LFS/proc 
mount -vt sysfs sysfs $LFS/sys 
mount -vt tmpfs tmpfs $LFS/run 

if [ -h $LFS/dev/shm ]; then
  mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi
```

### 2. 进入chroot环境 <- 6.4
```bash
chroot "$LFS" /tools/bin/env -i \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
    /tools/bin/bash --login +h
```
### 3. 创建目录和必要链接 <- 6.5-6.6
```bash
mkdir -pv /{bin,boot,etc/{opt,sysconfig},home,lib/firmware,mnt,opt}
mkdir -pv /{media/{floppy,cdrom},sbin,srv,var}
install -dv -m 0750 /root
install -dv -m 1777 /tmp /var/tmp
mkdir -pv /usr/{,local/}{bin,include,lib,sbin,src}
mkdir -pv /usr/{,local/}share/{color,dict,doc,info,locale,man}
mkdir -v  /usr/{,local/}share/{misc,terminfo,zoneinfo}
mkdir -v  /usr/libexec
mkdir -pv /usr/{,local/}share/man/man{1..8}

case $(uname -m) in
 x86_64) mkdir -v /lib64 ;;
esac

mkdir -v /var/{log,mail,spool}
ln -sv /run /var/run
ln -sv /run/lock /var/lock
mkdir -pv /var/{opt,cache,lib/{color,misc,locate},local}
```
### Creating Essential Files and Symlinks
```bash
ln -sv /tools/bin/{bash,cat,dd,echo,ln,pwd,rm,stty} /bin
ln -sv /tools/bin/{env,install,perl} /usr/bin
ln -sv /tools/lib/libgcc_s.so{,.1} /usr/lib
ln -sv /tools/lib/libstdc++.{a,so{,.6}} /usr/lib
for lib in blkid lzma mount uuid
do
    ln -sv /tools/lib/lib$lib.so* /usr/lib
done
ln -svf /tools/include/blkid    /usr/include
ln -svf /tools/include/libmount /usr/include
ln -svf /tools/include/uuid     /usr/include
install -vdm755 /usr/lib/pkgconfig
for pc in blkid mount uuid
do
    sed 's@tools@usr@g' /tools/lib/pkgconfig/${pc}.pc \
        > /usr/lib/pkgconfig/${pc}.pc
done
ln -sv bash /bin/sh

ln -sv /proc/self/mounts /etc/mtab
cat > /etc/passwd << "EOF"
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/dev/null:/bin/false
daemon:x:6:6:Daemon User:/dev/null:/bin/false
messagebus:x:18:18:D-Bus Message Daemon User:/var/run/dbus:/bin/false
nobody:x:99:99:Unprivileged User:/dev/null:/bin/false
EOF
cat > /etc/group << "EOF"
root:x:0:
bin:x:1:daemon
sys:x:2:
kmem:x:3:
tape:x:4:
tty:x:5:
daemon:x:6:
floppy:x:7:
disk:x:8:
lp:x:9:
dialout:x:10:
audio:x:11:
video:x:12:
utmp:x:13:
usb:x:14:
cdrom:x:15:
adm:x:16:
messagebus:x:18:
systemd-journal:x:23:
input:x:24:
mail:x:34:
nogroup:x:99:
users:x:999:
EOF
exec /tools/bin/bash --login +h
touch /var/log/{btmp,lastlog,faillog,wtmp}
chgrp -v utmp /var/log/lastlog
chmod -v 664  /var/log/lastlog
chmod -v 600  /var/log/btmp
```
### 4. 编译安装软件 <- 6.7 - 6.79
#### 6.7.[Linux-4.18.5 API Headers](lfs-system/001-linux-header.md)—— <0.1 SBU
#### 6.8.[Man-pages-4.16](lfs-system/002-man.md)—— <0.1 SBU
#### 6.9.[Glibc-2.28](lfs-system/003-glibc.md)—— 24 SBU
#### 6.10.[调整工具链](lfs-system/004-adjust-tool.md)
#### 6.11.[Zlib-1.2.11](lfs-system/005-zlib.md)—— <0.1 SBU
#### 6.12.[File-5.34](lfs-system/006-file.md)—— 0.1 SBU
#### 6.13.[Readline-7.0](lfs-system/007-readline.md)—— 0.1 SBU
#### 6.14.[M4-1.4.18](lfs-system/008-m4.md)—— 0.4 SBU
#### 6.15.[Bc-1.07.1](lfs-system/009-bc.md)—— 0.1 SBU
#### 6.16.[Binutils-2.31.1](lfs-system/010-binutils.md)—— 6.6 SBU
#### 6.17.[GMP-6.1.2](lfs-system/011-gmp.md)—— 1.3 SBU
#### 6.18.[MPFR-4.0.1](lfs-system/012-mpfr.md)—— 1.1 SBU
#### 6.19.[MPC-1.1.0](lfs-system/013-mpc.md)—— 0.3 SBU
#### 6.20.[Shadow-4.6](lfs-system/014-shadow.md)—— 0.2 SBU
#### 6.21.[GCC-8.2.0](lfs-system/015-gcc.md)—— 92 SBU
#### 6.22.[Bzip2-1.0.6](lfs-system/016-bzip2.md)—— <0.1 SBU
#### 6.23.[Pkg-config-0.29.2](lfs-system/017-pkgconfig.md)—— 0.4 SBU
#### 6.24.[Ncurses-6.1](lfs-system/018-ncurses.md)—— 0.4 SBU

#### 如果单纯安装软件到这里, 后续会找不到ls, 在6.57-Coreutils的安装包中
包含了包括`ls`的实用工具, 我本来想直接安装Coreutils的, 可是报错了, 于是又
按照顺序一个一个安装

#### 6.25.-6.76已经制作成脚本,几十个软件安装到想哭...*:
* 脚本使用前说明:

    * 脚本执行流程: *开始*->解压软件压缩包->进入压缩包->执行lfs中的命令->回到`$LFS/sources`目录
    -> 删除文件夹(非压缩包)->回到*开始*进行下一个安装

    * 所以,如果脚本出现问题了, 请查看你当前是在哪个文件夹下, 就是对应的软件安装出现问题

      处理思路: 查看当前文件夹, 确定是哪个软件出现问题, 回到`$LFS/sources`, 删除刚才
      的文件夹, 重新解压, 进入新的解压文件夹, 按照`LFS8.3 教程安装`, 安装后回到`$LFS/sources`,
      删除文件夹(非压缩包), 从脚本中那个安装出错的软件(你已经手动自己安装好了)的下一个开始, 复制到
      脚本最后, 粘贴到命令行运行

      ps: 然后在`issues`向我反馈, 谢谢

    * 脚本中多次出现`&&`, `&&`就是如果上一条命令出错了,不会执行下一条.

* 脚本使用:
    * 直接复制粘贴, 要是担心一起安装出错, 可以一段一段粘贴运行
    * 下载运行:
    ```
    wget 链接代填
    bash build_lfs_sys.sh
    ```

### 清理无用代码(可选, 见pdf)

------------------------------------------------
#### *[[上一页](002-prepare-tmp-system.md)] [[下一页](004-configure-lfs-system.md)]*
------------------------------------------------
