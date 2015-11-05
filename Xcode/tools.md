#辅助工具

##simpholders
[主页](http://simpholders.com/)

mac平台上的ios开发辅助工具，可以帮助用户快速直接的访问iPhone模拟器应用的app文档.

##cocoapods
iOS第三方类库管理工具，[主页](https://cocoapods.org/),[中文安装](http://code4app.com/article/cocoapods-install-usage)

安装

```sh
sudo gem install cocoapods
```
gem源配置参考 [MAC配置](../杂项/MAC配置)

OS X 10.11开始，苹果把/usr/bin目录禁止操作了，包括root用户。因此会导致gem很多包无法安装，包括gem、ruby本身的更新。

目前的做法是用homebrew重现安装一个ruby，替代系统的。然后再安装cocoapods，如果有权限问题，先用gem更新下即可。也有好处，不再需要sudo了～

```sh
brew install ruby
gem update
gem install cocoapods
```
