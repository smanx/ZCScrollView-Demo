//
//  BaseTabBarViewController.m
//  Project
//
//  Created by QF on 2016/9/23.
//  Copyright © 2016年 zc. All rights reserved.
//

#import "BaseTabBarViewController.h"

@interface BaseTabBarViewController ()

@property (nonatomic,strong) NSArray *controllerNames;

@property (nonatomic,strong) NSArray *controllerTitles;



@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.controllerNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = [[NSClassFromString(obj) alloc]init];
        vc.view.backgroundColor = [UIColor whiteColor];
        vc.title = self.controllerTitles[idx];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [self addChildViewController:nav];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(NSArray *)controllerNames
{
    if (!_controllerNames) {
        _controllerNames = @[
                             @"MainViewController",
                             @"SencondViewController"];
    }
    return _controllerNames;
}

-(NSArray *)controllerTitles

{
    if (!_controllerTitles) {
        _controllerTitles = @[@"第一页",@"第二页"];
    }
    return _controllerTitles;
}

@end
