//
//  GameView.m
//  SkyFighting
//
//  Created by 孙昕 on 15/12/27.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "GameView.h"
#import "RaderView.h"

@import GLKit;
@import AVFoundation;
@import CoreMotion;
CGFloat const gestureMinimumTranslation = 20.0 ;
typedef enum : NSInteger {
    
    kCameraMoveDirectionNone,
    
    kCameraMoveDirectionUp,
    
    kCameraMoveDirectionDown,
    
    kCameraMoveDirectionRight,
    
    kCameraMoveDirectionLeft
    
} CameraMoveDirection ;
@interface GameView()<SCNPhysicsContactDelegate>
{
    SCNNode *camera;
    NSTimeInterval currentTime;
    SCNNode *newNode;
    CMAttitude *atti;
    SCNNode *ship;
    NSTimer *timer;
    NSMutableArray *arrEnemy;
    NSMutableArray *arrPan;
    CADisplayLink *link;
    CAShapeLayer *layerPan;
    UIBezierPath *panPath;
    CameraMoveDirection direction;
    NSMutableArray *arrDirection;
    RaderView *viewRader;
    SCNView *viewScene;
}
@property (nonatomic, strong)       AVCaptureSession            * session;
@property (nonatomic, strong)       AVCaptureDeviceInput        * videoInput;
@property (nonatomic, strong)       AVCaptureStillImageOutput   * stillImageOutput;
@property (nonatomic, strong)       AVCaptureVideoPreviewLayer  * previewLayer;
@property (nonatomic, strong)       UIBarButtonItem             * toggleButton;
@property (nonatomic, strong)       UIButton                    * shutterButton;
@property (nonatomic, strong)       UIView                      * cameraShowView;
@property (nonatomic,strong) CMMotionManager* manager;
@end
@implementation GameView
-(void)setup
{
    viewScene=[[SCNView alloc] initWithFrame:self.bounds];
    viewScene.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addSubview:viewScene];
    viewRader=[[RaderView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    viewRader.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:viewRader];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-8-[viewRader(==100)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(viewRader)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[viewRader(==100)]-8-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(viewRader)]];
    [self initialSession];
    _manager=[[CMMotionManager alloc]init];
    if ([_manager isAccelerometerAvailable]) {
        [_manager setDeviceMotionUpdateInterval:1/60.0f];
        currentTime= [[NSDate date] timeIntervalSince1970]*1000;
        __block CMAttitude *initialAttitude = _manager.deviceMotion.attitude;
        GameView * __weak weakSelf = self;
        if (_manager.deviceMotionAvailable) {
            [_manager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                                          withHandler:^(CMDeviceMotion *data, NSError *error) {
                                              if(initialAttitude==nil)
                                              {
                                                  initialAttitude = _manager.deviceMotion.attitude;
                                                  [weakSelf initScene];
                                                  return;
                                              }
                                              [data.attitude multiplyByInverseOfAttitude:initialAttitude];
                                              atti=data.attitude;
                                              if(data.attitude.roll<-M_PI_2 || data.attitude.roll>M_PI_2)
                                              {
                                                  [camera runAction:[SCNAction rotateToX: -data.attitude.pitch y:data.attitude.roll z:data.attitude.yaw duration:0]];
                                              }
                                              else
                                              {
                                                  [camera runAction:[SCNAction rotateToX: data.attitude.pitch y:data.attitude.roll z:data.attitude.yaw duration:0]];
                                              }
                                              
                                              [viewRader setRorate:data.attitude.roll];
                                          }];
        }
    }
    arrEnemy=[[NSMutableArray alloc] initWithCapacity:30];
    arrPan=[[NSMutableArray alloc] initWithCapacity:30];
    arrDirection=[[NSMutableArray alloc] initWithCapacity:30];
    timer=[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateRader) userInfo:nil repeats:YES];
    layerPan=[CAShapeLayer layer];
    layerPan.lineWidth =  8.0f;
    layerPan.lineCap = kCALineCapRound;
    layerPan.lineJoin = kCALineJoinRound;
    layerPan.fillColor=[UIColor clearColor].CGColor;
    [self.layer addSublayer:layerPan];
    [self setUpCameraLayer];
    if (self.session) {
        [self.session startRunning];
    }
}

-(instancetype)init
{
    if(self=[super init])
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

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super initWithCoder:aDecoder])
    {
        [self setup];
    }
    return self;
}

- (void) initialSession
{
    self.session = [[AVCaptureSession alloc] init];
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self backCamera] error:nil];
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary * outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }
    if ([self.session canAddOutput:self.stillImageOutput]) {
        [self.session addOutput:self.stillImageOutput];
    }
    
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            return device;
        }
    }
    return nil;
}


- (AVCaptureDevice *)frontCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}

- (AVCaptureDevice *)backCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
}

- (void) setUpCameraLayer
{
    if (self.previewLayer == nil) {
        self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        UIView * view = self;
        CALayer * viewLayer = [view layer];
        [viewLayer setMasksToBounds:YES];
        [self.previewLayer setFrame:[UIScreen mainScreen].bounds];
        [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
        
        [viewLayer insertSublayer:self.previewLayer below:[[viewLayer sublayers] objectAtIndex:0]];
        
    }
}

-(void)updateRader
{
    float len=sqrt(pow(newNode.position.x, 2)+pow(newNode.position.z, 2));
    [viewRader updateSpot:0 Len:len];
}

-(void)initScene
{
    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/ship.scn"];
    scene.physicsWorld.gravity=SCNVector3Make(0, -6, 0);
    scene.physicsWorld.contactDelegate=self;
    camera = [SCNNode node];
    camera.camera=[SCNCamera camera];
    camera.camera.automaticallyAdjustsZRange=YES;
    camera.camera.zFar=1000;
    camera.camera.xFov=45;
    camera.camera.yFov=45;
    [scene.rootNode addChildNode:camera];
    camera.position = SCNVector3Make(0, 0, 0);
    SCNNode *lightNode = [SCNNode node];
    lightNode.light = [SCNLight light];
    lightNode.light.type = SCNLightTypeOmni;
    lightNode.position = SCNVector3Make(0, 10, 10);
    [scene.rootNode addChildNode:lightNode];
    SCNNode *ambientLightNode = [SCNNode node];
    ambientLightNode.light = [SCNLight light];
    ambientLightNode.light.type = SCNLightTypeAmbient;
    ambientLightNode.light.color = [UIColor darkGrayColor];
    [scene.rootNode addChildNode:ambientLightNode];
    ship = [scene.rootNode childNodeWithName:@"ship" recursively:YES];
    newNode=[ship clone];
    newNode.hidden=NO;
    newNode.position=SCNVector3Make(-30,-10, 60);
    newNode.physicsBody=[SCNPhysicsBody bodyWithType:SCNPhysicsBodyTypeDynamic shape:[SCNPhysicsShape shapeWithNode:newNode options:nil]];
    newNode.physicsBody.affectedByGravity=NO;
    newNode.physicsBody.categoryBitMask=0x1;
    newNode.physicsBody.contactTestBitMask=0x2;
    [scene.rootNode addChildNode:newNode];
    float rX,rY;
    rX=fabs(atanf(newNode.position.y/sqrt(pow(newNode.position.x,2)+pow(newNode.position.z,2))));
    if(newNode.position.y>0 && newNode.position.z>0)
    {
        rX=rX;
    }
    else if(newNode.position.y>0 && newNode.position.z<0)
    {
        rX=rX;
    }
    else if(newNode.position.y<0 && newNode.position.z>0)
    {
        rX=-rX;
    }
    else if(newNode.position.y<0 && newNode.position.z<0)
    {
        rX=-rX;
    }
    rY=fabs(atanf(newNode.position.x/newNode.position.z));
    if(newNode.position.x>0 && newNode.position.z>0)
    {
        rY=M_PI+ rY;
    }
    else if(newNode.position.x>0 && newNode.position.z<0)
    {
        rY=-rY;
    }
    else if(newNode.position.x<0 && newNode.position.z>0)
    {
        rY=M_PI- rY;
    }
    else if(newNode.position.x<0 && newNode.position.z<0)
    {
        rY=rY;
    }
    GLKMatrix4 mat=GLKMatrix4MakeRotation(rY, 0, 1, 0);
    mat=GLKMatrix4InvertAndTranspose(mat, NULL);
    GLKVector3 normal=GLKVector3Make(1, 0, 0);
    normal=GLKMatrix4MultiplyVector3(mat, normal);
    [newNode runAction:[SCNAction sequence:@[[SCNAction rotateByX:0 y:rY z:0 duration:0],[SCNAction rotateByAngle:rX aroundAxis:SCNVector3Make(normal.x, normal.y, normal.z) duration:0]]]];
    [newNode runAction:[SCNAction moveTo:SCNVector3Make(0, 0, 0) duration:10]];
    [viewRader setRadius:200];
    float len=sqrt(pow(newNode.position.x, 2)+pow(newNode.position.z, 2));
    [viewRader addSpot:rY Len:len];
    SCNView *scnView = (SCNView *)viewScene;
    scnView.scene = scene;
    scnView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    NSMutableArray *gestureRecognizers = [NSMutableArray array];
    [gestureRecognizers addObject:tapGesture];
    [gestureRecognizers addObjectsFromArray:scnView.gestureRecognizers];
    scnView.gestureRecognizers = gestureRecognizers;
    [self addGestureRecognizer:panGesture];
}

-(void)handlePan:(UIPanGestureRecognizer*)gestureRecognize
{
    CGPoint pointLoc=[gestureRecognize locationInView:self];
    [arrPan addObject:[NSValue valueWithCGPoint:pointLoc]];
    if(gestureRecognize.state==UIGestureRecognizerStateBegan)
    {
        [arrPan removeAllObjects];
        [arrDirection removeAllObjects];
        if(link!=nil)
        {
            [link invalidate];
        }
        link=[CADisplayLink displayLinkWithTarget:self selector:@selector(drawPan:)];
        [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        direction = kCameraMoveDirectionNone;
    }
    else if(gestureRecognize.state==UIGestureRecognizerStateEnded || gestureRecognize.state==UIGestureRecognizerStateCancelled)
    {
        [link invalidate];
        link=nil;
        layerPan.opacity=0;
        CABasicAnimation *ani=[CABasicAnimation animationWithKeyPath:@"opacity"];
        ani.toValue=@(0);
        ani.duration = 0.8;
        [layerPan addAnimation:ani forKey:nil];
        if(arrDirection.count==2 && [arrDirection[0] integerValue]==kCameraMoveDirectionDown && [arrDirection[1] integerValue]==kCameraMoveDirectionRight)
        {
            NSLog(@"leftright");
        }
        else if(arrDirection.count>=8 && arrDirection.count<=10)
        {
            int down=0,left=0,right=0,up=0;
            for(int i=0;i<arrDirection.count;i++)
            {
                if([arrDirection[i] integerValue]==kCameraMoveDirectionDown)
                {
                    down++;
                }
                else if([arrDirection[i] integerValue]==kCameraMoveDirectionLeft)
                {
                    left++;
                }
                else if([arrDirection[i] integerValue]==kCameraMoveDirectionRight)
                {
                    right++;
                }
                else if([arrDirection[i] integerValue]==kCameraMoveDirectionUp)
                {
                    up++;
                }
            }
            if(up==0 && down>=4 && left>=2 && right>=2)
            {
                NSLog(@"wujiaoxing");
            }
        }
    }
    else if (gestureRecognize.state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [gestureRecognize translationInView: self];
        direction = [ self determineCameraDirectionIfNeeded:translation];
        if(direction==kCameraMoveDirectionNone)
        {
            return;
        }
        else if(arrDirection.count==0)
        {
            [arrDirection addObject:@(direction)];
        }
        else if([[arrDirection lastObject] integerValue]!=direction)
        {
            [arrDirection addObject:@(direction)];
        }
    }
    
}

- ( CameraMoveDirection )determineCameraDirectionIfNeeded:( CGPoint )translation
{
    if (fabs(translation.x) > gestureMinimumTranslation)
    {
        BOOL gestureHorizontal = NO;
        if (translation.y == 0.0 )
            gestureHorizontal = YES;
        else
            gestureHorizontal = (fabs(translation.x) > 10.0 );
        if (gestureHorizontal)
        {
            if (translation.x > 0.0 )
                return kCameraMoveDirectionRight;
            else
                return kCameraMoveDirectionLeft;
        }
    }
    else if (fabs(translation.y) > gestureMinimumTranslation)
    {
        BOOL gestureVertical = NO;
        if (translation.x == 0.0 )
            gestureVertical = YES;
        else
            gestureVertical = (fabs(translation.y) > 10.0 );
        if (gestureVertical)
        {
            if (translation.y > 0.0 )
                return kCameraMoveDirectionDown;
            else
                return kCameraMoveDirectionUp;
        }
    }
    return direction;
}

-(void)drawPan:(CADisplayLink*)disLink
{
    if(arrPan.count==0)
    {
        return;
    }
    panPath=[UIBezierPath bezierPath];
    [panPath moveToPoint:[arrPan[0] CGPointValue]];
    for(int i=1;i<arrPan.count;i++)
        [panPath addLineToPoint:[arrPan[i] CGPointValue]];
    layerPan.strokeColor = [UIColor colorWithRed:0.145 green:0.600 blue:1.000 alpha:1.000].CGColor;
    layerPan.opacity=0.9;
    layerPan.path=panPath.CGPath;
    
}

- (void) handleTap:(UIGestureRecognizer*)gestureRecognize
{
    SCNView *scnView = viewScene;
    SCNBox *box=[SCNBox boxWithWidth:0.1 height:0.1 length:0.2 chamferRadius:5];
    box.firstMaterial.diffuse.contents=[UIColor redColor];
    SCNNode *node=[SCNNode nodeWithGeometry:box];
    node.physicsBody=[SCNPhysicsBody bodyWithType:SCNPhysicsBodyTypeDynamic shape:[SCNPhysicsShape shapeWithNode:node options:nil]];
    node.physicsBody.categoryBitMask=0x2;
    node.physicsBody.contactTestBitMask=0x1;
    node.position=SCNVector3Make(0, -1, 0);
    node.physicsBody.affectedByGravity=NO;
    [scnView.scene.rootNode addChildNode:node];
    float y,temp;
    if(atti.roll<-M_PI_2 || atti.roll>M_PI_2)
    {
        y=1000*sin(-atti.pitch);
        temp=1000*cos(-atti.pitch);
    }
    else
    {
        y=1000*sin(atti.pitch);
        temp=1000*cos(atti.pitch);
    }
    float x=-temp*sin(atti.roll);
    float z=-temp*cos(atti.roll);
    GLKVector3 vec=GLKVector3Make(x, y, z);
    GLKMatrix4 mat=GLKMatrix4MakeRotation(atti.yaw, 0, 0, 1);
    vec=GLKMatrix4MultiplyVector3(mat, vec);
    [node runAction:[SCNAction sequence:@[[SCNAction rotateToX: atti.pitch y:atti.roll z:atti.yaw duration:0],[SCNAction moveTo:SCNVector3Make(vec.x,vec.y, vec.z) duration:30],[SCNAction removeFromParentNode]]]];
}

-(void)physicsWorld:(SCNPhysicsWorld *)world didBeginContact:(SCNPhysicsContact *)contact
{
    newNode.physicsBody.categoryBitMask=0;
    [newNode removeAllActions];
    newNode.physicsBody.affectedByGravity=YES;
    [viewRader removeSpot:0];
}

-(void)dealloc
{
    if (self.session) {
        [self.session stopRunning];
    }
}
@end










