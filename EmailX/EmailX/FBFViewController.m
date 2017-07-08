//
//  FBFViewController.m
//  EmailX
//
//  Created by Bayon Forte on 2/14/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "FBFViewController.h"
#import <MessageUI/MessageUI.h>

@interface FBFViewController ()
{
    UILabel *label_1 ;
}
@end

@implementation FBFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    label_1 = [[UILabel alloc] initWithFrame:CGRectMake(200, 150, 300, 50)];
    label_1.backgroundColor = [UIColor clearColor];
    [label_1 setText:@"...email? ..."];
    [self.view addSubview:label_1];

    
    
    
    
    //send a message
    if ([MFMailComposeViewController canSendMail]) {
        // Show the composer
        MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        [controller setSubject:@"My Subject"];
        [controller setMessageBody:@"Hello there." isHTML:NO];
        if (controller) [self presentModalViewController:controller animated:YES];
    } else {
        // Handle the error
    }
   
    
   
}


- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
        [label_1 setText:@"It's away!"];
    }
    [self dismissModalViewControllerAnimated:YES];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
