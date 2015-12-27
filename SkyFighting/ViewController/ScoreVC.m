//
//  ScoreVC.m
//  SkyFighting
//
//  Created by 孙昕 on 15/12/24.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "ScoreVC.h"
#import "UserDefaults.h"
#import "HistoryCell.h"
@interface ScoreVC ()<LazyTableViewDelegate>
@property(nonatomic,strong)NSArray  *historyModelArray;
@end

@implementation ScoreVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (int i=0; i<_historyModelArray.count; i++) {
         UserHistory*history = [self.historyModelArray objectAtIndex:i];
        if (history.type==0) {
            [_mainTable addStaticCell:90 CellBlock:^(id cell) {
                HistoryCell *cl=cell;
                cl.selectionStyle =UITableViewCellSelectionStyleNone;
                cl.tyoeLabel.text =@"闯关模式";
                cl.levelLabel.text = [NSString stringWithFormat:@"等级:%d",history.level];
                cl.bSuccessLabel.text = history.bSuccess==0?@"已完成":@"未完成";
                cl.killCountLabel.text = [NSString stringWithFormat:@"杀敌数:%d",history.killCount];
                cl.userTimeLabel.text = [NSString stringWithFormat:@"用时:%ds",history.useTime];
                cl.dateLabel.text = [NSString stringWithFormat:@"游戏时间:%@",history.date];
            } ClickBlock:^(id cell) {
                
            }];
        }
        else
        {
            [_mainTable addStaticCell:60 CellBlock:^(id cell) {
                HistoryCell *cl=cell;
                cl.selectionStyle =UITableViewCellSelectionStyleNone;
                cl.tyoeLabel.text = @"生存模式";
                cl.killCountLabel.text = [NSString stringWithFormat:@"杀敌数:%d",history.killCount];
                cl.userTimeLabel.text = [NSString stringWithFormat:@"用时:%ds",history.useTime];
                cl.dateLabel.text = [NSString stringWithFormat:@"游戏时间:%@",history.date];
            } ClickBlock:^(id cell) {
                
            }];
        }
    }
    [self.mainTable reloadStatic];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.bHud=NO;
    self.title=@"历史";
    [self hideBackButton];
    [self.mainTable setDelegateAndDataSource:self];
    _historyModelArray =[[UserDefaults sharedInstance] historyList];
    [_mainTable registarCell:@"HistoryCell" StrItem:nil];
    LazyTableBaseSection *sec = [[LazyTableBaseSection alloc]init];
    sec.headerHeight = 5;
    sec.titleHeader =@"";
    [_mainTable addSection:sec];
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
