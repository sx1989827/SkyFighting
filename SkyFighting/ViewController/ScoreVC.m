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
@property(nonatomic,strong)NSMutableArray  *historyModelArray;
@end

@implementation ScoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bHud=NO;
    self.title=@"历史";
    [self hideBackButton];
    _historyModelArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    UserHistory*history = [[UserHistory alloc]init];
    history.type =1;
    history.level = 2;
    history.bSuccess = 1;
    history.killCount =23;
    history.useTime = 50;
    history.date =@"2015-12-26";
    [[UserDefaults sharedInstance] addHistory:history];
    
    [self.mainTable setDelegateAndDataSource:self];
    NSData*data = [[NSUserDefaults standardUserDefaults] objectForKey:@"history"];
    _historyModelArray =[NSKeyedUnarchiver unarchiveObjectWithData:data];
    [_mainTable registarCell:@"HistoryCell" StrItem:nil];
    LazyTableBaseSection *sec = [[LazyTableBaseSection alloc]init];
    sec.headerHeight = 10;
    sec.titleHeader =@"";
    [_mainTable addSection:sec];
    __weak ScoreVC *weakSelf = self;
    for (int i=0; i<_historyModelArray.count; i++) {
        [_mainTable addStaticCell:100 CellBlock:^(id cell) {
            UserHistory*history = [weakSelf.historyModelArray objectAtIndex:i];
            HistoryCell *cl=cell;
            cl.tyoeLabel.text = [NSString stringWithFormat:@"%d",history.type];
            cl.levelLabel.text = [NSString stringWithFormat:@"%d",history.level];
            cl.bSuccessLabel.text = [NSString stringWithFormat:@"%d",history.bSuccess];
            cl.killCountLabel.text = [NSString stringWithFormat:@"%d",history.killCount];
            cl.userTimeLabel.text = [NSString stringWithFormat:@"%d",history.useTime];
            cl.dateLabel.text = history.date;
        } ClickBlock:^(id cell) {
            
        
            
            
        }];
    }
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
