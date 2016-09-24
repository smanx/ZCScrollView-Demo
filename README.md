# ZCScrollView-Demo

###左右滑动切换界面，标题自动居中


![image](http://www.z4a.net/images/2016/09/24/f10b119a215b491d.gif)

##使用方法


### 创建方法
```javascript

- (instancetype)initWithFrame:(CGRect)frame andDelegate:(id)delegate;

+ (instancetype)topTitleViewWithFrame:(CGRect)frame andDelegate:(id)delegate;
````

###协议方法

```javascript

//每页显示的内容
- (UIView *)zcScrollView:(ZCScrollView *)zcScrollView viewForPage:(NSInteger)page;

//标题数组
- (NSArray *)topTitlesInZCScrollView:(ZCScrollView *)zcScrollView;

@optional
//自定义标题栏位置
- (CGRect)topTitleViewFrame;

````
