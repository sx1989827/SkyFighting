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
@interface UserDefaults : NSObject
-(BOOL)isFirstLogin;
-(void)incLoginCount;
-(NSInteger)level;
-(void)addLevel;
-(NSArray<UserHistory*>*)historyList;
-(void)addHistory:(UserHistory*)model;
+(instancetype)sharedInstance;
@end





