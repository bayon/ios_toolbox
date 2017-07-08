//
//  FBFAppDelegate.m
//  TabNavX
//
//  Created by Bayon Forte on 2/24/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "FBFAppDelegate.h"


#import "VC1.h"
#import "VC2.h"
#import "VC3.h"


@implementation FBFAppDelegate
@synthesize window, tabBarController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.tabBarController = [[UITabBarController alloc] init];


	VC1 *viewController1 = [[VC1 alloc] initWithNibName:@"VC1" bundle:nil];
	UINavigationController *navController = [[UINavigationController alloc]
	                                         initWithRootViewController:viewController1];
	VC2 *viewController2 = [[VC2 alloc] initWithNibName:@"VC2" bundle:nil];
	VC3 *viewController3 = [[VC3 alloc] initWithNibName:@"VC3" bundle:nil];
	self.tabBarController.viewControllers = [NSArray arrayWithObjects:navController, viewController2, viewController3, nil];
	//set the WINDOWS rootview controller to the tab bar controller
	self.window.rootViewController = self.tabBarController;

	[self.tabBarController setSelectedIndex:0];
	[self.window makeKeyAndVisible];
    
	[[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
	[self tabBarCustomizations];
	//STATUS BAR
	[self setStatusBarBackground];
	//detect device orientation change
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectOrientation) name:@"UIDeviceOrientationDidChangeNotification" object:nil];

	return YES;
}

- (void)tabBarCustomizations {
	tabBarController = (UITabBarController *)self.window.rootViewController;
	UITabBar *tabBar = tabBarController.tabBar;

	UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
	UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
	UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];

	UIImage *imageTB1 = [[UIImage imageNamed:@"tb1_sel.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	UIImage *imageTB1Uns = [[UIImage imageNamed:@"tb1_uns.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	tabBarItem1.image = imageTB1Uns;
	tabBarItem1.selectedImage = imageTB1;

	UIImage *imageTB2 = [[UIImage imageNamed:@"tb2_sel.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	UIImage *imageTB2Uns = [[UIImage imageNamed:@"tb2_uns.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	tabBarItem2.image = imageTB2Uns;
	tabBarItem2.selectedImage = imageTB2;

	UIImage *imageTB3 = [[UIImage imageNamed:@"tb3_sel.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	UIImage *imageTB3Uns = [[UIImage imageNamed:@"tb3_uns.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
	tabBarItem3.image = imageTB3Uns;
	tabBarItem3.selectedImage = imageTB3;

	tabBar.frame = CGRectMake(0, self.window.rootViewController.view.bounds.size.height - 43, self.window.rootViewController.view.bounds.size.width, 57);
}

- (void)setStatusBarBackground {
	UIImageView *statusBarBackgroundColorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
	statusBarBackgroundColorImage.backgroundColor = [UIColor redColor];
	[self.window.rootViewController.view addSubview:statusBarBackgroundColorImage];
	statusBarBackgroundColorImage.frame = CGRectMake(0, 0, self.window.rootViewController.view.bounds.size.width, 20);
	[self.window.rootViewController.view bringSubviewToFront:statusBarBackgroundColorImage];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
	return UIStatusBarStyleLightContent;
}

- (void)detectOrientation {
	if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) {
		//Set up left
		[self setStatusBarBackground];
		[self tabBarCustomizations];
	}
	else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight) {
		//Set up Right
		[self setStatusBarBackground];
		[self tabBarCustomizations];
	}
	else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown) {
		//It's portrait time!
		[self setStatusBarBackground];
		[self tabBarCustomizations];
	}
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
