//
//  MainViewController.m
//  Project
//
//  Created by QF on 2016/9/23.
//  Copyright © 2016年 zc. All rights reserved.
//

#import "MainViewController.h"
#import "Config.h"
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
 
    self.automaticallyAdjustsScrollViewInsets = NO;
                          
    [self.view addSubview:zcsc];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(NSInteger)numberOfPagesInZCScrollView:(ZCScrollView *)zcScrollView
{
    return self.controllerTitles.count;
}

-(UIView *)zcScrollView:(ZCScrollView *)zcScrollView viewForPage:(NSInteger)page
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor redColor];
    view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
    
    return view;
}
#pragma mark - - - LazyLoad

//- (SGTopTitleView *)topTitleView
//{
//    if (!_topTitleView) {
//        SGTopTitleView *topTitleView = [SGTopTitleView topTitleViewWithFrame:CGRectMake(0, 64, kScreenWidth, 44)];
//        topTitleView.scrollTitleArr = self.controllerTitles;
//        topTitleView.titleAndIndicatorColor = [UIColor colorWithRed:arc4random()%256/255 green:arc4random()%256/255 blue:arc4random()%256/255 alpha:1];
//        topTitleView.delegate = self;
//        [self.view addSubview:topTitleView];
//        _topTitleView = topTitleView;
//    }
//    return _topTitleView;
//}

//- (UIScrollView *)mainScrollView
//{
//    if (!_mainScrollView) {
//        UIScrollView *mainScrollView = [[UIScrollView alloc]init];
//        mainScrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//        mainScrollView.contentSize = CGSizeMake(kScreenWidth * self.controllerTitles.count, 0);
//        mainScrollView.backgroundColor = [UIColor clearColor];
//        mainScrollView.pagingEnabled = YES;
//        mainScrollView.bounces = NO;
//        mainScrollView.showsHorizontalScrollIndicator = NO;
//        mainScrollView.delegate = self;
//        [self.view insertSubview:mainScrollView belowSubview:self.topTitleView];
//        
//        _mainScrollView  = mainScrollView;
//    }
//    return _mainScrollView;
//}

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
        _controllerTitles = @[@"精选", @"电视剧", @"电影", @"综艺", @"NBA", @"新闻", @"娱乐", @"音乐", @"网络电影"];
    }
    return _controllerTitles;
}



@end
