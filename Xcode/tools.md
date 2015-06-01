#工具使用
Xcode使用的llvm编译工具链，与gcc大致兼容，但还是有些差异。

```
xcode-select --install
```

Xcode工具路径: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin

平台路径
Applications/Xcode.app/Contents/Developer/Platforms/

疑惑：Xcode6.3默认工具链路径下的好像是macOS的，其它路径的工具都在各自平台下

##lldb
lldb是debug工具，对比gdb，刚试用发现真都不会用啊，怎么断点都不会设置了~~囧~~
lldb与gdb命令对比 http://lldb.llvm.org/lldb-gdb.html

##file
检查文件类型，以QQ为例：
```sh
$ file QQ
QQ: Mach-O executable i386
```

##otool
OSX版的ldd,用来查看链接了哪些库，例子：
```sh
$ otool -L QQ | head #显示MAC版QQ链接库前几个
QQ:
	/usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1213.0.0)
	/System/Library/Frameworks/CoreMedia.framework/Versions/A/CoreMedia (compatibility version 1.0.0, current version 1.0.0)
	/System/Library/Frameworks/AVFoundation.framework/Versions/A/AVFoundation (compatibility version 1.0.0, current version 2.0.0)
	/System/Library/Frameworks/Carbon.framework/Versions/A/Carbon (compatibility version 2.0.0, current version 157.0.0)
	@executable_path/../Frameworks/SCore.framework/Versions/A/SCore (compatibility version 1.0.0, current version 1.0.0)
	@executable_path/../Frameworks/xp_macosx.framework/Versions/A/xp_macosx (compatibility version 1.0.0, current version 1.0.0)
	/System/Library/Frameworks/Collaboration.framework/Versions/A/Collaboration (compatibility version 1.0.0, current version 71.0.0)
	@executable_path/../Frameworks/BugReport.framework/Versions/A/BugReport (compatibility version 1.0.0, current version 1.0.0)
	/System/Library/Frameworks/QuickLook.framework/Versions/A/QuickLook (compatibility version 1.0.0, current version 675.0.0)
```

```sh
$ otool -tV QQ | head #显示TEXT段
QQ:
(__TEXT,__text) section
-[ContactCell dealloc]:
00003890	pushl	%ebp
00003891	movl	%esp, %ebp
00003893	pushl	%edi
00003894	pushl	%esi
00003895	subl	$0x20, %esp
00003898	calll	0x389d
0000389d	popl	%esi
```

##nm
用来显示符号表,又是用QQ做例子：
```sh
$ nm -m QQ | head
001e9bf5 (__TEXT,__text) non-external +[AboutWindowController sharedAboutWindowController]
001f5966 (__TEXT,__text) non-external +[AddAContactController sharedAddAContactController]
001fe7ba (__TEXT,__text) non-external +[AddAGroupController sharedAddAGroupController]
00203cbb (__TEXT,__text) non-external +[AddBuddyController sharedAddBuddyController]
0051d1a3 (__TEXT,__text) non-external +[AnimationHelper moveView:from:to:]
0051cab3 (__TEXT,__text) non-external +[AnimationHelper moveView:from:to:delegate:]
0051cb3d (__TEXT,__text) non-external +[AnimationHelper moveView:from:to:fadeIn:fadeOut:delegate:]
0051cbc9 (__TEXT,__text) non-external +[AnimationHelper moveView:from:to:fadeIn:fadeOut:progressMark:duration:curve:delegate:]
0051c6b4 (__TEXT,__text) non-external +[AnimationHelper moveWindow:from:to:delegate:]
0051ceb2 (__TEXT,__text) non-external +[AnimationHelper moveWindow:from:to:fadeIn:delegate:]
```

##ROPgadget
用来检索程序中的ROP gadget，Python写的工具。安装
```sh
pip install capstone
pip install ropgadget
```
因为用的pyenv，装好有不要忘记 `pyenv rehash`,例子又是QQ `ROPgadget  --binary QQ`

xcodebuild http://www.infoq.com/cn/articles/build-ios-continuous-integration-platform-part1
