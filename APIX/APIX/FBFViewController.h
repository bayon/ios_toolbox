//
//  FBFViewController.h
//  APIX
//
//  Created by Bayon Forte on 2/19/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"
#import "MusicCell.h"
#import "Reachability.h"

@interface FBFViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>
{
	UITapGestureRecognizer *tap;
	Reachability *reachability;
}
@property (nonatomic, retain) NSMutableArray *arrayOfArtistModels;
@property (nonatomic, weak) IBOutlet UITableView *artistTableView;
@property (nonatomic, weak) IBOutlet UITextField *textInput;
@property (nonatomic, weak) IBOutlet UIButton *enterButton;
@property (nonatomic, retain) UITapGestureRecognizer *tap;
@property (nonatomic, retain) Reachability *reachability;


/**---------------------------------------------------------------------------------------
 * @name process
 *  ---------------------------------------------------------------------------------------
 */
/** This method checks for network availability. If network is available, it starts a progress spinner as it calls AsyncNetwork's load method.
   Otherwise it presents the user with a pop up dialog explaining that they should check their network connection.

   @param id sender
   @return void
 */
- (IBAction)process:(id)sender;
-(IBAction)segmentedAction :(id)sender;


@end
