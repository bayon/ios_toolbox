//
//  FBFViewController.h
//  FormX
//
//  Created by Bayon Forte on 2/18/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBFViewController : UIViewController <UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    UITapGestureRecognizer *tap;
}
 @property  (nonatomic,retain) UITapGestureRecognizer *tap;
-(IBAction)submit:(id)sender;

@end
 