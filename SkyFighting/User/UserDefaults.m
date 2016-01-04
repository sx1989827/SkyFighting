//
//  UserDefaults.m
//  Boss
//
//  Created by 孙昕 on 15/11/23.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "UserDefaults.h"
#import "Header.h"
static NSMutableArray<LevelInfo*> *arrLevel;
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
@implementation LevelInfo
+(instancetype)info:(NSInteger)count BloodPlayer:(NSInteger)bloodPlayer BloodEnemy:(NSInteger)bloodEnemy DisplayGap:(NSInteger)displayGap FireGap:(NSInteger)fireGap BulletCount:(NSInteger)bulletCount BombCount:(NSInteger)bombCount LaserCount:(NSInteger)laserCount ProtectCount:(NSInteger)protectCount
{
    LevelInfo *info=[[LevelInfo alloc] init];
    info.count=count;
    info.bloodPlayer=bloodPlayer;
    info.bloodEnemy=bloodEnemy;
    info.displayGap=displayGap;
    info.fireGap=fireGap;
    info.bulletCount=bulletCount;
    info.bombCount=bombCount;
    info.laserCount=laserCount;
    info.protectCount=protectCount;
    return info;
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
    if(level==7)
    {
        return;
    }
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
        arrLevel=[[NSMutableArray alloc] initWithCapacity:30];
        LevelInfo *info=[LevelInfo info:5 BloodPlayer:400 BloodEnemy:100 DisplayGap:6 FireGap:5 BulletCount:200 BombCount:30 LaserCount:30 ProtectCount:10];
        [arrLevel addObject:info];
        info=[LevelInfo info:10 BloodPlayer:800 BloodEnemy:110 DisplayGap:5 FireGap:4 BulletCount:180 BombCount:25 LaserCount:25 ProtectCount:8];
        [arrLevel addObject:info];
        info=[LevelInfo info:15 BloodPlayer:1000 BloodEnemy:130 DisplayGap:5 FireGap:4 BulletCount:180 BombCount:20 LaserCount:20 ProtectCount:8];
        [arrLevel addObject:info];
        info=[LevelInfo info:20 BloodPlayer:1000 BloodEnemy:150 DisplayGap:4 FireGap:4 BulletCount:200 BombCount:20 LaserCount:20 ProtectCount:6];
        [arrLevel addObject:info];
        info=[LevelInfo info:25 BloodPlayer:1200 BloodEnemy:160 DisplayGap:4 FireGap:4 BulletCount:220 BombCount:20 LaserCount:20 ProtectCount:6];
        [arrLevel addObject:info];
        info=[LevelInfo info:30 BloodPlayer:1500 BloodEnemy:180 DisplayGap:3 FireGap:4 BulletCount:250 BombCount:20 LaserCount:20 ProtectCount:6];
        [arrLevel addObject:info];
        info=[LevelInfo info:35 BloodPlayer:1600 BloodEnemy:200 DisplayGap:3 FireGap:3 BulletCount:300 BombCount:20 LaserCount:20 ProtectCount:6];
        [arrLevel addObject:info];
        info=[LevelInfo info:40 BloodPlayer:1800 BloodEnemy:220 DisplayGap:3 FireGap:3 BulletCount:300 BombCount:15 LaserCount:15 ProtectCount:5];
        [arrLevel addObject:info];
    });
    return obj;
}

-(LevelInfo*)levelInfo:(NSInteger)level
{
    return arrLevel[level];
}

-(void)resetLevel
{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    [user setInteger:0 forKey:@"level"];
    [user synchronize];
}

-(void)removeAllHistory
{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    [user removeObjectForKey:@"history"];
    [user synchronize];
}
@end







