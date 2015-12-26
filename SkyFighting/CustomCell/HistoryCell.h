//
//  HistoryCell.h
//  SkyFighting
//
//  Created by lxx on 15/12/26.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <LazyTableView/LazyTableView.h>
#import <LazyTableCell.h>

@interface HistoryCell : LazyTableCell
@property (strong, nonatomic) IBOutlet UILabel *tyoeLabel;
@property (strong, nonatomic) IBOutlet UILabel *levelLabel;
@property (strong, nonatomic) IBOutlet UILabel *killCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *bSuccessLabel;
@property (strong, nonatomic) IBOutlet UILabel *userTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@end
