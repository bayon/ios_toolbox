

#import "VideoPlayerView.h"
#import <AVFoundation/AVFoundation.h>

@implementation VideoPlayerView

+ (Class)layerClass {
	return [AVPlayerLayer class];
}

- (AVPlayer*)player {
	return [(AVPlayerLayer*)[self layer] player];
}

- (void)setPlayer:(AVPlayer*)player {
	[(AVPlayerLayer*)[self layer] setPlayer:player];
}

- (void)setVideoFillMode:(NSString *)fillMode {
	AVPlayerLayer *playerLayer = (AVPlayerLayer*)[self layer];
	playerLayer.videoGravity = fillMode;
}

@end
