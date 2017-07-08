 //This is THE image downloader 
#import <UIKit/UIKit.h>
//appMem
@class AppMemory;

@interface tabbartestAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
    AppMemory *theAppDataObject;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property(nonatomic,retain)AppMemory *theAppDataObject;

@end
