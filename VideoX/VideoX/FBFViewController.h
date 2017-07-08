//
//  FBFViewController.h
//  VideoX
//
//  Created by Bayon Forte on 2/27/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface FBFViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (copy,   nonatomic) NSURL *movieURL;
@property (strong, nonatomic) MPMoviePlayerController *movieController;

- (IBAction)takeVideo:(UIButton *)sender;

@end
