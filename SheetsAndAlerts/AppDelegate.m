//
//  AppDelegate.m
//  SheetsAndAlerts
//
//  Created by Peter JC Spencer on 18/08/2015.
//  Copyright (c) 2015 Spencer's digital media. All rights reserved.
//

#import "AppDelegate.h"

#import "sdmRootController.h"


@implementation AppDelegate


#pragma mark - UIApplicationDelegate Protocol

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Create window and root controller.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[sdmRootController alloc] initWithNibName:nil bundle:nil];
    self.window.backgroundColor = [UIColor colorWithWhite:0.1f alpha:1.0f];
    
    // Display window.
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end


