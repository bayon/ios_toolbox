//
//  SimpleView.h
//  AVPlayerX
//
//  Created by Bayon Forte on 2/17/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface SimpleView : UIView



@property (nonatomic) AVPlayer *player;

- (void)setPlayer:(AVPlayer *)player;
- (AVPlayer*)player;


@end
