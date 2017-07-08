//
//  FBFViewController.h
//  LocationX
//
//  Created by Bayon Forte on 2/17/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLocationController.h"

@interface MainViewController : UIViewController <XLocationControllerDelegate, UITextViewDelegate > {
    IBOutlet UITextView *textView;
	XLocationController *locationController;
}
-(IBAction)getLocation:(id)sender;

- (void)locationUpdate:(CLLocation *)location;
- (void)locationError:(NSError *)error;

@end