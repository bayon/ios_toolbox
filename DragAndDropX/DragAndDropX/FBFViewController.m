//
//  FBFViewController.m
//  DragAndDropX
//
//  Created by Bayon Forte on 2/17/14.
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
    NSLog(@"\n F I L E -> F U N C T I O N : \n %s \n",__FUNCTION__);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
     button.frame = CGRectMake(30.0f,50.0f,50.0f,50.0f);
    [button addTarget:self action:@selector(imageTouch:withEvent:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(imageMoved:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [button setImage:[UIImage imageNamed:@"drawing.png"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    
}
- (IBAction) imageMoved:(id) sender withEvent:(UIEvent *) event
{
    NSLog(@"\n F I L E -> F U N C T I O N : \n %s \n",__FUNCTION__);
    CGPoint point = [[[event allTouches] anyObject] locationInView:self.view];
    UIControl *control = sender;
    control.center = point;
}
- (IBAction) imageTouch:(id) sender withEvent:(UIEvent *) event{
     NSLog(@"\n F I L E -> F U N C T I O N : \n %s \n",__FUNCTION__);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
