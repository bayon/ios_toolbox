

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>


@class AVPlayer;
@class AVPlayerItem;
@class MyPlayerLayerView;

@interface MyStreamingMovieViewController : UIViewController <UITextFieldDelegate> {

    NSURL *movieURL;
	AVPlayer *player;
    AVPlayerItem *playerItem;
	MyPlayerLayerView *playerLayerView;
    
    UITextField	*movieURLTextField;
    
	UISlider *movieTimeControl;
	BOOL isSeeking;
	BOOL seekToZeroBeforePlay;
	float restoreAfterScrubbingRate;
    
    id timeObserver;	
    
    UIToolbar *toolBar;
    UIBarButtonItem *playButton;
    UIBarButtonItem *stopButton;
    
    UILabel *isPlayingAdText;
    
	NSArray *adList;

}

@property (retain) IBOutlet UIToolbar *toolBar;
@property (retain) IBOutlet UIBarButtonItem *playButton;
@property (retain) IBOutlet UIBarButtonItem *stopButton;

@property (retain) IBOutlet UITextField *movieURLTextField;
@property (retain) IBOutlet UISlider *movieTimeControl;
@property (retain) IBOutlet MyPlayerLayerView *playerLayerView;
@property (retain) AVPlayer *player;
@property (retain) AVPlayerItem *playerItem;
@property (retain) IBOutlet UILabel *isPlayingAdText;

- (IBAction)loadMovieButtonPressed:(id)sender;

- (IBAction)beginScrubbing:(id)sender;
- (IBAction)scrub:(id)sender;
- (IBAction)endScrubbing:(id)sender;

- (IBAction)play:(id)sender;
- (IBAction)pause:(id)sender;

@end
