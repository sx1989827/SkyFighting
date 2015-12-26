//
//  StartVC.m
//  SkyFighting
//
//  Created by 孙昕 on 15/12/24.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "StartVC.h"

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onLevel:(id)sender {
}

- (IBAction)onSurvival:(id)sender {
}
@end
