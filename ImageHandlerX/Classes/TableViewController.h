#import <UIKit/UIKit.h>
//mem
#import "AppMemory.h"

@interface TableViewController : UIViewController {
	
	NSString *selectedCellItem;
    NSMutableData *mutableData;
    NSURLConnection *urlConnection;
    NSMutableArray *mutableArray;
}

@property (nonatomic, retain) NSString *selectedCellItem;
@property(nonatomic,retain)  NSMutableData *mutableData;
@property(nonatomic,retain)  NSURLConnection *urlConnection;
@property(nonatomic,retain)  NSMutableArray *mutableArray;

@end
