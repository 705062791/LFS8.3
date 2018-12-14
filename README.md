# LFS8.3
环境: VM虚拟机 + ubuntu16.04(桌面版) + LFS8.3
## 目录
#### 1.[准备宿主系统](Guide/001-prepare-host-system.md)
#### 2.[编译临时系统](Guide/002-prepare-tmp-system.md)
#### 3.[创建LFS系统](Guide/003-build-lfs-system.md)
#### 4.[配置LFS系统](Guide/004-configure-lfs-system.md)
#### 5.[让LFS系统可引导](Guide/005-make-bootable-lfs-system.md)
#### 5.[最后设置并重启](Guide/006-final-setting.md)

## 备注
#### 1. 虚拟机的快照要多使用, 出现问题/误操作时可以直接回滚!
我因为不小心rm一个文件夹, 然后安装东西就一直报错, 又没有使用快照,只能老实重头来

## 参考链接:
* [./configure->make->make install - 简书](https://www.jianshu.com/p/c70afbbf5172)
* [64 位软件和 32 位有什么具体区别？ - csdn_chai的博客 - CSDN博客](https://blog.csdn.net/csdn_chai/article/details/77966056)
* [linux 源码编译安装软件包./configure 详解 - Coohx - CSDN博客](https://blog.csdn.net/Cooling88/article/details/51057814)
* [什么是交叉编译 - whatday的专栏 - CSDN博客](https://blog.csdn.net/whatday/article/details/73930604)
* [mount --bind与硬连接 - wo_wuhao - CSDN博客](https://blog.csdn.net/wukery/article/details/79401465)
* [理解 chroot](https://www.ibm.com/developerworks/cn/linux/l-cn-chroot/index.html)

