//
//  FBFAppDelegate.m
//  SlideInMenuX
//
//  Created by Bayon Forte on 2/24/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "FBFAppDelegate.h"
#import "MainViewController.h"

@implementation FBFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    //STATUS BAR
	//[self setStatusBarBackground];
    [self.window makeKeyAndVisible];
    return YES;

}
- (void)setStatusBarBackground {
	UIImageView *statusBarBackgroundColorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
	statusBarBackgroundColorImage.backgroundColor = [UIColor blackColor];
	[self.window.rootViewController.view addSubview:statusBarBackgroundColorImage];
	statusBarBackgroundColorImage.frame = CGRectMake(0, 0, self.window.rootViewController.view.bounds.size.width, 20);
	[self.window.rootViewController.view bringSubviewToFront:statusBarBackgroundColorImage];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
   
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

@end
