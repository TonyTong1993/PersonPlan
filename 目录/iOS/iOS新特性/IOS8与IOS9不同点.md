IOS8与IOS9不同点
====
##### 1.ATS变化
IOS9中为了加强为了强制增强数据访问安全，默认会把 HTTP 请求，都改为 HTTPS 请求，原来的HTTP协议传输都改成TLS1.2协议进行传输，直接造成的情况就是App发请求的时候弹出网络无法连接
##### 2.URLscheme
在iOS9中，如果使用URL scheme必须在"Info.plist"中将你要在外部调用的URL scheme列为白名单，否则不能使用。key叫做LSApplicationQueriesSchemes
##### 3.StatusBar
以前我们为了能够实时的控制顶部statusbar的样式，可能会在喜欢使用

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
但是这么做之前需要将 info.plist 里面加上View controller-based status bar appearance BOOL值设为NO，就是把控制器控制状态栏的权限给禁了，用UIApplication来控制。
但是这种做法在iOS9不建议使用了，建议我们使用把那个BOOL值设为YES，然后用控制器的方法来管理状态栏比如。

    - (UIStatusBarStyle)preferredStatusBarStyle{
        return UIStatusBarStyleLightContent;
    }
##### 4.字体
iOS9中，中文系统字体变为了专为中国设计的“苹方”,字体有轻微的加粗效果，并且最关键的是字体间隙变大了！
所以很多原本写死了width的label可能会出现“...”的情况。
包括在很多时候我们自动计算行高行宽的时候出现偏差,导致一些不可知的错误

    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0f]}];
    CGSize adjustedSize = CGSizeMake(ceilf(size.width), ceilf(size.height));    
##### 5.NSURLConnection
NSURLConnection被标记为过期
##### 6.关键字 
nonnull（_Nonnull、__nonnull setter 和 getter 不能为空）
null_resettable（_Null_resettabel、__null_resettable setter 可以为空，getter 不能为空）
__covariant: 协变, 用于数据强制转换类型(子类可以转变父类)
__contravariant: 逆变, 用于数据强制转换类型(父类可以转变子类)
__kindof : 表示当前类, 或者它的子类(__kindof使用: 放在类型前面, 表示修饰此类型)
Foundation 还提供了一对儿宏，包在里面的对象默认加 nonnull 修饰符，只需要把 nullable 的指出来就行
NS_ASSUME_NONNULL_BEGIN
NS_ASSUME_NONNULL_END

##### 7.Contacts.framework/ContactsUI.framework

##### 8.UIKit框架
- UIStackView类，它可以帮助您管理一组子视图，可以垂直或水平排列堆叠
- 新的布局锚点UIView（如leadingAnchor和widthAnchor）NSLayoutAnchor，和NSLayoutDimension所有这些有助于使布局容易。新的布局指南，可帮助您采用可读的内容页边距，并定义视图中内容应绘制的位置。有关更多信息
- 对UIKit Dynamics的增强功能，例如支持非矩形碰撞界限，新UIFieldBehavior类，除了可定制之外还支持各种字段类型，还有其他附件类型UIAttachmentBehavior
