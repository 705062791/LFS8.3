# 部分 III. 构建 LFS 系统: 第 8 章 The End
---------------------------------------------
#### *[[上一页](005-make-bootable-lfs-system.md)] [[首页](/README.md)]*
-----------------------------------------------------------
## 1. 创建系统所需文件
* 创建一个 systemd 所需的 /etc/os-release 文件
```bash
cat > /etc/os-release << "EOF"
NAME="Linux From Scratch"
VERSION="8.3-systemd"
ID=lfs
PRETTY_NAME="Linux From Scratch 8.3-systemd"
VERSION_CODENAME="Jefung"
EOF
```

* 推荐遵守 Linux Standards Base (LSB)，建立文件以显示当前系统的完整信息:
```bash
cat > /etc/lsb-release << "EOF"
DISTRIB_ID="Linux From Scratch"
DISTRIB_RELEASE="8.3-systemd"
DISTRIB_CODENAME="Jefung"
 DISTRIB_DESCRIPTION="Linux From Scratch"
EOF
```
## 2. 重启系统
* 检查配置文件是否正确:
```
/etc/bashrc
/etc/dircolors
/etc/fstab
/etc/hosts
/etc/inputrc
/etc/profile
/etc/resolv.conf
/etc/vimrc
/root/.bash_profile
/root/.bashrc
```
* 退出`chroot`,卸载文件系统,重启

卸载`$LFS`可能会显示`umount: /mnt/lfs: device is busy`, 没关系, 直接重启
```
logout
umount -v $LFS/dev/pts
umount -v $LFS/dev
umount -v $LFS/run
umount -v $LFS/proc
umount -v $LFS/sys
umount -v $LFS
umount -v $LFS/usr
umount -v $LFS/home
umount -v $LFS
shutdown -r now
```
## 3. 效果图
![lsf8_3_screenshot.png](http://images.jefung.cn/lsf8_3_screenshot.png)
