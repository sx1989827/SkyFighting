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
#import "IntroView.h"
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
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(type==0 && level==0)
    {
        [IntroView showTitle:@[@{
                                   @"title":@"这里是你的你的血条，手指在屏幕上向上然后向右滑动一次，开启人脸检测，检测到多少张人脸，就加多少血!",
                                   @"rect":[NSValue valueWithCGRect:CGRectMake(20, 100, 300, 100)],
                                   @"view":[viewGame valueForKey:@"lbBlood"]
                                   },@{
                                   @"title":@"这里是你的子弹数目，瞄准敌机，点击屏幕，发射子弹！",
                                   @"rect":[NSValue valueWithCGRect:CGRectMake(20, 100, 300, 60)],
                                   @"view":[viewGame valueForKey:@"lbBullet"]
                                   },@{@"title":@"这里是你的炸弹数目，瞄准敌机，手指在屏幕上向下然后向右滑动一次，放出炸弹！",
                                       @"rect":[NSValue valueWithCGRect:CGRectMake(20, 120, 300, 100)],
                                       @"view":[viewGame valueForKey:@"lbBomb"]
                                       },@{@"title":@"这里是你的圣光数目，瞄准敌机，手指在屏幕上迅速画一个五角星，放出华丽的大招，可以毁灭一切敌人！",
                                           @"rect":[NSValue valueWithCGRect:CGRectMake(20, 150, 300, 100)],
                                           @"view":[viewGame valueForKey:@"lbLaser"]
                                           },@{@"title":@"这里是你的保护罩数目，当敌人接近时，长按屏幕张开防护罩，自己可以免除一切攻击！",
                                               @"rect":[NSValue valueWithCGRect:CGRectMake(20, 200, 300, 100)],
                                               @"view":[viewGame valueForKey:@"lbProtect"]
                                               }] Block:^{
                                                   [viewGame start];
                                               }];
    }
    else if(type==1)
    {
        [TipView showWithTitle:@"求生模式" Tip:@"在求生模式下，敌人无限多，你需要尽可能多的去消灭他们，祝你好运！" Block:^{
            [viewGame start];
        }];
    }
    else
    {
        [viewGame start];
    }
    
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








