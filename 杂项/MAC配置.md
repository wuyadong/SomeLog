# MAC配置

-----

##参考
gitbook [Mac 开发配置手册](http://aaaaaashu.gitbooks.io/mac-dev-setup/content/)

包括：

- 系统配置
- XCode
- [HomeCrew](http://aaaaaashu.gitbooks.io/mac-dev-setup/content/Homebrew/README.html)
- [iTerm2](http://aaaaaashu.gitbooks.io/mac-dev-setup/content/iTerm/README.html) 可以直接 brew cask install iterm2
- [GIT](http://aaaaaashu.gitbooks.io/mac-dev-setup/content/Git/README.html)等

----
## 一些快捷键设置

没有触摸和苹果鼠标

1. 用随便快速开始Mission Control：
系统偏好设置 -> Mission Control -> Mission Control 用鼠标第4键；显示桌面 用鼠标第5键
2. 用屏幕角触发 Launchpad


## 开启NTFS读写
网上可以搜到各种[方法](http://www.readern.com/ntfs-on-mac-os-x.html),还是觉得用原生的方式比较好，网上的说法很多有错误。记录下自己的实践。

###修改mount_ntfs
```
cd /System/Library/Filesystems/ntfs.fs/Contents/Resources
sudo mv mount_ntfs mount_ntfs.orig
sudo vim mount_ntfs
```
mount_ntfs内容:

```
#!/bin/sh
/System/Library/Filesystems/ntfs.fs/Contents/Resources/mount_ntfs.orig -o rw,nobrowse "$@"
```
注意：*nobrowse*是必须要的；否则挂载后还是只读，原因不明。
###删除原来的挂载点
```
cd /Volumes
diskutil list #看下硬盘信息
diskutil unmountDisk xxx #将NTFS磁盘卸载掉，如果是单个分区，用unmount命令逐个卸载
sudo rm -rf xxx #将/Volumes下原来的挂载点目录删掉，否则后续挂载会出错
```
重启系统
###将挂载目录放到Finder
因为上面使用了nobrowse参数，重启Finder会看不到，使用不方便
在Finder使用快捷键 shift+command+G 跳转到/Volumes，然后将需要用的目录拖到个人收藏即可


##唤醒后声音不正常
重新加载下驱动,写了个脚本

```
#!/bin/bash
sudo kextunload /System/Library/Extensions/AppleHDA.kext
sudo kextload /System/Library/Extensions/AppleHDA.kext
```