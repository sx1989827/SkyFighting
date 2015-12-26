//
//  HistoryItem.h
//  SkyFighting
//
//  Created by lxx on 15/12/26.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <LazyTableView/LazyTableView.h>
#import <LazyTableBaseItem.h>
#import "UserDefaults.h"
@interface HistoryItem : LazyTableBaseItem
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *level;
@property(nonatomic,strong)NSString *bSuccess;
@property(nonatomic,strong)NSString *killCount;
@property(nonatomic,strong)NSString *userTime;
@property(nonatomic,strong)NSString *date;
@end
