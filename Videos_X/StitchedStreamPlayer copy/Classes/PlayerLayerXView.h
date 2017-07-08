

#import <UIKit/UIKit.h>

@class AVPlayerLayer;

@interface PlayerLayerXView : UIView {

}

@property (nonatomic, readonly) AVPlayerLayer *playerLayer;

- (void)setVideoFillMode:(NSString *)fillMode;

@end
