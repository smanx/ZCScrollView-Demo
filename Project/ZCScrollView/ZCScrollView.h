//
//  ZCScrollView.h
//  Project
//
//  Created by ZC on 2016/9/23.
//  Copyright © 2016年 zc. All rights reserved.
//  GitHub地址：https://github.com/smanx/ZCScrollView-Demo.git



#import <UIKit/UIKit.h>

@class ZCScrollView;



@protocol ZCScrollViewDelegate <NSObject>

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




@end


@interface ZCScrollView : UIView


//代理方法
@property (nonatomic,weak) id <ZCScrollViewDelegate> delegate;



//标题文字以及指示器颜色设置(默认为红色)
@property (nonatomic, strong) UIColor *titleAndIndicatorColor;

// 是否隐藏指示器(默认为NO)
@property (nonatomic, getter=isHiddenIndicator) BOOL hiddenIndicator;

// 点标题是切换界面时候开启动画(默认为YES)
@property (nonatomic, getter=isPageChangeAnimate) BOOL pageChangeAnimate;

//label之间的间距(滚动时TitleLabel之间的间距)
@property (nonatomic) CGFloat labelMargin;



//默认&当前页
@property (nonatomic) NSInteger currentPage;

//标题栏透明度
@property (nonatomic) CGFloat topTitleAlpha;

//标题栏高度
@property (nonatomic) CGFloat topTitleHeight;

//指示器的高度
@property (nonatomic) CGFloat indicatorHeight;


//标题背景
@property (nonatomic,weak) UIVisualEffectView *topTitlebackgroundView;


//+方法创建
- (instancetype)initWithFrame:(CGRect)frame andDelegate:(id)delegate;
//-方法创建
+ (instancetype)topTitleViewWithFrame:(CGRect)frame andDelegate:(id)delegate;


//内容ScrollView
@property (nonatomic,weak) UIScrollView *backgroundView;


@end


