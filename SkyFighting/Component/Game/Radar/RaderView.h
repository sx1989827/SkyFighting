//
//  RaderView.h
//  testCamera
//
//  Created by 孙昕 on 15/12/22.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RaderView : UIView
-(void)setRadius:(CGFloat)radius;
-(void)setRorate:(float)angle;
-(NSInteger)addSpot:(float)angle Len:(float)len;
-(void)updateSpot:(NSInteger)id Len:(float)len;
-(void)removeSpot:(NSInteger)id;
@end
