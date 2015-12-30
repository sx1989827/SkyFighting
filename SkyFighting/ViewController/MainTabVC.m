//
//  MainTabVC.m
//  SkyFighting
//
//  Created by 孙昕 on 15/12/24.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "MainTabVC.h"
#import "StartVC.h"
#import "ScoreVC.h"
@interface MainTabVC ()

@end

@implementation MainTabVC
-(instancetype)init
{
    if(self=[super init])
    {
        StartVC *vc1=[[StartVC alloc] init];
        vc1.tabBarItem.title=@"首页";
        vc1.tabBarItem.image=[[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc1.tabBarItem.selectedImage=[[UIImage imageNamed:@"homesel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        ScoreVC *vc2=[[ScoreVC alloc] init];
        vc2.tabBarItem.title=@"记录";
        vc2.tabBarItem.image=[[UIImage imageNamed:@"rank"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc2.tabBarItem.selectedImage=[[UIImage imageNamed:@"ranksel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UINavigationController *nav1=[[UINavigationController alloc] initWithRootViewController:vc1];
        UINavigationController *nav2=[[UINavigationController alloc] initWithRootViewController:vc2];
        self.viewControllers=@[nav1,nav2];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
