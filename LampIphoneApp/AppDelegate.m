//
//  AppDelegate.m
//  LampIphoneApp
//
//  Created by wangbo on 13-5-27.
//  Copyright (c) 2013年 wangbo. All rights reserved.
//

#import "AppDelegate.h"

#import "IndexViewController.h"

#import "ConfigurationManager.h"

@implementation AppDelegate

@synthesize officeName = _officeName;
@synthesize window = _window;
@synthesize viewController = _viewController;

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //register user default data.
    [ConfigurationManager registerDefaultData];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[IndexViewController alloc] initWithNibName:@"IndexViewController" bundle:nil] autorelease];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.viewController];
//    nav.navigationBar.tintColor = [UIColor colorWithRed:91.0/255.0 green:199.0/255.0 blue:255.0/255.0 alpha:1];
    nav.navigationBar.tintColor = app_philips_color;

//    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor blueColor] forKey:UITextAttributeTextColor];
//    nav.navigationBar.titleTextAttributes = dict;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
