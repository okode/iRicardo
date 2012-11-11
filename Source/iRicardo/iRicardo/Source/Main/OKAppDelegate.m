//
//  OKAppDelegate.m
//  iRicardo
//
//  Created by Daniel Soro Coicaud on 20/10/12.
//  Copyright (c) 2012 Daniel Soro Coicaud. All rights reserved.
//

#import "OKAppDelegate.h"
#import "OKGameViewController.h"
#import "OKTask.h"

@implementation OKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    OKGameViewController *controller = [[OKGameViewController alloc] init];
    self.window.rootViewController = controller;
    
    [self.window makeKeyAndVisible];    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}

- (void)applicationDidEnterBackground:(UIApplication *)application {}

- (void)applicationWillEnterForeground:(UIApplication *)application {}

- (void)applicationDidBecomeActive:(UIApplication *)application {}

- (void)applicationWillTerminate:(UIApplication *)application {}

@end
