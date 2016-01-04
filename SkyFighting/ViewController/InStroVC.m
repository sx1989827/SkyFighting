//
//  LoadViewController.m
//  SkyFighting
//
//  Created by lxx on 15/12/27.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "InStroVC.h"
#import "UserDefaults.h"
#import "MainTabVC.h"
#import "Util.h"

@interface InStroVC ()
@property(strong,nonatomic)UIImageView*firstImageVeiw;
@property(strong,nonatomic)UIImageView*secindImageView;
@property(strong,nonatomic)UIImageView*thirdImageView;
@property(strong,nonatomic)UIImageView*fourImageView;
@property(assign,nonatomic)NSInteger count;//记录滑动的次数
@end
@implementation InStroVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _fourImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    _fourImageView.userInteractionEnabled = YES;
    _fourImageView.tag = 104;
    _fourImageView.backgroundColor = [UIColor greenColor];
    _fourImageView.image=[UIImage imageNamed:@"fourLoad"];
    [self.view addSubview:_fourImageView];
    _thirdImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    _thirdImageView.userInteractionEnabled = YES;
    _thirdImageView.tag = 102;
    _thirdImageView.backgroundColor = [UIColor yellowColor];
    _thirdImageView.image=[UIImage imageNamed:@"thirdLoad"];
    [self.view addSubview:_thirdImageView];
    _secindImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    _secindImageView.userInteractionEnabled = YES;
    _secindImageView.tag =101;
    _secindImageView.image= [UIImage imageNamed:@"secondLoad"];
    [self.view addSubview:_secindImageView];
    _firstImageVeiw = [[UIImageView alloc]initWithFrame:self.view.bounds];
    _firstImageVeiw.userInteractionEnabled = YES;
    _firstImageVeiw.tag =100;
    _firstImageVeiw.image= [UIImage imageNamed:@"firstLoad"];
    [self.view addSubview:_firstImageVeiw];
    //向右划
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] init];
    [rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [rightSwipe addTarget:self action:@selector(rightSwipe)];
    [self.view addGestureRecognizer:rightSwipe];
    //向左划
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]init];
    [leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [leftSwipe addTarget:self action:@selector(leftSwipe)];
    [self.view addGestureRecognizer:leftSwipe];
    self.count= 0;
}
-(void)rightSwipe
{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.8;
    animation.type = @"cube";
    animation.subtype = kCATransitionFromLeft;
    switch (self.count) {
        case 0:
        {
            
         break;
        }
        case 1:
        {
             [self.view bringSubviewToFront:self.firstImageVeiw];
             [self.view.layer addAnimation:animation forKey:@"animation"];
            break;
        }
        case 2:
        {
             [self.view bringSubviewToFront:self.secindImageView];
             [self.view.layer addAnimation:animation forKey:@"animation"];
            break;
        }
        case 3:
        {
             [self.view bringSubviewToFront:self.thirdImageView];
             [self.view.layer addAnimation:animation forKey:@"animation"];
            break;
        }
        default:
            break;
    }
    self.count--;
    if (self.count<=0) {
        self.count=0;
    }
}
-(void)leftSwipe
{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.8;
    animation.type = @"cube";
    animation.subtype = kCATransitionFromRight;
    switch (self.count) {
        case 0:
        {
            [self.view bringSubviewToFront:self.secindImageView];
             [self.view.layer addAnimation:animation forKey:@"animation"];
            break;
        }
        case 1:
        {
            [self.view bringSubviewToFront:self.thirdImageView];
            [self.view.layer addAnimation:animation forKey:@"animation"];
            break;
        }
        case 2:
        {
            [self.view bringSubviewToFront:self.fourImageView];
            [self.view.layer addAnimation:animation forKey:@"animation"];
            break;
        }
        case 3:
        {
            UITabBarController *tab=[[MainTabVC alloc] init];
            UIWindow *window = [[UIApplication sharedApplication]keyWindow];
            window.rootViewController = tab;
            [self dismiss];
            break;
        }
        default:
            break;
    }
    self.count++;
    if (self.count>=3) {
        self.count=3;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
