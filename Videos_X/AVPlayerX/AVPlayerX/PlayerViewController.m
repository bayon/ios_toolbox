//
//  PlayerViewController.m
//  AVPlayerX
//
//  Created by Bayon Forte on 2/17/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "PlayerViewController.h"

@interface PlayerViewController ()

@end

// Define this constant for the key-value observation context.
static const NSString *ItemStatusContext;

@implementation PlayerViewController
@synthesize playButton, player, playerItem, playerView, simplePlayerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
        //PlayerView *playerView = [[PlayerView alloc]init];
        
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self syncUI];
}

- (void)syncUI {
	if ((self.player.currentItem != nil) &&
	    ([self.player.currentItem status] == AVPlayerItemStatusReadyToPlay)) {
		self.playButton.enabled = YES;
	}
	else {
		self.playButton.enabled = NO;
	}
}

- (IBAction)loadAssetFromFile:sender {
	//http://devimages.apple.com/samplecode/adDemo/ad.m3u8
	NSURL *fileURL = [[NSBundle mainBundle]
	                  URLForResource:@"http://devimages.apple.com/samplecode/adDemo/ad" withExtension:@"m3u8"];

	AVURLAsset *asset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
	NSString *tracksKey = @"tracks";

	[asset loadValuesAsynchronouslyForKeys:@[tracksKey] completionHandler:
	 ^{
	    // The completion block goes here.
	    // Define this constant for the key-value observation context.
	   // static const NSString *ItemStatusContext;

	    // Completion handler block.
	    dispatch_async(dispatch_get_main_queue(),
	                   ^{
	        NSError *error;
	        AVKeyValueStatus status = [asset statusOfValueForKey:tracksKey error:&error];

                          // self.playerView = [[PlayerView alloc]init];
                          // PlayerView *playerView = [[PlayerView alloc]init];
                           
                           
	        if (status == AVKeyValueStatusLoaded) {
	            self.playerItem = [AVPlayerItem playerItemWithAsset:asset];
	            [self.playerItem addObserver:self forKeyPath:@"status"
	                                 options:0 context:&ItemStatusContext];
	            [[NSNotificationCenter defaultCenter] addObserver:self
	                                                     selector:@selector(playerItemDidReachEnd:)
	                                                         name:AVPlayerItemDidPlayToEndTimeNotification
	                                                       object:self.playerItem];
	            self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
	             [self.playerView setPlayer:self.player];
                
                
                // Register with the notification center after creating the player item.
                [[NSNotificationCenter defaultCenter]
                 addObserver:self
                 selector:@selector(playerItemDidReachEnd:)
                 name:AVPlayerItemDidPlayToEndTimeNotification
                 object:[self.player currentItem]];
                
                
                
			}
	        else {
	            // You should deal with the error appropriately.
	            NSLog(@"The asset's tracks were not loaded:\n%@", [error localizedDescription]);
			}
		});
	}];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    
    if (context == &ItemStatusContext) {
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           [self syncUI];
                       });
        return;
    }
    [super observeValueForKeyPath:keyPath ofObject:object
                           change:change context:context];
    return;
}
- (IBAction)play:sender {
    [player play];
}


- (void)playerItemDidReachEnd:(NSNotification *)notification {
    [self.player seekToTime:kCMTimeZero];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
