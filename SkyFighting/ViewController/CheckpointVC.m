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
@interface CheckpointVC ()<LazyTableViewDelegate>

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
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.isAgain) {
        
        
    }
    
   NSInteger level= [[UserDefaults sharedInstance] level];
    
    
    LevelInfo*levelInfo = [[UserDefaults sharedInstance]levelInfo:level];
    
    __weak typeof(self)weakSelf = self;
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
        cl.startButton.hidden = YES;
        cl.detailLabel.text = [NSString stringWithFormat:@"当前关卡:%d",level];
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
         cl.startButton.hidden = YES;
        cl.detailLabel.text = [NSString stringWithFormat:@"敌机血量:%d",levelInfo.bloodEnemy];
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
         cl.startButton.hidden = YES;
         cl.detailLabel.text = [NSString stringWithFormat:@"敌机数量:%d",levelInfo.count];
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
         cl.startButton.hidden = YES;
        cl.detailLabel.text = [NSString stringWithFormat:@"玩家血量:%d",levelInfo.bloodPlayer];
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
         cl.startButton.hidden = YES;
        cl.detailLabel.text = [NSString stringWithFormat:@"敌机子弹时间间隔:%d",levelInfo.fireGap];
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
        cl.startButton.hidden = YES;
        cl.detailLabel.text = [NSString stringWithFormat:@"敌机出现时间间隔:%d",levelInfo.displayGap];
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
         cl.startButton.hidden = YES;
        cl.detailLabel.text = [NSString stringWithFormat:@"子弹数量:%d",levelInfo.bulletCount];
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
         cl.startButton.hidden = YES;
        cl.detailLabel.text = [NSString stringWithFormat:@"圣光数量:%d",levelInfo.laserCount];
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
         cl.startButton.hidden = YES;
         cl.detailLabel.text = [NSString stringWithFormat:@"导弹数量:%d",levelInfo.bombCount];
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
         cl.startButton.hidden = YES;
      cl.detailLabel.text = [NSString stringWithFormat:@"防护罩数量:%d",levelInfo.protectCount];
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
        [cl.startButton addTarget:weakSelf action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        cl.startButton.layer.cornerRadius = 10;
        cl.startButton.layer.masksToBounds  =YES;
        cl.detailLabel.hidden = YES;
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView reloadStatic];

}
- (IBAction)start {
    [self pushViewController:@"GameVC" Param:nil];
    
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
