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
    NSDate *date;
    NSInteger level;
    NSInteger type;
}
@end

@implementation GameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    date=[NSDate date];
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

-(void)GameViewFinish:(BOOL)bSuccess KillCount:(NSInteger)count
{
    UserHistory *obj=[[UserHistory alloc] init];
    obj.date=[date stringValue];
    obj.level=level;
    obj.bSuccess=bSuccess;
    obj.killCount=count;
    obj.useTime=[[NSDate date] timeIntervalSinceDate:date];
    obj.type=type;
    [[UserDefaults sharedInstance] addHistory:obj];
    if(bSuccess)
    {
        [TipView showWithTitle:@"闯关成功" Tip:@"恭喜你，非常棒！" Block:^{
            [[UserDefaults sharedInstance] addLevel];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    else
    {
        [TipView showWithTitle:@"闯关失败" Tip:@"再多磨练磨练吧！" Block:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}
@end








