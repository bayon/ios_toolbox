//
//  FBFViewController.m
//  AutomationX
//
//  Created by Bayon Forte on 2/19/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "FBFViewController.h"

@interface FBFViewController ()

@end

@implementation FBFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
-(IBAction)pressButton:(id)sender{
    NSString* msg = [NSString stringWithFormat:@"Automation is good." ];
    UIAlertView *alertmsg = [[UIAlertView alloc] initWithTitle:@"Automation" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil ];
    alertmsg.accessibilityLabel = @"alert";
    // SHOW ALERTS
    [alertmsg show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0) {
        NSLog(@"\n FILE->FUNCTION: %s",__FUNCTION__);
        NSLog(@"ALERT Zero");
        
	}else{
        NSLog(@"ALERT ONE");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
