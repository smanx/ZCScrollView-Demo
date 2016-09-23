//
//  ZCScrollView.m
//  Project
//
//  Created by QF on 2016/9/23.
//  Copyright © 2016年 zc. All rights reserved.
//

#import "ZCScrollView.h"

@interface ZCScrollView ()


/** 静止标题Label */
@property (nonatomic, strong) UILabel *staticTitleLabel;
/** 滚动标题Label */
@property (nonatomic, strong) UILabel *scrollTitleLabel;
/** 选中标题时的Label */
@property (nonatomic, strong) UILabel *selectedTitleLabel;
/** 指示器 */
@property (nonatomic, strong) UIView *indicatorView;

//背景ScrollView
@property (nonatomic,weak) UIScrollView *backgroundView;

//背景ScrollView
@property (nonatomic,weak) UIScrollView *topTitleView;

@property (nonatomic,strong) NSArray *topTitles;

@property (nonatomic)NSInteger totalPage;

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
        [self addSubview:sc];
        
        _backgroundView = sc;
    }
    return _backgroundView;
}

-(UIScrollView *)topTitleView
{
    if (!_topTitleView) {
        UIScrollView *sc = [[UIScrollView alloc]init];
        
        _topTitleView = sc;
    }
    return  _topTitleView;
}
- (NSInteger)totalPage
{
    if (!_totalPage) {
        _totalPage = [self.delegate numberOfPagesInZCScrollView:self];
    }
    return _totalPage;
}

+(instancetype)topTitleViewWithFrame:(CGRect)frame andDelegate:(id)delegate
{
    
    
    return [[self alloc]initWithFrame:frame andDelegate:(id)delegate];
}


- (instancetype)initWithFrame:(CGRect)frame andDelegate:(id)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = delegate;
        
        
        [self setEveryPageView];
        
        
    }
    return self;
}


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

@end
