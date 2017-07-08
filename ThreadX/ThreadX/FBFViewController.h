//
//  FBFViewController.h
//  ThreadX
//
//  Created by Bayon Forte on 2/24/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBFViewController : UIViewController
{
    dispatch_queue_t mConcurrentQueue;
}

-(IBAction)buttonPressed:(id)sender;

@end
