//
//  FBFViewController.h
//  CalendarEventX
//
//  Created by Bayon Forte on 2/17/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>
 

@interface FBFViewController : UIViewController <EKEventEditViewDelegate>

@property (nonatomic, strong) EKEventStore *ekEventStore;
@property (nonatomic, strong) EKCalendar *ekCalendar;
@property (nonatomic, strong) NSMutableArray *eventsArray;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;

- (IBAction)addEvent:(id)sender ;
@end
