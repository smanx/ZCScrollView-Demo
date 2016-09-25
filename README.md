# ZCScrollView-Demo

###左右滑动切换界面，标题自动居中


![image](http://www.z4a.net/images/2016/09/24/f10b119a215b491d.gif)

##使用方法
###1.导入头文件 
```
#import "ZCScrollView.h"

```
###2.准守协议 ZCScrollViewDelegate

###3.实现代理方法
```
@required

//每页的控制器
- (UIViewController *)zcScrollViewController:(ZCScrollView *)zcScrollView viewForPage:(NSInteger)page;

//标题字符串数组
- (NSArray *)topTitlesInZCScrollView:(ZCScrollView *)zcScrollView;

@optional
//自定义标题栏位置
- (CGRect)topTitleViewFrame;
```

###4.定制属性
```
//标题文字以及指示器颜色设置(默认为红色)
@property (nonatomic, strong) UIColor *titleAndIndicatorColor;

// 是否隐藏指示器(默认为NO)
@property (nonatomic, getter=isHiddenIndicator) BOOL hiddenIndicator;

//滚动时TitleLabel之间距离(默认25)
@property (nonatomic) CGFloat labelMargin;

//默认&当前页(进入界面默认第0页)
@property (nonatomic) NSInteger currentPage;

//标题栏透明度(默认0.7)
@property (nonatomic) CGFloat topTitleAlpha;

//标题栏高度(默认40)
@property (nonatomic) CGFloat topTitleHeight;

//指示器的高度(默认2)
@property (nonatomic) CGFloat indicatorHeight;
```
