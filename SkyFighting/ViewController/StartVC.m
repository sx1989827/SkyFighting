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
    if([[UserDefaults sharedInstance] level]>0)
    {
        [SGActionView showSheetWithTitle:@"请选择" itemTitles:@[@"继续闯关",@"从新开始"] selectedIndex:-1 selectedHandle:^(NSInteger index) {
            if(index==0)
            {
                
            }
            else if(index==1)
            {
                
            }
        }];
    }
    else
    {
        [self pushViewController:@"GameVC" Param:nil];
    }
}

- (IBAction)onSurvival:(id)sender
{
    
}
@end










