

#import <UIKit/UIKit.h>

@class AVPlayerLayer;

@interface MyPlayerLayerView : UIView {

}

@property (nonatomic, readonly) AVPlayerLayer *playerLayer;

- (void)setVideoFillMode:(NSString *)fillMode;

@end
