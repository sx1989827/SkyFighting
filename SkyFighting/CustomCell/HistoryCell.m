//
//  HistoryCell.m
//  SkyFighting
//
//  Created by lxx on 15/12/26.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "HistoryCell.h"
#import "HistoryItem.h"
@implementation HistoryCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(NSNumber*)LazyTableCellHeight:(id)item Path:(NSIndexPath *)path
{
    return @100;
}
-(void)LazyTableCellForRowAtIndexPath:(id)item Path:(NSIndexPath *)path
{
    HistoryItem*data = item;
    self.tyoeLabel.text = data.type;
    self.levelLabel.text = data.level;
    self.bSuccessLabel.text = data.bSuccess;
    self.killCountLabel.text = data.killCount;
    self.userTimeLabel.text = data.userTime;
    self.dateLabel.text = data.date;
}
@end
