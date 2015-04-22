#Python日志

##centos 安装python3
stackoverflow -- http://stackoverflow.com/questions/8087184/installing-python3-on-rhel
命令行:
sudo yum install http://dl.iuscommunity.org/pub/ius/stable/CentOS/7/x86_64/ius-release-1.0-13.ius.centos7.noarch.rpm
sudo yum search python3
sudo yum install python34


##MacOS 10.10.3 安装anaconda
1. 安装homebrew
https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Installation.md
不知道为何homebrew的主页打不开，用了手动方式进行安装
我是安装在 ~/apps/homebrew
'
cd ~/apps
mkdir homebrew && curl -L https://github.com/Homebrew/homebrew/tarball/master | tar xz --strip 1 -C homebrew
'
软链接到/usr/local/bin目录下（ln -s /Users/xxx/apps/homebrew/bin/brew brew），我本机上默认没有/usr/local目录，还挺奇怪～～
手动建立目录，并将其owner切换为自己的账户，这样就不用老是sudo了

2. 安装pyenv
见 https://github.com/yyuu/pyenv#homebrew-on-mac-os-x

3. 安装Anaconda
pyenv install anaconda... 选择合适版本

