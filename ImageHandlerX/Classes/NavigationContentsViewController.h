#import <UIKit/UIKit.h>
#import "AppMemory.h"
#define myAppDelegate (AppDelegate *) [[UIApplication sharedApplication] delegate]
@interface NavigationContentsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {

	NSMutableArray *imagesArray;
	UITableView *imageTableView;
    NSMutableData *downloadData;
    NSURLConnection *urlConnection;
    NSMutableArray *mutableArray;
	
}

@property(nonatomic,retain) NSMutableArray *imagesArray;
@property(nonatomic,retain) UITableView *imageTableView;
@property(nonatomic,retain)  NSMutableData *downloadData;
@property(nonatomic,retain)  NSURLConnection *urlConnection;
@property(nonatomic,retain)  NSMutableArray *mutableArray;

@end
