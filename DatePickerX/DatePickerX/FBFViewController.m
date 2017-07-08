//
//  FBFViewController.m
//  DatePickerX
//
//  Created by Bayon Forte on 2/14/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "FBFViewController.h"

@implementation FBFViewController

/*! Primary view has been loaded for this view controller
 */
- (void)viewDidLoad
{
    [super viewDidLoad];

    CGRect pickerFrame = CGRectMake(0,250,0,0);
    UIDatePicker *myPicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    [myPicker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:myPicker];
    
}

- (void)pickerChanged:(id)sender
{
    NSLog(@"value: %@",[sender date]);
}

@end
