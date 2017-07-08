//
//  FBFViewController.m
//  PhoneCallX
//
//  Created by Bayon Forte on 2/17/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "FBFViewController.h"

@interface FBFViewController () {
}
@property (nonatomic, retain) IBOutlet UITextField *mymobileNo;
@property (nonatomic, retain) IBOutlet UIButton *button;
@end

@implementation FBFViewController
@synthesize mymobileNo = _mymobileNo;
- (void)viewDidLoad {
	[super viewDidLoad];
 
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (IBAction)makePhoneCall {
	NSLog(@"FILE->FUNCTION: %s", __FUNCTION__);
	NSString *phoneNumber = [@"tel://" stringByAppendingString : _mymobileNo.text];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

@end
