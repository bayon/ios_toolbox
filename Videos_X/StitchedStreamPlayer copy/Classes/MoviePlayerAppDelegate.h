

#import <UIKit/UIKit.h>
#import "StreamingMovieVC.h"

@interface MoviePlayerAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
	UIWindow *window;
    StreamingMovieVC *streamingVC;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet StreamingMovieVC *streamingVC;

@end

