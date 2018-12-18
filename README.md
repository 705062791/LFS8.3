# LFS8.3
环境: VM虚拟机 + ubuntu16.04(桌面版) + LFS8.3

## 备注
#### 1. 虚拟机的快照要多使用, 出现问题/误操作时可以直接回滚!
我因为不小心rm一个文件夹, 然后安装东西就一直报错, 又没有使用快照,只能老实重头来.

我自己用的是`VMware Workstation Pro 14`, 是带有快照的, 有同学说他的vm没有, 那可能得换一个版本了

#### 2. 我自己没写什么具体教程, 大多是照着 [LFS-PDF-Version 8.3-systemd](https://lctt.github.io/LFS-BOOK/lfs-systemd/LFS-SYSD-BOOK.pdf)来的
具体操作不懂或者不会是直接搜索引擎查找资料,我把我用到的文章链接均补充进来, 你要是不懂操作, 先看文章链接教程, 弄懂大致原理, 具体步骤是干啥的
(ps:你的系统不一定会和博客中介绍的环境不一样, 可能会有点不一样, 所以更多的是理解吧

#### 3. 补充了答辩的ppt, ppt内容更多是整理下思路, 自己画流程图

## 目录
#### 1.[准备宿主系统](Guide/001-prepare-host-system.md)
#### 2.[编译临时系统](Guide/002-prepare-tmp-system.md)
#### 3.[创建LFS系统](Guide/003-build-lfs-system.md)
#### 4.[配置LFS系统](Guide/004-configure-lfs-system.md)
#### 5.[让LFS系统可引导](Guide/005-make-bootable-lfs-system.md)
#### 5.[最后设置并重启](Guide/006-final-setting.md)



## 参考链接:
* [./configure->make->make install - 简书](https://www.jianshu.com/p/c70afbbf5172)
* [64 位软件和 32 位有什么具体区别？ - csdn_chai的博客 - CSDN博客](https://blog.csdn.net/csdn_chai/article/details/77966056)
* [linux 源码编译安装软件包./configure 详解 - Coohx - CSDN博客](https://blog.csdn.net/Cooling88/article/details/51057814)
* [什么是交叉编译 - whatday的专栏 - CSDN博客](https://blog.csdn.net/whatday/article/details/73930604)
* [mount --bind与硬连接 - wo_wuhao - CSDN博客](https://blog.csdn.net/wukery/article/details/79401465)
* [理解 chroot](https://www.ibm.com/developerworks/cn/linux/l-cn-chroot/index.html)

