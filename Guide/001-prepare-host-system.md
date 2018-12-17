# 准备宿主系统

ps:

对于标题`4、检查并安装必备软件 <- 2.2`, 其`<-`后面的数字为对应pdf第几章

---------------------------------------------
#### *[[上一页](/README.md)] [[下一页](002-prepare-tmp-system.md)]*
-----------------------------------------------------------
### 0) PFD下载
* [Linux From Scratch(简体中文版)-PDF-Version 8.3-systemd 下载](https://lctt.github.io/LFS-BOOK/lfs-systemd/LFS-SYSD-BOOK.pdf)
* 上面的PDF其实是来自 LFS Book 翻译项目: https://github.com/LCTT/LFS-BOOK


### 1) 下载Ubuntu系统
镜像下载:不一定要ubuntu16.04, 其它linux系统都可以, 只是我个人习惯使用ubuntu而已
* [ubuntu16.04桌面版](http://mirrors.aliyun.com/ubuntu-releases/16.04/ubuntu-16.04.5-desktop-amd64.iso):
这里我用的是桌面版, 但其实貌似没啥用, 安装无桌面的应该更好
* [ubuntu16.04服务器版/无桌面](http://mirrors.aliyun.com/ubuntu-releases/16.04/ubuntu-16.04.5-server-amd64.iso)

### 2) 下载vmware
自行百度, 我自己用的是14版本, 虚拟机所在盘一定要大, 每次保存快照非常耗磁盘容量.
因为我怕出现意外, 所以保存了很多快照, 最后没空间了.

### 3) 虚拟机安装系统
1. 虚拟机正常安装linux. PS: 分配20G空间,语言最好选择英文!, 后续出现错误直接把错误贴到某搜索引擎去搜更快解决问题
2. 安装 vmware-tools, 方便本机和虚拟机复制粘贴!你不会想手打那些又长又丑的命令行的!
* [VM Ubuntu16.04 安装Tools - CSDN博客](https://blog.csdn.net/Zlase/article/details/79625265)
,  我在安装时候没有找到`VMwareTools…tar.gz`文件,重启下就好了
* [Ubuntu 16.04下安装VMware Tools（三行命令搞定）](https://blog.csdn.net/luckypython/article/details/77917898)
,命令行安装参考链接, 个人没使用过

### 4) 检查并安装必备软件 <- 2.2
*脚本检查: [version-check.sh](../Scripts/version-check.sh))*
```bash
wget https://raw.githubusercontent.com/Jefung/LFS8.3/master/Scripts/version-check.sh
bash version-check.sh
```
*安装（以ubuntu16.04.1为例）*
```bash
apt-get install bison gawk g++ make texinfo
```

### 5) 创建分区系统, 格式化分区, 在分区上创建文件系统, 挂载分区 <- 2.4~2.7

ps: 请按照步骤一步一步来
1. VM给ubuntu增加硬盘容量并分区
* LFS8.3建议新分区容量为*20G*
* 你可能需要的参考链接: [Vmware添加磁盘的方法：扩展磁盘 - 知行合一 止于至善 - CSDN博客](https://blog.csdn.net/liumiaocn/article/details/78877957) (ps: 你只需要看到有类似sda3这样的新分区就可以进行下一步了, 链接文章后面部分可以跳过)
* 我在这里遇到一个问题:
![Image.png](http://images.jefung.cn/Image.png)
2. 格式化分区
* 参考链接: [linux 硬盘分区，分区，删除分区，格式化，挂载，卸载笔记](https://blog.csdn.net/openn/article/details/9856451)
3. 在分区上创建文件系统: `mkfs -v -t ext4 /dev/分区设备名(改为自己的分区)`
4. 挂载分区:
```bash
export LFS=/mnt/lfs 
mkdir -pv $LFS
mount -v -t ext4 /dev/分区设备名(改为自己的分区) $LFS
```

### 6) 下载并校验软件包 <- 3.*
1. 创建目录供下载软件存放:
```
mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources
```
2. 下载wget-list文件: `wget http://www.linuxfromscratch.org/lfs/downloads/stable-systemd/wget-list`
3. 利用wget-list进行批量下载(耐心等待): `wget --input-file=wget-list --continue --directory-prefix=$LFS/sources`

### 7) root用户创建编译工具链目录 <- 4.2
```bash
mkdir -v $LFS/tools
ln -sv $LFS/tools /
```
### 8) 添加编译用户配置（root权限太高，可能会损坏宿主机）<- 4.3~4.4
1. 增加`lfs`用户
```bash
groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs
```
2. 修改lfs用户密码*
```bash
passwd lfs
```
3. 修改`$LFS`目录的所有者
```bash
chown -v lfs $LFS/tools
chown -v lfs $LFS/sources
```
4. 切换到`lfs`用户，配置用户环境变量*
```bash
su - lfs

cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

cat > ~/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/tools/bin:/bin:/usr/bin
export LFS LC_ALL LFS_TGT PATH
EOF

source ~/.bash_profile
```
-----------------------------------------------------------
*[[上一页](/README.md)] [[下一页](002-prepare-tmp-system.md)]*
