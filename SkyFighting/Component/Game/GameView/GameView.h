//
//  GameView.h
//  SkyFighting
//
//  Created by 孙昕 on 15/12/27.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <UIKit/UIKit.h>
@import SceneKit;
@protocol GameViewDelegate <NSObject>
-(void)GameViewFinish:(BOOL)bSuccess KillCount:(NSInteger)count;
@end
@interface GameView : UIView
-(void)start;
-(void)pause;
-(void)resume;
-(void)setup:(NSInteger)count PlayerBlood:(NSInteger)playerBlood EnemyBlood:(NSInteger)enemyBlood DispalyGap:(float)displayGap FireGap:(float)fireGap BulletCount:(NSInteger)bullet BombCount:(NSInteger)bomb LaserCount:(NSInteger)laser ProtectCount:(NSInteger)protect;
@property (weak,nonatomic) id<GameViewDelegate> delegate;
@end
