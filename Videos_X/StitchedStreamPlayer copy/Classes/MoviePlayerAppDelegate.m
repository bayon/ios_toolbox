
#import "MoviePlayerAppDelegate.h"

@class StreamingMovieVC;

@implementation MoviePlayerAppDelegate

@synthesize window;
@synthesize streamingVC;

- (void)applicationDidFinishLaunching:(UIApplication *)application 
{	
    [window addSubview:streamingVC.view];
    [window makeKeyAndVisible];
}



@end
