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

/usr/local/include 路径没有包含在系统路径中：http://superuser.com/questions/894958/mac-os-x-xcode-libraries

## BASH
```
# Set COLOR
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad
# export PS1="\[\033[38;5;11m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\h:\[$(tput sgr0)\]\[\033[38;5;14m\]\W\[$(tput sgr0)\]\[\033[38;5;15m\]\\$ \[$(tput sgr0)\]"

alias ls='ls -GF'
alias ll='ls -l'
alias la='ls -a'
```

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

## docker

```sh
brew install docker docker-compose docker-machine

# https://github.com/zchee/docker-machine-driver-xhyve
brew install docker-machine-driver-xhyve
# docker-machine-driver-xhyve need root owner and uid
sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve

# create deault
docker-machine create --driver xhyve default
```

```sh
# To have launchd start docker-machine now and restart at login:
  brew services start docker-machine
# Or, if you don't want/need a background service you can just run:
  docker-machine start
```

使用官方下载安装
```
wget -c https://download.docker.com/mac/stable/Docker.dmg
```

安装 shell completion

```
ln -s /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion /usr/local/etc/bash_completion.d/docker
ln -s /Applications/Docker.app/Contents/Resources/etc/docker-machine.bash-completion /usr/local/etc/bash_completion.d/docker-machine
ln -s /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion /usr/local/etc/bash_completion.d/docker-compose

ln -s /Applications/Docker.app/Contents/Resources/etc/docker.zsh-completion /usr/local/share/zsh-completions/_docker
ln -s /Applications/Docker.app/Contents/Resources/etc/docker-machine.zsh-completion /usr/local/share/zsh-completions/_docker-machine
ln -s /Applications/Docker.app/Contents/Resources/etc/docker-compose.zsh-completion /usr/local/share/zsh-completions/_docker-compose

```

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

macos下netstat只能显示被占用的端口号，不过可以在通过lsof -i：端口号


mongod --config /usr/local/etc/mongod.conf

### redis
通过homebrew安装redis,因为安装了anaconda，里面自带redis，但是版本比较老，将其移除

```sh
conda remove redis  # 移除
rm ~/.pyenv/shime/redis* #conda 移除redis时，pyenv中没有正确移除，手动移除 
brew install redis  # 安装
redis-server /usr/local/etc/redis.conf
```
