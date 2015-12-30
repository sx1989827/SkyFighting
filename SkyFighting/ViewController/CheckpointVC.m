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
    
    __weak typeof(self)weakSelf = self;
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
        cl.startButton.hidden = YES;
        cl.detailLabel.text = @"关数:4";
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
         cl.startButton.hidden = YES;
        cl.detailLabel.text = @"敌机血量:13";
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
         cl.startButton.hidden = YES;
        cl.detailLabel.text = @"敌机数量:13";
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
         cl.startButton.hidden = YES;
        cl.detailLabel.text = @"玩家血量:200";
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
         cl.startButton.hidden = YES;
        cl.detailLabel.text = @"敌机子弹时间间隔:1s";
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
         cl.startButton.hidden = YES;
        cl.detailLabel.text = @"子弹数量:13";
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
         cl.startButton.hidden = YES;
        cl.detailLabel.text = @"激光数量:13";
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
         cl.startButton.hidden = YES;
        cl.detailLabel.text = @"导弹数量:13";
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
         cl.startButton.hidden = YES;
        cl.detailLabel.text = @"防护罩数量:2";
    } ClickBlock:^(id cell) {
        
    }];
    [_mainTableView addStaticCell:40 CellBlock:^(id cell) {
        DetailCheckpointCell *cl=cell;
        cl.selectionStyle =UITableViewCellSelectionStyleNone;
         cl.startButton.hidden = YES;
        cl.detailLabel.text = @"防护罩数量:2";
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
