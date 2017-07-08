

#import "MainViewController.h"
#import "VideoPlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MainViewController () 

@property (nonatomic, retain) MPMoviePlayerController *playerViewController;
@property (nonatomic, retain) VideoPlayerViewController *myPlayerViewController;

@end


@implementation MainViewController

@synthesize playerViewController = _playerViewController;
@synthesize myPlayerViewController = _myPlayerViewController;

- (void)dealloc {
    self.playerViewController = nil;
    self.myPlayerViewController = nil;
    
    [super dealloc];
}


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"http://devimages.apple.com/samplecode/adDemo/ad" withExtension:@"m3u8"];
    //NOT STREAMING...
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"video_1" withExtension:@"mp4"];
    
    // video player
    MPMoviePlayerController *playerViewController = [[MPMoviePlayerController alloc] init];
    playerViewController.contentURL = url;
    playerViewController.view.frame = CGRectMake(0, 0, 500, 500);
    
    [self.view addSubview:playerViewController.view];
    [playerViewController play];
    
    self.playerViewController = playerViewController;
    [playerViewController release];
    
    
    // my video player
    VideoPlayerViewController *player = [[VideoPlayerViewController alloc] init];
    player.URL = url;
    player.view.frame = CGRectMake(0, 600, 500, 500);
    [self.view addSubview:player.view];
    self.myPlayerViewController = player;
    [player release];
}

@end
