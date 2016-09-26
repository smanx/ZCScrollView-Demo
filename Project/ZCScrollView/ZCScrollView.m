//
//  ZCScrollView.m
//  Project
//
//  Created by ZC on 2016/9/23.
//  Copyright © 2016年 zc. All rights reserved.
//  GitHub地址：https://github.com/smanx/ZCScrollView-Demo.git


#import "ZCScrollView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ZCScrollView () <UIScrollViewDelegate>


//当前标题
@property (nonatomic, weak) UILabel *currentTitleLabel;

//标题数组
@property (nonatomic,strong) NSArray *topTitles;

//指示器
@property (nonatomic, strong) UIView *indicatorView;

//标题宽度是否超过屏幕宽度
@property (nonatomic, assign,getter=isLongerThanScreenWidth) BOOL longerThanScreenWidth;



//标题ScrollView
@property (nonatomic,weak) UIScrollView *topTitleView;



//总页数
@property (nonatomic)NSInteger totalPage;

//水平偏移量
@property (nonatomic)CGFloat currentOffsetX;


@end

@implementation ZCScrollView




#pragma mark ---- LazyLoad

-(UIScrollView *)backgroundView
{
    if (!_backgroundView) {
        
        UIScrollView *sc = [[UIScrollView alloc]initWithFrame:self.bounds];
        sc.bounces = NO;
        sc.pagingEnabled = YES;
        sc.contentSize = CGSizeMake(self.bounds.size.width * self.totalPage, 0);
        sc.delegate = self;
        sc.showsHorizontalScrollIndicator = NO;
        [self addSubview:sc];
        _backgroundView = sc;
        
    }
    return _backgroundView;
}

-(UIVisualEffectView *)topTitlebackgroundView
{
    
    if (!_topTitlebackgroundView) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *view = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        view.alpha = 0.9;
        if ([self.delegate respondsToSelector:@selector(topTitleViewFrame)]) {
            view.frame = [self.delegate topTitleViewFrame];
        }
        else view.frame = CGRectMake(0, 60, self.bounds.size.width, _topTitleHeight);
        view.alpha = 0.95;
        view.backgroundColor = [UIColor colorWithWhite:1 alpha:_topTitleAlpha];
        [self addSubview:view];
        _topTitlebackgroundView = view;
    }
    return _topTitlebackgroundView;
}

-(UIScrollView *)topTitleView
{
    if (!_topTitleView) {
        UIScrollView *sc = [[UIScrollView alloc]init];
        
        sc.center = self.topTitlebackgroundView.center;
        sc.frame = CGRectMake(0, 0, kScreenWidth, self.topTitlebackgroundView.bounds.size.height);
    
        sc.showsHorizontalScrollIndicator = NO;
        [self.topTitlebackgroundView addSubview:sc];
        _topTitleView = sc;
    }
    return  _topTitleView;
}



- (NSInteger)totalPage
{
    if (!_totalPage) {
        _totalPage = [self.delegate topTitlesInZCScrollView:self].count;
    }
    return _totalPage;
}

- (NSArray *)topTitles
{
    if (!_topTitles) {
        _topTitles = [self.delegate topTitlesInZCScrollView:self];
        [self addLabelToTopTitleView:_topTitles];
    }
    return _topTitles;
}

-(UIView *)indicatorView
{
    if (self.isHiddenIndicator) {
        _indicatorView = nil;
        return nil;
    }
    if (!_indicatorView) {
        UIView *indicatorView = [[UIView alloc]init];
        indicatorView.backgroundColor = _titleAndIndicatorColor;
        UILabel *label = [self.topTitlebackgroundView viewWithTag:100 + _currentPage];
        indicatorView.frame = CGRectMake(label.frame.origin.x, CGRectGetMaxY(label.frame) - _indicatorHeight, label.bounds.size.width, _indicatorHeight);
        [self.topTitleView addSubview:indicatorView];
        _indicatorView = indicatorView;
    }
    
    
    return _indicatorView;
}

- (void)addLabelToTopTitleView:(NSArray *)topTitles

{
    __block CGFloat labelX = 0;
    __block CGFloat lastLabelW = 0;
    
    
    [topTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.tag = 100+idx;
        titleLabel.text = topTitles[idx];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        if (idx == _currentPage) {
            titleLabel.textColor = _titleAndIndicatorColor;
        }
    
        CGSize titleLabelSize = [self sizeWithText:titleLabel.text font:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(MAXFLOAT, self.topTitleView.bounds.size.height)];
    
        CGFloat labelW = titleLabelSize.width;
    
        titleLabel.frame = CGRectMake(labelX, 0, labelW + _labelMargin, self.topTitleView.bounds.size.height);
        labelX += labelW + _labelMargin;
        [self.topTitleView addSubview:titleLabel];
        lastLabelW = titleLabelSize.width;
            
            
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelClick:)];
        [titleLabel addGestureRecognizer:tap];
        titleLabel.userInteractionEnabled = YES;
            
            
            
    }];
    
    if (labelX < self.bounds.size.width)
    {
        self.topTitleView.bounds = CGRectMake(0, 0, labelX, self.topTitleView.frame.size.height);
        self.topTitleView.center = CGPointMake(kScreenWidth / 2, CGRectGetMinY(self.topTitleView.frame) + self.topTitleView.frame.size.height / 2);
    }
    else
    {
        _longerThanScreenWidth = YES;
    }
    self.topTitleView.contentSize = CGSizeMake(labelX, 0);
    
    [self indicatorView];
}


#pragma mark - - - 创建方法

+(instancetype)topTitleViewWithFrame:(CGRect)frame andDelegate:(id)delegate
{
    
    
    return [[self alloc]initWithFrame:frame andDelegate:(id)delegate];
}



- (instancetype)initWithFrame:(CGRect)frame andDelegate:(id)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = delegate;
        
        [self defaultSettings];
        
        
        
    }
    return self;
}

-(void)layoutSubviews

{
    [self setEveryPageView];
    
    [self topTitles];
    
    self.backgroundView.contentOffset = CGPointMake( _currentPage * kScreenWidth, 0);
}

//属性默认值
- (void)defaultSettings
{
    
    _indicatorHeight = 2;
    _currentPage = 0;
    _titleAndIndicatorColor = [UIColor redColor];
    _hiddenIndicator = NO;;
    _labelMargin = 25;
    _topTitleAlpha = 0.7;
    _topTitleHeight = 40;
    _pageChangeAnimate = YES;

}

#pragma mark - - - 设置每一页上的view
- (void)setEveryPageView

{
    
    for (int i = 0; i < self.totalPage; i++) {
        UIView *view = [self.delegate zcScrollView:self viewForPage:i];
        if (!view.frame.size.height) {
            view.frame = CGRectMake(i * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
        }
        else
        {
            view.frame = CGRectMake(i * self.bounds.size.width, 0, view.bounds.size.width, view.bounds.size.height);
        }
        
        [self.backgroundView addSubview:view];
        
    }
    
    
}


//选中标题变色
- (void)currentTitleLabelChangeColor
{
    for (UILabel *label in self.topTitleView.subviews) {
        if ([label isKindOfClass:[UILabel class]]) {
            label.textColor = [UIColor blackColor];
        }
    }
    _currentTitleLabel.textColor = _titleAndIndicatorColor;
}

//滚动标题选中居中
- (void)topTitleLabelToCenter
{
    
    [self currentTitleLabelChangeColor];
    

    if (self.isLongerThanScreenWidth) {
        
        CGFloat offsetX = _currentTitleLabel.center.x - self.bounds.size.width / 2;
        
        if (offsetX < 0) offsetX = 0;
        
        // 获取最大滚动范围
        CGFloat maxOffsetX = self.topTitleView.contentSize.width - self.bounds.size.width;
        
        if (offsetX > maxOffsetX) offsetX = maxOffsetX;
        
        // 滚动标题滚动条
        [self.topTitleView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    
    
}


//topTitleView点击时触发
- (void)titleLabelClick:(UITapGestureRecognizer *)tap
{
    
    _currentTitleLabel = (UILabel *)tap.view;
    
    CGRect rect = self.indicatorView.frame;
    rect.origin.x = _currentTitleLabel.frame.origin.x;
    rect.size.width = _currentTitleLabel.frame.size.width;
    if (_pageChangeAnimate) {
        [UIView animateWithDuration:0.2 animations:^{
            self.indicatorView.frame = rect;
            self.backgroundView.contentOffset = CGPointMake((_currentTitleLabel.tag - 100) * self.bounds.size.width, 0);
        }];
    }
    else
    {
        [UIView animateWithDuration:0.2 animations:^{
            self.indicatorView.frame = rect;
            
        }];
        self.backgroundView.contentOffset = CGPointMake((_currentTitleLabel.tag - 100) * self.bounds.size.width, 0);
    }
    
    [self topTitleLabelToCenter];
}

#pragma mark - - - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / self.bounds.size.width;
    UILabel *selectedLabel = [self.topTitlebackgroundView viewWithTag:100 + page];
    _currentTitleLabel = selectedLabel;
    
    CGRect rect = self.indicatorView.frame;
    rect.size.width = selectedLabel.frame.size.width;
    rect.origin.x = selectedLabel.frame.origin.x;
    [UIView animateWithDuration:0.3 animations:^{
        self.indicatorView.frame = rect;
    }];
    [self topTitleLabelToCenter];
    [self.delegate zcScrollViewDidScroll:self];

    if (_backgroundView.contentOffset.x - _currentOffsetX) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.topTitlebackgroundView.hidden = NO;
        });
        
    }
    _currentOffsetX = self.backgroundView.contentOffset.x;
}


#pragma mark - - - 重写setter方法
-(void)setIndicatorHeight:(CGFloat)indicatorHeight
{
    
    _indicatorHeight = indicatorHeight;
}
#pragma mark - - - 计算文字高度

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
