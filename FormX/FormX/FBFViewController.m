//
//  FBFViewController.m
//  FormX
//
//  Created by Bayon Forte on 2/18/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "FBFViewController.h"

@interface FBFViewController ()
@property (nonatomic, retain) IBOutlet UIButton *submitButton;
@property (nonatomic, retain) IBOutlet UITextField *textField1;
@property (nonatomic, retain) IBOutlet UITextField *textField2;
@end

@implementation FBFViewController
@synthesize submitButton, textField1, textField2, tap;

- (void)viewDidLoad
{
    [super viewDidLoad];
    textField1.delegate = self;
    [textField1 setPlaceholder:@"AlphaNumeric"];
    [textField1 setKeyboardType:UIKeyboardTypeDefault];
    
    textField2.delegate = self;
    [textField2 setPlaceholder:@"Numeric"];
    [textField2 setKeyboardType:UIKeyboardTypeNumberPad];
    //many UIKeyboardTypes: decimal, email, websearch, etc...
    
    tap = [[UITapGestureRecognizer alloc]
           initWithTarget:self
           action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}
-(IBAction)submit:(id)sender{
    [self getFormSubmission];
}
-(void)getFormSubmission{
    NSLog(@"%@",textField1.text);
    NSLog(@"%@",textField2.text);
    
}
// "Return Key" dismiss keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField1 resignFirstResponder];
    [textField2 resignFirstResponder];
    
    return YES;
}
// "Tap" dismiss keyboard
-(void)dismissKeyboard {
    [textField1 resignFirstResponder];
    [textField2 resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
