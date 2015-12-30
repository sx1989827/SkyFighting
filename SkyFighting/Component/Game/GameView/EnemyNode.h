//
//  EnemyNode.h
//  SkyFighting
//
//  Created by 孙昕 on 15/12/27.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <SceneKit/SceneKit.h>

@interface EnemyNode : SCNNode
@property (assign,nonatomic) NSInteger raderID;
@property (assign,nonatomic) NSInteger blood;
-(void)fire;
@end
