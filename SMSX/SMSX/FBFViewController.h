//
//  FBFViewController.h
//  SMSX
//
//  Created by Bayon Forte on 2/17/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface FBFViewController : UIViewController <MFMessageComposeViewControllerDelegate>
{
    
}
- (IBAction)showSMS:(NSString*)messageString;
@end
