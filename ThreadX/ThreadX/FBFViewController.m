//
//  FBFViewController.m
//  ThreadX
//
//  Created by Bayon Forte on 2/24/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "FBFViewController.h"

@interface FBFViewController (){
    
    IBOutlet UILabel *lblOne;
    IBOutlet UILabel *lblTwo;
    NSString *strOne;
    NSString *strTwo;
}
@end
//below imports above implementation
void (^tFunct1)(UILabel *,NSString *) = ^(UILabel *lbl, NSString *src)
{
    //background thread work
    NSLog(@"Going to sleep");
    sleep(4);
    NSLog(@"Waking Up");
    
    // CAN ONLY INTERACT WITH UI ON MAIN THREAD
    dispatch_async(dispatch_get_main_queue(),^(void)
                   {
                       [lbl setText:src];
                       NSLog(@"Label Done!");
                   }
                   );
};

@implementation FBFViewController

-(IBAction)buttonPressed:(id)sender
{
    mConcurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    
    dispatch_async( mConcurrentQueue, ^{ tFunct1  (self->lblOne,@"1 Go!" );  }  );
    sleep(5);
    dispatch_async( mConcurrentQueue, ^{ tFunct1  (self->lblTwo,@"2 Go!" );  }  );
    
}


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

@end
 
