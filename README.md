# ZCScrollView-Demo

###左右滑动切换界面，标题自动居中


![image](http://www.z4a.net/images/2016/09/24/f10b119a215b491d.gif)

##使用方法
###1.导入头文件及创建方法
```
#import "ZCScrollView.h"

//-方法创建
- (instancetype)initWithFrame:(CGRect)frame andDelegate:(id)delegate;
//+方法创建
+ (instancetype)topTitleViewWithFrame:(CGRect)frame andDelegate:(id)delegate;

```
###2.准守协议 ZCScrollViewDelegate

###3.实现代理方法
```
@required
//标题数组
- (NSArray *)topTitlesInZCScrollView:(ZCScrollView *)zcScrollView;

//每页显示的内容
- (UIView *)zcScrollView:(ZCScrollView *)zcScrollView viewForPage:(NSInteger)page;


@optional
//左右滑动时触发
- (void)zcScrollViewDidScroll:(ZCScrollView *)zcScrollView;

//自定义标题栏位置
- (CGRect)topTitleViewFrame;
```

###4.定制属性
```
//标题文字以及指示器颜色设置(默认为红色)
@property (nonatomic, strong) UIColor *titleAndIndicatorColor;

// 是否隐藏指示器(默认为NO)
@property (nonatomic, getter=isHiddenIndicator) BOOL hiddenIndicator;

// 点标题切换界面时是否开启动画(默认为YES)
@property (nonatomic, getter=isPageChangeAnimate) BOOL pageChangeAnimate;

//标题间距(默认25)
@property (nonatomic) CGFloat labelMargin;

//默认&当前页(默认0)
@property (nonatomic) NSInteger currentPage;

//标题栏透明度(默认0.7)
@property (nonatomic) CGFloat topTitleAlpha;

//标题栏高度 (默认40)
@property (nonatomic) CGFloat topTitleHeight;

//指示器的高度 (默认2)
@property (nonatomic) CGFloat indicatorHeight;

```
