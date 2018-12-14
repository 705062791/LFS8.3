# 部分 III. 构建 LFS 系统: 第 8 章 让 LFS 系统可引导
---------------------------------------------
#### *[[上一页](004-configure-lfs-system.md)] [[下一页](006-final-setting.md)]*
-----------------------------------------------------------
## 1. 创建 /etc/fstab 文件 <- 8.2
```bash
cat > /etc/fstab << "EOF"
# Begin /etc/fstab
# file system mount-point type options dump fsck
# order
/dev/<xxx> / <fff> defaults 1 1
/dev/<yyy> swap swap pri=1 0 0
# End /etc/fstab
EOF
```
<xxx>，<yyy> 和 <fff> 请使用适当的值替换。我自己的是 `sda3`，`sda4` 和 `ext4`.
ps: 我自己是用新划分`sda4`作为交换分区的, 如果你没有的话,可以用原来的`swap`分区

## 2. 安装内核 <- 8.3
* 解压并进入: `tar xvJf linux-4.18.5.tar.xz && cd linux-4.18.5`
* 保证内核干净: `make mrproper`
* 生成基本的配置文件(.config): `make defconfig`
* 修改配置文件(这里我参考PDF的,用`make menuconfig`去修改配置,但是直接在最后的reboot失败)

参考链接: [LFS：kernel panic VFS: Unable to mount root fs博客园](http://www.cnblogs.com/zhangjy6/p/5584210.html)
```bash
cat >> .config << EOF
CONFIG_FHANDLE=y
CONFIG_CGROUPS=y
CONFIG_SECCOMP=y
CONFIG_IPV6=y
CONFIG_DEVTMPFS=y
CONFIG_DMIID=y
ONFIG_INOTIFY_USER=y
CONFIG_AUTOFS4_FS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_FUSION=y
CONFIG_FUSION_SPI=y
CONFIG_FUSION_SAS=y
CONFIG_FUSION_MAX_SGE=y
CONFIG_FUSION_CTL=y
CONFIG_FUSION_LOGGING=y
CONFIG_VMWARE_BALLOON=y
CONFIG_VMWARE_PVSCSI=y
CONFIG_HYPERVISOR_GUEST=Y
EOF
```
* 编译: `make && make modules_install`
* 安装:
```
cp -iv arch/x86/boot/bzImage /boot/vmlinuz-4.18.5-lfs-8.3-systemd
cp -iv System.map /boot/System.map-4.18.5
cp -iv .config /boot/config-4.18.5
install -d /usr/share/doc/linux-4.18.5
cp -r Documentation/* /usr/share/doc/linux-4.18.5
```

* 配置 Linux 模块加载顺序
```bash
install -v -m755 -d /etc/modprobe.d
cat > /etc/modprobe.d/usb.conf << "EOF"
# Begin /etc/modprobe.d/usb.conf
install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true
# End /etc/modprobe.d/usb.conf
EOF
```
## 3. 使用 GRUB 设置启动过程 <- 8.4
* 将 GRUB 文件安装到 /boot/grub 然后设置启动扇区: `将 GRUB 文件安装到 /boot/grub 然后设置启动扇区`
* 创建 GRUB 配置文件:
```bash
cat > /boot/grub/grub.cfg << "EOF"
# Begin /boot/grub/grub.cfg
set default=0
set timeout=5
insmod ext2
set root=(hd0,2)
menuentry "GNU/Linux, Linux 4.18.5-lfs-8.3-systemd" {
linux /boot/vmlinuz-4.18.5-lfs-8.3-systemd root=/dev/sda2 ro
}
EOF
```

ps: 我的LFS在`sda3`, 所以修改`set root=(hd0,2)`为`set root=(hd0,3)`,
修改`root=/dev/sda2`为`root=/dev/sda3`

