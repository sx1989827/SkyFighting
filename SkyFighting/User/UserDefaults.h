//
//  UserDefaults.h
//  Boss
//
//  Created by 孙昕 on 15/11/23.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UserHistory:NSObject<NSCoding>
@property (strong,nonatomic) NSString *date;
@property (assign,nonatomic) NSInteger level;
@property (assign,nonatomic) NSInteger bSuccess;
@property (assign,nonatomic) NSInteger killCount;
@property (assign,nonatomic) NSInteger useTime;
@property (assign,nonatomic) NSInteger type;
@end
@interface LevelInfo : NSObject
@property (assign,nonatomic) NSInteger count;
@property (assign,nonatomic) NSInteger bloodPlayer;
@property (assign,nonatomic) NSInteger bloodEnemy;
@property (assign,nonatomic) NSInteger displayGap;
@property (assign,nonatomic) NSInteger fireGap;
@property (assign,nonatomic) NSInteger bulletCount;
@property (assign,nonatomic) NSInteger bombCount;
@property (assign,nonatomic) NSInteger laserCount;
@property (assign,nonatomic) NSInteger protectCount;
+(instancetype)info:(NSInteger)count BloodPlayer:(NSInteger)bloodPlayer BloodEnemy:(NSInteger)bloodEnemy DisplayGap:(NSInteger)displayGap FireGap:(NSInteger)fireGap BulletCount:(NSInteger)bulletCount BombCount:(NSInteger)bombCount LaserCount:(NSInteger)laserCount ProtectCount:(NSInteger)protectCount;
@end
@interface UserDefaults : NSObject
-(BOOL)isFirstLogin;
-(void)incLoginCount;
-(NSInteger)level;
-(void)addLevel;
-(void)resetLevel;
-(NSArray<UserHistory*>*)historyList;
-(void)addHistory:(UserHistory*)model;
-(void)removeAllHistory;
-(LevelInfo*)levelInfo:(NSInteger)level;
+(instancetype)sharedInstance;
@end





