//
//  AppDelegate.m
//  KRProduct
//
//  Created by LX on 2018/1/5.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "AppDelegate.h"
#import <BaseNavigationController.h>
#import "KRProductController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    BaseNavigationController *navController = [[BaseNavigationController alloc] initWithRootViewController:[[KRProductController alloc] init]];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
