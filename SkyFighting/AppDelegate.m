//
//  AppDelegate.m
//  SkyFighting
//
//  Created by 孙昕 on 15/12/24.
//  Copyright © 2015年 孙昕. All rights reserved.
//

#import "AppDelegate.h"
#import "Header.h"
#import "MainTabVC.h"
#import "InStroVC.h"
#import "UserDefaults.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [[UINavigationBar appearance] setBarTintColor:COL(10,140,225,1.0)];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UserDefaults sharedInstance] incLoginCount];
    if ([[UserDefaults sharedInstance] isFirstLogin]) {
        InStroVC *loadView = [[InStroVC alloc]init];
        self.window.rootViewController = loadView;
    }
    else
    {
        UITabBarController *tab=[[MainTabVC alloc] init];
        self.window.rootViewController=tab;
    }
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
