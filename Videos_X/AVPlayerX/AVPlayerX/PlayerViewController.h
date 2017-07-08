//
//  PlayerViewController.h
//  AVPlayerX
//
//  Created by Bayon Forte on 2/17/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class PlayerView;
@class SimpleView;
@interface PlayerViewController : UIViewController

@property (nonatomic) AVPlayer *player;
@property (nonatomic) AVPlayerItem *playerItem;
@property (nonatomic, weak) IBOutlet PlayerView *playerView;
@property (nonatomic, weak) IBOutlet SimpleView *simplePlayerView;
@property (nonatomic, weak) IBOutlet UIButton *playButton;

- (IBAction)loadAssetFromFile:sender;
- (IBAction)play:sender;
- (void)syncUI;
@end