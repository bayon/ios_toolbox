//
//  FBFViewController.m
//  ConstraintsWithVideoX
//
//  Created by Bayon Forte on 2/27/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "FBFViewController.h"
#import "ConstraintXView.h"

@interface FBFViewController ()
{
	UIButton *button1;
	UIView *containerView;
}
@property (nonatomic, retain) IBOutlet UIButton *button1;
@property (nonatomic, retain) UIView *containerView;

@end

@implementation FBFViewController
@synthesize  button1, containerView;
@synthesize centerView = _centerView;

- (void)loadView {
	containerView = [[ConstraintXView alloc] init];
	self.view = containerView;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button1 addTarget:self action:@selector(takeVideo:) forControlEvents:UIControlEventTouchUpInside];
	[button1 setTitle:@"shoot" forState:UIControlStateNormal];
	button1.frame = CGRectMake(20.0f, 20.0f, 100.0f, 40.0f);
	[button1 setBackgroundColor:[UIColor whiteColor]];
	[self.view addSubview:button1];
}

- (void)viewDidAppear:(BOOL)animated {
    
	self.movieController = [[MPMoviePlayerController alloc] init];
	[self.movieController setContentURL:self.movieURL];
	[self.movieController.view setFrame:CGRectMake(30, 30, 150, 200)];
    
	[containerView addSubview:self.movieController.view];
	[[NSNotificationCenter defaultCenter] addObserver:self
	                                         selector:@selector(moviePlayBackDidFinish:)
	                                             name:MPMoviePlayerPlaybackDidFinishNotification
	                                           object:self.movieController];

	[self.movieController play];
}

- (void)updateConstraints {
	//[self.view.super updateConstraints];
}
/*
 2014-02-27 12:21:42.976 ConstraintsWithVideoX[8715:60b] 
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', 
 reason: '*** +[NSLayoutConstraint constraintWithItem:attribute:relatedBy:toItem:attribute:multiplier:constant:]: Constraint items must each be an instance of UIView or subclass'
 */
- (void)setUpConstraints {
	// Width constraint : NSLayoutAttributeWidth
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_centerView
	                                                 attribute:NSLayoutAttributeWidth
	                                                 relatedBy:NSLayoutRelationEqual
	                                                    toItem:self
	                                                 attribute:NSLayoutAttributeWidth
	                                                multiplier:0.5
	                                                  constant:0]];
    
	// Height constraint : NSLayoutAttributeHeight
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_centerView
	                                                 attribute:NSLayoutAttributeHeight
	                                                 relatedBy:NSLayoutRelationEqual
	                                                    toItem:self
	                                                 attribute:NSLayoutAttributeHeight
	                                                multiplier:0.5
	                                                  constant:0]];
    
	// Center horizontally : NSLayoutAttributeCenterX
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_centerView
	                                                 attribute:NSLayoutAttributeCenterX
	                                                 relatedBy:NSLayoutRelationEqual
	                                                    toItem:self
	                                                 attribute:NSLayoutAttributeCenterX
	                                                multiplier:1.0
	                                                  constant:0.0]];
    
	// Center vertically : NSLayoutAttributeCenterY
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_centerView
	                                                 attribute:NSLayoutAttributeCenterY
	                                                 relatedBy:NSLayoutRelationEqual
	                                                    toItem:self
	                                                 attribute:NSLayoutAttributeCenterY
	                                                multiplier:1.0
	                                                  constant:0.0]];
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


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
