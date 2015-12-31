//
//  CheckpointVC.m
//  SkyFighting
//
//  Created by lxx on 15/12/29.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "CheckpointVC.h"
#import <LazyTableBaseSection.h>
#import "DetailCheckpointCell.h"
#import "Util.h"
#import "UserDefaults.h"
#import "TipView.h"
@interface CheckpointVC ()<LazyTableViewDelegate>
{
    NSInteger level;
}
@end

@implementation CheckpointVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"关卡信息";
    self.bHud = NO;
    [_mainTableView registarCell:@"DetailCheckpointCell" StrItem:nil];
    [self.mainTableView setDelegateAndDataSource:self];
    LazyTableBaseSection *sec = [[LazyTableBaseSection alloc]init];
    sec.headerHeight = 10;
    sec.titleHeader = @"";
    [_mainTableView addSection:sec];
    self.startButton.layer.cornerRadius = 15;
    self.startButton.layer.masksToBounds = YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    level= [[UserDefaults sharedInstance] level];
    LevelInfo*levelInfo = [[UserDefaults sharedInstance]levelInfo:level];
    __block typeof(NSInteger)integer = level;
    [_mainTableView empty];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
        cl.detailLabel.text = [NSString stringWithFormat:@"当前关卡:%ld",(long)(integer+1)];
    } ClickBlock:^(id cell) {
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
        cl.detailLabel.text = [NSString stringWithFormat:@"敌机血量:%ld",(long)levelInfo.bloodEnemy];
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
         cl.detailLabel.text = [NSString stringWithFormat:@"敌机数量:%ld",(long)levelInfo.count];
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
        cl.detailLabel.text = [NSString stringWithFormat:@"玩家血量:%ld",(long)levelInfo.bloodPlayer];
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
        cl.detailLabel.text = [NSString stringWithFormat:@"敌机子弹时间间隔:%lds",(long)levelInfo.fireGap];
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
        cl.detailLabel.text = [NSString stringWithFormat:@"敌机出现时间间隔:%lds",(long)levelInfo.displayGap];
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
        cl.detailLabel.text = [NSString stringWithFormat:@"子弹数量:%ld",(long)levelInfo.bulletCount];
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
        cl.detailLabel.text = [NSString stringWithFormat:@"圣光数量:%ld",(long)levelInfo.laserCount];
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
         cl.detailLabel.text = [NSString stringWithFormat:@"导弹数量:%ld",(long)levelInfo.bombCount];
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
      cl.detailLabel.text = [NSString stringWithFormat:@"防护罩数量:%ld",(long)levelInfo.protectCount];
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView reloadStatic];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)start:(id)sender {
    [TipView showWithTitle:@"提示" Tip:@"请将手机面朝自己，置于自己正前方，点击确定，这样坐标能更精确的设定" Block:^{
        [self pushViewController:@"GameVC" Param:@{@"level":[NSNumber numberWithInteger:level],
                                                   @"type":@0}];
    }];
    
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
