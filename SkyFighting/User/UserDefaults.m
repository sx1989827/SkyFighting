//
//  UserDefaults.m
//  Boss
//
//  Created by 孙昕 on 15/11/23.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "UserDefaults.h"
#import "Header.h"
@implementation UserHistory
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super init])
    {
        _date=[aDecoder decodeObjectForKey:@"date"];
        _level=[aDecoder decodeIntegerForKey:@"level"];
        _bSuccess=[aDecoder decodeIntegerForKey:@"bSuccess"];
        _killCount=[aDecoder decodeIntegerForKey:@"killCount"];
        _useTime=[aDecoder decodeIntegerForKey:@"useTime"];
        _type=[aDecoder decodeIntegerForKey:@"type"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_date forKey:@"date"];
    [aCoder encodeInteger:_level forKey:@"level"];
    [aCoder encodeInteger:_bSuccess forKey:@"bSuccess"];
    [aCoder encodeInteger:_killCount forKey:@"killCount"];
    [aCoder encodeInteger:_useTime forKey:@"useTime"];
    [aCoder encodeInteger:_type forKey:@"type"];
}
@end
@interface UserDefaults()

@end
@implementation UserDefaults
-(BOOL)isFirstLogin
{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSInteger login=[user integerForKey:@"login"];
    if(login==1)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(void)incLoginCount
{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSInteger login=[user integerForKey:@"login"];
    login++;
    [user setInteger:login forKey:@"login"];
    [user synchronize];
}

-(NSInteger)level
{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSInteger level=[user integerForKey:@"level"];
    return level;
}

-(void)addLevel
{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSInteger level=[user integerForKey:@"level"];
    level++;
    [user setInteger:level forKey:@"level"];
    [user synchronize];
}

-(NSArray<UserHistory*>*)historyList
{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSMutableArray *arr=[[NSMutableArray alloc] initWithCapacity:30];
    for(NSData *data in [user arrayForKey:@"history"])
    {
        [arr addObject:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    }
    return arr;
}

-(void)addHistory:(UserHistory*)model
{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSArray* arrTemp=[user arrayForKey:@"history"];
    NSMutableArray *arr;
    if(arrTemp==nil)
    {
        arr=[[NSMutableArray alloc] initWithCapacity:30];
    }
    else
    {
        arr=[NSMutableArray arrayWithArray:arrTemp];
    }
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:model];
    [arr addObject:data];
    [user setObject:arr forKey:@"history"];
    [user synchronize];
}

+(instancetype)sharedInstance
{
    static UserDefaults *obj=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj=[[[self class] alloc] init];
    });
    return obj;
}
@end







