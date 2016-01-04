//
//  StartVC.m
//  SkyFighting
//
//  Created by 孙昕 on 15/12/24.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "StartVC.h"
#import "Header.h"
#import "SGActionView.h"
@interface StartVC ()

@end

@implementation StartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bHud=NO;
    self.title=@"首页";
    [self hideBackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLevel:(id)sender
{
    if ([[UserDefaults sharedInstance] level]>0) {
        [SGActionView showSheetWithTitle:@"请选择" itemTitles:@[@"继续闯关",@"从新开始"] selectedIndex:-1 selectedHandle:^(NSInteger index) {
            if(index==0)
            {
                [self pushViewController:@"CheckpointVC" Param:nil];
            }
            else if(index==1)
            {
                [[UserDefaults sharedInstance] resetLevel];
                [self pushViewController:@"CheckpointVC" Param:nil];
            }
        }];
    }
    else
    {
       [self pushViewController:@"CheckpointVC" Param:nil];
    }
    
}
- (IBAction)onSurvival:(id)sender
{
    [TipView showWithTitle:@"提示" Tip:@"请将手机面朝自己，置于自己正前方，点击确定，这样坐标能更精确的设定" Block:^{
        [self pushViewController:@"GameVC" Param:@{@"type":@1}];
    }];
    
}
@end










