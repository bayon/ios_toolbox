
#import <UIKit/UIKit.h>

@class Animal;

@protocol LeftPanelViewControllerDelegate <NSObject>

@optional
- (void)imageSelected:(UIImage *)image withTitle:(NSString *)imageTitle withCreator:(NSString *)imageCreator;

@required
- (void)animalSelected:(Animal *)animal;

@end

@interface LeftPanelViewController : UIViewController

@property (nonatomic, assign) id <LeftPanelViewControllerDelegate> delegate;

@end
