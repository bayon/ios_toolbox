//
//  PlayerView.h
//  AVPlayerX
//
//  Created by Bayon Forte on 2/17/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayerView : UIView{
    AVPlayer *player;
}

@property (nonatomic) AVPlayer *player;

- (void)setPlayer:(AVPlayer *)player;
- (AVPlayer*)player;

@end
