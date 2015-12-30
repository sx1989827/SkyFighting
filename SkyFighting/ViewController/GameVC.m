//
//  GameVC.m
//  SkyFighting
//
//  Created by 孙昕 on 15/12/27.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "GameVC.h"
#import "GameView.h"
#import "Header.h"
@interface GameVC ()<GameViewDelegate>
{
    GameView *viewGame;
}
@end

@implementation GameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bHud=NO;
    viewGame=(GameView*)self.view;
    [viewGame setup:2 PlayerBlood:1000 EnemyBlood:200 DispalyGap:10 FireGap:1 BulletCount:100 BombCount:10 LaserCount:100 ProtectCount:2];
    viewGame.delegate=self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    [viewGame start];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)GameViewFinish:(BOOL)bSuccess
{
    if(bSuccess)
    {
        [TipView showWithTitle:@"闯关成功" Tip:@"恭喜你，非常棒！" Block:^{
            
        }];
    }
    else
    {
        [TipView showWithTitle:@"闯关失败" Tip:@"再多磨练磨练吧！" Block:^{
            
        }];
    }
}
@end








