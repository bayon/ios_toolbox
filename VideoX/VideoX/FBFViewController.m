//
//  FBFViewController.m
//  VideoX
//
//  Created by Bayon Forte on 2/27/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "FBFViewController.h"

@interface FBFViewController ()
{
	IBOutlet UIView *videoView;
}
@property (nonatomic, retain) IBOutlet UIView *videoView;
@end

@implementation FBFViewController
@synthesize videoView;

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
	self.movieController = [[MPMoviePlayerController alloc] init];
	[self.movieController setContentURL:self.movieURL];
	[self.movieController.view setFrame:[self centerWithWidthDeluxe:250 Height:200 Y:30]];

	[self.view addSubview:self.movieController.view];

	[[NSNotificationCenter defaultCenter] addObserver:self
	                                         selector:@selector(moviePlayBackDidFinish:)
	                                             name:MPMoviePlayerPlaybackDidFinishNotification
	                                           object:self.movieController];

	[self.movieController play];
}

- (IBAction)takeVideo:(UIButton *)sender {
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	picker.allowsEditing = YES;
	picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	picker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
	[self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	self.movieURL = info[UIImagePickerControllerMediaURL];
	[picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)moviePlayBackDidFinish:(NSNotification *)notification {
	[[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
	[self.movieController stop];
	[self.movieController.view removeFromSuperview];
	self.movieController = nil;
}

- (CGRect)centerWithWidthDeluxe:(int)width Height:(int)height Y:(int)y {
	CGFloat windowWidth;
	windowWidth = [UIScreen mainScreen].bounds.size.width;
	int absoluteCenter = windowWidth / 2;
	int sideMargin = (width / 2);
	int centeredX = absoluteCenter - sideMargin;
	CGRect centeredRect = CGRectMake(centeredX, y, width, height);
	return centeredRect;
}

@end
