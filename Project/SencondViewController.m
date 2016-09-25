//
//  SencondViewController.m
//  Project
//
//  Created by ZC on 2016/9/23.
//  Copyright © 2016年 zc. All rights reserved.
//

#import "SencondViewController.h"
#import "ZCScrollView.h"
@interface SencondViewController () <ZCScrollViewDelegate>

@property (nonatomic,strong) NSArray *controllerTitles;
@end

@implementation SencondViewController

#pragma mark - - - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    ZCScrollView *zcsc = [ZCScrollView topTitleViewWithFrame:self.view.bounds andDelegate:self];
    zcsc.indicatorHeight = 5;
    zcsc.currentPage = 1;
    zcsc.titleAndIndicatorColor = [UIColor orangeColor];
    zcsc.labelMargin = 20;
    zcsc.hiddenIndicator = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:zcsc];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - - - ZCScrollViewdelegate

-(UIView *)zcScrollView:(ZCScrollView *)zcScrollView viewForPage:(NSInteger)page
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor redColor];
    view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
    
    return view;
}

-(NSArray *)topTitlesInZCScrollView:(ZCScrollView *)zcScrollView
{
    return self.controllerTitles;
}


#pragma mark - - - LazyLoad



-(NSArray *)controllerTitles

{
    if (!_controllerTitles) {
        _controllerTitles = @[@"精选", @"头条", @"电影"];
    }
    return _controllerTitles;
}

@end
