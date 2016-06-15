# iOS 学习纪要

## view
来自 斯坦福 iOS9 4

View -- rectangular area

### 层次
一个 superview `var superview: UIView`

0或多个 subview `var subview: [UIView]`

### 构建
通常使用 Xcode 布局

也可以使用代码, 如:
```
addSubview(aView: UIView)
removeFromSuperview()
```

界面旋转时布局微改变，Xcode中布局的会 automatically hooked up


### 初始化

view 初始化有个 init 方法，一个用于storyboard，一个用户代码，
建议采用如下方式初始化。

```swift

func setup() { ... }
override init(frame: CGRect) { // a designed initializer      super.init(frame: frame)setup()}
requiredinit(coderaDecoder:NSCoder){ //arequiredinitializer      super.init(coder: aDecoder)setup()

``` 

还有一个初始化 `awakeFromNic`, 被唤醒时系统自带调用，无法手动触发

### CGFloat
绘制界面 API 使用的数据类型，`let cfg = CGFloat(aDouble)`， 可以使用 Double 或 Float 数据类型转换，但是不能直接使用。

### CGPoint
` CGPoint(x: CGFloat, y: CGFloat) `

### CGSize
` CGSize(width: CGFloat, height:CGFloat)`

### CGRect
```
struct CGRect {       var origin: CGPoint       var size: CGSize   }
```

### View 坐标系统
原点在左上，这个基本上所有系统都一样的，包括Windows等

坐标的单位是 point 而不是 pixels(这就是为何OS X 和 iOS的应用在不同分辨率设备上能保证一致的界面，不像Windows在高分屏上很怪异。) 现在的iOS应该都是 3个像素一个点

``` bounds: CGRect ``` 边界是矩形，view内部绘制

```
var center: CGPoint // the center of a UIView in its superview’s coordinate systemvar frame: CGRect // the rect containing a UIView in its superview’s coordinate system

中心和框架都是指 superview 坐标系统而言
```

### 代码创建 View 
```
let labelRect = CGRect(x: 20, y: 20, width: 100, height: 50)let label = UILabel(frame: labelRect) // UILabel is a subclass of UIView label.text = “Hello”view.addSubview(label)
```

### 自定义 View
重载 drawRect

千万不要直接调用 drawRect , 要让系统管理 draw，使用如下接口
```
setNeedsDisplay() setNeedsDisplayInRect(regionThatNeedsToBeRedrawn: CGRect)
```

需要使用 path、 line、 color等，有点复杂，后面要练习来掌握


### UIColor
颜色设置使用 UIColor