
#import "LeftPanelViewController.h"

@protocol CenterViewControllerDelegate <NSObject>

@optional
- (void)movePanelLeft;
- (void)movePanelRight;

@required
- (void)movePanelToOriginalPosition;

@end

@interface CenterViewController : UIViewController <LeftPanelViewControllerDelegate>

@property (nonatomic, assign) id <CenterViewControllerDelegate> delegate;
@property (nonatomic, weak) IBOutlet UIButton *leftButton;


@end
