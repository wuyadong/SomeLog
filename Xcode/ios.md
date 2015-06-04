# ios


###iOS程序启动过程分析
使用Xcode模板创建空白iOS应用，在Supporting Files目录中会有main.m，里面包含了main函数，obj-c是C的超集，启动入口和C是一样的，标准的ansi C方式。

```obj-c
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
```
所以重点是UIApplicationMain函数，可以看到定义在UIKit/UIApplication.h中。
- 前两个参数是程序启动入参，没差。
- principalClassName：指定应用程序类，该类必须是UIApplication(或子类)。如果为nil,则用UIApplication类作为默认值
- delegateClassName：指定应用程序类的代理类，该类必须遵守UIApplicationDelegate协议
```
// If nil is specified for principalClassName, the value for NSPrincipalClass from the Info.plist is used. If there is no
// NSPrincipalClass key specified, the UIApplication class is used. The delegate class will be instantiated using init.
UIKIT_EXTERN int UIApplicationMain(int argc, char *argv[], NSString *principalClassName, NSString *delegateClassName);
```

UIApplication对象整个程序中有且只有一个，单例，通过`[UIApplication sharedApplication]`可以获取。启动UIApplication时，启动起delegate对象，默认生成是AppDelegate，其被委托了多个系统消息，模板中已经生成了接口，只需要实现即可。AppDelegate中有属性`@property (strong, nonatomic) UIWindow *window;` ，创建UIWindow,设置rootViewController，显示窗口。


使用模拟器启动程序后，利用活动监视器取样应用，或者利用调试窗口lldb可以查看调用栈信息。从中可以看到启动的顺序，如下。启动了3个线程：
- 从名字来看，主线程启动了一个循环等待消息触发动作.源码
http://www.opensource.apple.com/source/xnu/xnu-1456.1.26/libsyscall/mach/mach_msg.c http://www.opensource.apple.com/source/xnu/xnu-1456.1.26/osfmk/ipc/mach_msg.c

- 第二个线程应该是消息分发,kevent64是kqueue内核事件通知机制，有很多资料可以。详细查看，_dispatch_mgr_thread可以查看apple的[源码](http://www.opensource.apple.com/source/libdispatch/libdispatch-442.1.4/src/source.c)，_dispatch_mgr_invoke是一个循环，用来处理kevent，_dispatch_mgr_invoke -> _dispatch_kevent_drain -> _dispatch_kevent_mach_portset
- 第三个线程没有明白是干嘛的，看起来处于工作队列等待状态

```
2651 Thread_395035   DispatchQueue_1: com.apple.main-thread  (serial)
+ 2651 start  (in libdyld.dylib) + 1  [0x2c96ac9]
+   2651 main  (in ToDoList) + 138  [0xaf3ba]  main.m:14
+     2651 UIApplicationMain  (in UIKit) + 1526  [0xcc9106]
+       2651 GSEventRun  (in GraphicsServices) + 104  [0x3b70106]
+         2651 GSEventRunModal  (in GraphicsServices) + 192  [0x3b702c9]
+           2651 CFRunLoopRunInMode  (in CoreFoundation) + 123  [0x82088b]
+             2651 CFRunLoopRunSpecific  (in CoreFoundation) + 443  [0x820a5b]
+               2651 __CFRunLoopRun  (in CoreFoundation) + 1400  [0x821298]
+                 2651 __CFRunLoopServiceMachPort  (in CoreFoundation) + 214  [0x821eb6]
+                   2651 mach_msg  (in libsystem_kernel.dylib) + 68  [0x2f7ca70]
+                     2651 mach_msg_trap  (in libsystem_kernel.dylib) + 10  [0x2f7d9ce]
2651 Thread_395378   DispatchQueue_2: com.apple.libdispatch-manager  (serial)
+ 2651 _dispatch_mgr_thread  (in libdispatch.dylib) + 60  [0x2c58e48]
+   2651 _dispatch_mgr_invoke  (in libdispatch.dylib) + 245  [0x2c590f0]
+     2651 kevent64  (in libsystem_kernel.dylib) + 10  [0x2f848ce]
2651 Thread_399070
  2651 start_wqthread  (in libsystem_pthread.dylib) + 30  [0x2fade2e]
    2651 _pthread_wqthread  (in libsystem_pthread.dylib) + 939  [0x2fb02b1]
      2651 __workq_kernreturn  (in libsystem_kernel.dylib) + 10  [0x2f83e6a]
```

上面是自己的一些分析。苹果的文档讲的非常清楚：

参考文档:
- http://stackoverflow.com/questions/17366107/what-is-the-launch-sequence-of-an-ios-app
- https://developer.apple.com/library/ios/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/StrategiesforHandlingAppStateTransitions/StrategiesforHandlingAppStateTransitions.html
- https://developer.apple.com/library/ios/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/TheAppLifeCycle/TheAppLifeCycle.html

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



### 记录
introspection 内省的主要用途有两个：
1. 数组中获取变量
2. MVC中盲通信，如委托、目标动作等

NSlog中%@替代的是description调用 - [obj description]

属性列表 - property list --没有弄明白
