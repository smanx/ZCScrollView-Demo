//
//  ZCScrollView.h
//  Project
//
//  Created by QF on 2016/9/23.
//  Copyright © 2016年 zc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCScrollView;



@protocol ZCScrollViewDelegate <NSObject>

- (NSInteger)numberOfPagesInZCScrollView:(ZCScrollView *)zcScrollView;

- (UIView *)zcScrollView:(ZCScrollView *)zcScrollView viewForPage:(NSInteger)page;



@end


@interface ZCScrollView : UIView


//代理方法
@property (nonatomic,weak) id <ZCScrollViewDelegate> delegate;

/** 静止标题数组 */
@property (nonatomic, strong) NSArray *staticTitleArr;
/** 滚动标题数组 */
@property (nonatomic, strong) NSArray *scrollTitleArr;
/** 存入所有Label */
@property (nonatomic, strong) NSMutableArray *allTitleLabel;

#pragma mark - - - 以下属性一定要设置在 -> 标题数组 <- 之后, 否则无效果
/** 文字以及指示器颜色设置(默认为红色)*/
@property (nonatomic, strong) UIColor *titleAndIndicatorColor;
/** 是否隐藏指示器(默认为NO) 指示器的宽度是根据标题内容的宽度变化而变化的, 所以设置这个属性一定要在 -> 标题数组属性之后 */
@property (nonatomic, assign) BOOL isHiddenIndicator;
/** 背景指示器样式(默认指示器在标题文字下方, 设置此属性指示器显示在文字后方) */
@property (nonatomic, assign) BOOL showsTitleBackgroundIndicatorStyle;


/** label之间的间距(滚动时TitleLabel之间的间距) */
@property (nonatomic) CGFloat labelMargin;
/** 指示器的高度 */
@property (nonatomic) CGFloat indicatorHeight;




//+方法创建
- (instancetype)initWithFrame:(CGRect)frame andDelegate:(id)delegate;
//-方法创建
+ (instancetype)topTitleViewWithFrame:(CGRect)frame andDelegate:(id)delegate;




@end


