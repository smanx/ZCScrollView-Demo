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

@property (nonatomic,strong) NSArray *normalImageNames;

@property (nonatomic,strong) NSArray *selectedImageNames;


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
                             @"SencondViewController",
                             @"ThirdViewController",
                             @"FourthViewController"];
    }
    return _controllerNames;
}

-(NSArray *)controllerTitles

{
    if (!_controllerTitles) {
        _controllerTitles = @[@"第一页",@"第二页",@"第三页",@"第四页"];
    }
    return _controllerTitles;
}

-(NSArray *)normalImageNames
{
    if (!_normalImageNames) {
        _normalImageNames = @[@"第一页",@"第二页",@"第三页",@"第四页"];
    }
    return _normalImageNames;
}

-(NSArray *)selectedImageNames
{
    if (!_selectedImageNames) {
        _selectedImageNames = @[@"第一页",@"第二页",@"第三页",@"第四页"];
    }
    return _selectedImageNames;
}

@end
