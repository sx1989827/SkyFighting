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
    viewGame=(GameView*)self.view;
    if(type==0)
    {
        LevelInfo *info=[[UserDefaults sharedInstance] levelInfo:level];
        [viewGame setup:info.count PlayerBlood:info.bloodPlayer EnemyBlood:info.bloodEnemy DispalyGap:info.displayGap FireGap:info.fireGap BulletCount:info.bulletCount BombCount:info.bombCount LaserCount:info.laserCount ProtectCount:info.protectCount];
    }
    else
    {
        [viewGame setup:1000 PlayerBlood:10000 EnemyBlood:500 DispalyGap:5 FireGap:5 BulletCount:9999 BombCount:999 LaserCount:99 ProtectCount:50];
    }
    viewGame.delegate=self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    [self removeHud];
    self.bHud=NO;
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








