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

##HomeBrew
###安装homebrew
[github上安装说明](https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Installation.md),但是不知道为何homebrew的主页打不开，所以用了手动方式进行安装。

我是安装在 ~/apps/homebrew

```sh
cd ~/apps
mkdir homebrew && curl -L https://github.com/Homebrew/homebrew/tarball/master | tar xz --strip 1 -C homebrew
ln -s /Users/xxx/apps/homebrew/bin/brew /usr/local/bin/brew //软连接
```
软链接到/usr/local/bin目录下，我本机上默认没有/usr/local目录，还挺奇怪～～
手动建立目录，并将其owner切换为自己的账户，这样就不用老是sudo了
一些软件：
- jenv //java环境管理软件，汗啊这个软件有两个同名的，http://www.jenv.be/ 与 http://jenv.io/ 最近不用Java，不想尝试下，下次尝试下后面一个，看起来好用点。
- pyenv //python环境管理软件
- wget //命令行下载神器，一些脚本什么经常需要
###安装cask
cask用来安装管理GUI软件，不建议用，这个软件安装后不能在应用文件夹直接找到，不是特别方便。安装一些不太好下的软件挺好
```sh
$ brew install caskroom/cask/brew-cask
$ brew update && brew upgrade brew-cask && brew cleanup // 更新
```
一些软件：
- google-chrome // Google 浏览器
- unrar  //rar解压软件，国内你懂的
- keka //开源解压软件，底层是p7zip，支持的类型比较多

----
##gem国内源
https://ruby.taobao.org/
```sh
$ gem sources --remove https://rubygems.org/
$ gem sources -a https://ruby.taobao.org/
$ gem sources -l
*** CURRENT SOURCES ***

https://ruby.taobao.org
# 请确保只有 ruby.taobao.org
$ gem install rails
```
## 一些快捷键设置

没有触摸和苹果鼠标

1. 用随便快速开始Mission Control：
系统偏好设置 -> Mission Control -> Mission Control 用鼠标第4键；显示桌面 用鼠标第5键
2. 用屏幕角触发 Launchpad


## 开启NTFS读写
网上可以搜到各种[方法](http://www.readern.com/ntfs-on-mac-os-x.html),还是觉得用原生的方式比较好，网上的说法很多有错误。记录下自己的实践。

###修改mount_ntfs
```sh
cd /System/Library/Filesystems/ntfs.fs/Contents/Resources
sudo mv mount_ntfs mount_ntfs.orig
sudo vim mount_ntfs
```
mount_ntfs内容:

```sh
#!/bin/sh
/System/Library/Filesystems/ntfs.fs/Contents/Resources/mount_ntfs.orig -o rw,nobrowse "$@"
```
注意：*nobrowse*是必须要的；否则挂载后还是只读，原因不明。
###删除原来的挂载点
```sh
cd /Volumes
diskutil list #看下硬盘信息
diskutil unmountDisk xxx #将NTFS磁盘卸载掉，如果是单个分区，用unmount命令逐个卸载
sudo rm -rf xxx #将/Volumes下原来的挂载点目录删掉，否则后续挂载会出错
```
重启系统
###将挂载目录放到Finder
因为上面使用了nobrowse参数，重启Finder会看不到，使用不方便
在Finder使用快捷键 shift+command+G 跳转到/Volumes，然后将需要用的目录拖到个人收藏即可

-----

##唤醒后声音不正常
重新加载下驱动,写了个脚本；备注：这个应该是MAC操作系统的bug，网上看到很多案例，不知道何时修复

```sh
#!/bin/bash
sudo kextunload /System/Library/Extensions/AppleHDA.kext
sudo kextload /System/Library/Extensions/AppleHDA.kext
```

-----
##一些软件
1. rar解压：利用brew搜了下，发现有个unrar，brew install unrar，命令行挺好用，;-)
