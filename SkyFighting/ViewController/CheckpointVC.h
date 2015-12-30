//
//  CheckpointVC.h
//  SkyFighting
//
//  Created by lxx on 15/12/29.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <LazyTableView.h>
@interface CheckpointVC : BaseViewController
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet LazyTableView *mainTableView;
@end
