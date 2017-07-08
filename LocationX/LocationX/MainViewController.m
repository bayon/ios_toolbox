//
//  FBFViewController.m
//  LocationX
//
//  Created by Bayon Forte on 2/17/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "MainViewController.h"


@implementation MainViewController

- (void)viewDidLoad {
	locationController = [[XLocationController alloc] init];
	locationController.delegate = self;
}

-(IBAction)getLocation:(id)sender;
{
    [locationController.locationManager startUpdatingLocation];
}
 
- (void)locationUpdate:(CLLocation *)location {
    [textView setText:[location description]];
}

- (void)locationError:(NSError *)error {
     [textView setText:[error description]];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
