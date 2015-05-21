# ios


Layers of iOS


### obj-c中self. 与 _ 差别
obj-c 类中访问类变量有两种方式，写代码时候发现两者是有差别的：

1. self.xxx  通过setter/getter方法访问
2. \_xxx  直接访问变量
```obj-c
if (self.cards.firstObject) //self
if (_firstObject) //_
```
对应汇编比较
![汇编对比](./self_diff.tiff)

可以明确看出，使用self时 `calll	L_objc_msgSend$stub`。从效果来说，在默认情况下，这两者没有差别，但是如果有覆盖getter/setter方法时，下划线\_ 方式就可能出错了。因此应该尽量使用self来访问，除了init, getter/setter等方法，避免后续代码修改时出现错误。
