//
//  HistoryItem.m
//  SkyFighting
//
//  Created by lxx on 15/12/26.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "HistoryItem.h"

@implementation HistoryItem
+(JSONKeyMapper*)keyMapper
{
    NSData*data = [[NSUserDefaults standardUserDefaults] objectForKey:@"history"];
    UserHistory*history =[NSKeyedUnarchiver unarchiveObjectWithData:data];
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"level": [NSString stringWithFormat:@"%d",history.level],
                                                       @"type":[NSString stringWithFormat:@"%d",history.type],
                                                       @"bSuccess": [NSString stringWithFormat:@"%d",history.bSuccess],
                                                       @"killCount": [NSString stringWithFormat:@"%d",history.killCount],
                                                       @"userTime":[NSString stringWithFormat:@"%d",history.useTime],
                                                       @"date":history.date
                                                       }];
}
@end
