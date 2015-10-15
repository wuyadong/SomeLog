#vim使用

##安装
Mac自带的vim版本比较老，用homebrew更新下
```sh
brew install macvim                              #gui版本vim; mvim/gvim
brew install vim                                 #command版本vim
sudo mv /usr/bin/vim /usr/bin/vim73     #将原版vim备份
```

我现在还是喜欢用自带的，brew 安装的版本估计是配置原因吧，使用起来总是乖乖的。

##16进制方式编辑文件
1.首先以二进制方式编辑这个文件  
vi -b datafile

2.使用xxd转换为16进制  
:%!xxd

文本看起来像这样:

        0000000: 1f8b 0808 39d7 173b 0203 7474 002b 4e49  ....9..;..tt.+NI
        0000010: 4b2c 8660 eb9c ecac c462 eb94 345e 2e30  K,.`.....b..4^.0
        0000020: 373b 2731 0b22 0ca6 c1a2 d669 1035 39d9  7;'1.".....i.59.

现在你可以随心所欲地阅读和编辑这些文本了。 Vim 把这些信息当作普通文本来对待。

3.转换16进制回来vi  
:%!xxd -r
