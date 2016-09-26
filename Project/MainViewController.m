//
//  MainViewController.m
//  Project
//
//  Created by ZC on 2016/9/23.
//  Copyright © 2016年 zc. All rights reserved.
//

#import "MainViewController.h"
#import "ZCScrollView.h"


@interface MainViewController () <ZCScrollViewDelegate>

@property (nonatomic,strong) NSArray *controllerNames;

@property (nonatomic,strong) NSArray *controllerTitles;


@end

@implementation MainViewController


#pragma mark - - - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    ZCScrollView *zcsc = [ZCScrollView topTitleViewWithFrame:self.view.bounds andDelegate:self];
    
    //属性如不设置默认以下值
    //指示器高度
    zcsc.indicatorHeight = 2;
    //默认页面
    zcsc.currentPage = 0;
    //指示器和title的颜色
    zcsc.titleAndIndicatorColor = [UIColor redColor];
    //标题间的宽度
    zcsc.labelMargin = 25;
    //是否隐藏指示器
    zcsc.hiddenIndicator = NO;
    //标题透明度
    zcsc.topTitleAlpha = 0.7;
    //标题高度
    zcsc.topTitleHeight = 40;
 
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:zcsc];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - - - ZCScrollViewdelegate

-(UIView *)zcScrollView:(ZCScrollView *)zcScrollView viewForPage:(NSInteger)page
{
    UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
    return view;
}

-(NSArray *)topTitlesInZCScrollView:(ZCScrollView *)zcScrollView
{
    return self.controllerTitles;
}

-(void)zcScrollViewDidScroll:(ZCScrollView *)zcScrollView
{
    NSLog(@"正在横向滚动%lg",zcScrollView.backgroundView.contentOffset.x);
}

#pragma mark - - - LazyLoad



-(NSArray *)controllerNames
{
    if (_controllerNames) {
        _controllerNames = @[@"MainOneViewController",@"MainTwoViewController",@"MainThreeViewController",@"MainFourViewController",@"MainFiveViewController",@"MainSixViewController",@"MainSevenViewController",@"MainEightViewController",@"MainNineViewController"];
    }
    return _controllerNames;
}

-(NSArray *)controllerTitles

{
    if (!_controllerTitles) {
        _controllerTitles = @[@"电视剧", @"动画" ,@"精选", @"电影", @"综艺", @"直播",@"推荐", @"NBA", @"新闻", @"娱乐", @"音乐", @"网络电影"];
    }
    return _controllerTitles;
}



@end
