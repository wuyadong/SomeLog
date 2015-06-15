# mac记录

## 修改应用plist
从OSX 10.9开始，应用的plist的读写都是通过操作系统的代理来实现 - cfprefsd，因此如果直接对文件修改是无效的，因为cfprefsd有缓存。因此需要需要修改前需要将cfprefsd停掉。

另外因为OSX的Cache机制，~/Library/Caches 中有应用的缓存，因此需要也需要将里面对应的删除掉。

