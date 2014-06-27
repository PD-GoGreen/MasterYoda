//
//  AppDelegate.m
//  MasterYoda
//
//  Created by Pradnya on 4/15/14.
//  Copyright (c) 2014 Pradnya. All rights reserved.
//

#import "MasterYodaAppDelegate.h"
#import "MasterYodaViewController.h"
#import "UIColor+Hex.h"

@implementation MasterYodaAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[MasterYodaViewController alloc] init]];
    self.window.rootViewController = self.rootViewController;
    [self.window makeKeyAndVisible];
    
    [self customisedAppearance];
    [self initalizeVendors];

    return YES;
}

- (void)customisedAppearance{
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:COLOR_GRAY_2]];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithHexString:COLOR_WHITE_1]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:FONT_BOLD size:15],
                                                           NSForegroundColorAttributeName:[UIColor colorWithHexString:COLOR_WHITE_1]}];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:FONT_BOLD size:15.0]}
                                                forState:UIControlStateNormal];
    
    [[UIToolbar appearance] setBarTintColor:[UIColor colorWithHexString:COLOR_GRAY_2]];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)initalizeVendors{
    //Initalize Vendors
}

@end
