//
//  FBFViewController.m
//  AnimationX
//
//  Created by Bayon Forte on 2/17/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "FBFViewController.h"

@interface FBFViewController ()

@end

@implementation FBFViewController
@synthesize boxView, scaleFactor, angle;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
    scaleFactor = 2;
    angle = 180;
    CGRect frameRect = CGRectMake(10, 10, 100, 100);
    boxView = [[UIView alloc] initWithFrame:frameRect];
    boxView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:boxView];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    CGAffineTransform scaleTrans =
    CGAffineTransformMakeScale(scaleFactor, scaleFactor);
    CGAffineTransform rotateTrans =
    CGAffineTransformMakeRotation(angle * M_PI / 180);
    boxView.transform = CGAffineTransformConcat(scaleTrans, rotateTrans);
    angle = (angle == 180 ? 360 : 180);
    scaleFactor = (scaleFactor == 2 ? 1 : 2);
    boxView.center = location;
    [UIView commitAnimations];
}
@end
