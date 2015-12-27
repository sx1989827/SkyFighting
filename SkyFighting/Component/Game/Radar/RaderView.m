//
//  RaderView.m
//  testCamera
//
//  Created by 孙昕 on 15/12/22.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "RaderView.h"
@interface RaderView()
{
    float radius;
    float realRadius;
    CAShapeLayer *layerPoint;
    NSMutableDictionary *dic;
    NSInteger index;
    UIView *viewArc;
    float lastAngle;
}
@end
@implementation RaderView
-(void)setup
{
    dic=[[NSMutableDictionary alloc] initWithCapacity:30];
    self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    radius=self.bounds.size.width/2.0-2;
    viewArc=[[UIView alloc] initWithFrame:self.bounds];
    viewArc.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    viewArc.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [self addSubview:viewArc];
    layerPoint=[CAShapeLayer layer];
    layerPoint.fillColor = [UIColor colorWithRed:231/255.0f green:179/255.0f blue:37/255.0f alpha:0.7].CGColor;
    layerPoint.lineCap = kCALineCapRound;
    layerPoint.lineJoin = kCALineJoinRound;
    layerPoint.strokeStart=0;
    layerPoint.strokeEnd=1;
    [viewArc.layer addSublayer:layerPoint];
    layerPoint.anchorPoint=CGPointMake(0.5, 0.5);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0)];
    [path addArcWithCenter:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0) radius:radius startAngle:-M_PI_2+-M_PI_4/2 endAngle:-M_PI_2+M_PI_4/2 clockwise:YES];
    layerPoint.path=path.CGPath;
}

-(instancetype)init
{
    if(self=[super init])
    {
        [self setup];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super initWithCoder:aDecoder])
    {
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetRGBStrokeColor(context, 0,1,0,0.5);
    CGContextSetRGBFillColor(context, 0,1,0,0.7);
    CGContextAddArc(context, self.bounds.size.width/2.0, self.bounds.size.height/2.0, radius, 0, 2*M_PI, 0);
    CGContextDrawPath(context, kCGPathFillStroke);
    for(NSNumber *key in dic)
    {
        NSDictionary *d=dic[key];
        float angel=[d[@"angle"] floatValue];
        float len=[d[@"len"] floatValue];
        if(len>=1)
        {
            continue;
        }
        float length=radius*len;
        float x=self.bounds.size.width/2- length *sin(angel);
        float y=self.bounds.size.height/2- length *cos(angel);
        CGContextSetRGBFillColor(context, 1,0,0,0.9);
        CGContextAddArc(context, x,y, 2, 0, 2*M_PI, 0);
        CGContextDrawPath(context, kCGPathFillStroke);
    }
}

-(void)setRadius:(CGFloat)radius
{
    realRadius=radius;
}

-(void)setRorate:(float)angle
{
    viewArc.transform=CGAffineTransformMakeRotation(-angle);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = @(-angle);
    animation.duration = 0.1;
    [viewArc.layer addAnimation:animation forKey:@"rotation"];
}

-(NSInteger)addSpot:(float)angle Len:(float)len
{
    [dic setObject:[NSMutableDictionary dictionaryWithDictionary: @{
                    @"angle":@(angle),
                    @"len":@(len/realRadius)
                     }] forKey:@(index++)];
    [self setNeedsDisplay];
    return index-1;
}

-(void)updateSpot:(NSInteger)id Len:(float)len
{
    NSMutableDictionary *d=dic[@(id)];
    if(d==nil)
    {
        return;
    }
    d[@"len"]=@(len/realRadius);
    [self setNeedsDisplay];
}

-(void)removeSpot:(NSInteger)id
{
    [dic removeObjectForKey:@(id)];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setNeedsDisplay];
    });
    
}
@end











