

#import <UIKit/UIKit.h>
#import "MyStreamingMovieViewController.h"

@interface MoviePlayerAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
	UIWindow *window;
    MyStreamingMovieViewController *streamingViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MyStreamingMovieViewController *streamingViewController;

@end

