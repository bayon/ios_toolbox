#import "tabbartestAppDelegate.h"
//MEMORY (delegate.m)
#import "AppDelegateProtocol.h"
#import "AppMemory.h"

@implementation tabbartestAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize theAppDataObject;

-(id)init{
    self.theAppDataObject = [[AppMemory alloc]init];
    return [super init];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    [window addSubview:tabBarController.view];
    [window makeKeyAndVisible];

	return YES;
}





@end

