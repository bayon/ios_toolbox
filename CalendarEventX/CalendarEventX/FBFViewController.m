//
//  FBFViewController.m
//  CalendarEventX
//
//  Created by Bayon Forte on 2/17/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "FBFViewController.h"


@implementation FBFViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	/*   FRAMEWORKS: EventKit and EventKitUI  */
	self.ekEventStore = [[EKEventStore alloc] init];
	self.eventsArray = [[NSMutableArray alloc] initWithCapacity:0];
	self.addButton.enabled = NO;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self checkEventStoreAccessForCalendar];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([[segue identifier] isEqualToString:@"showEventViewController"]) {
		EKEventViewController *eventViewController = (EKEventViewController *)[segue destinationViewController];
		eventViewController.allowsEditing = YES;
	}
}

#pragma mark -
#pragma mark Calendar Permission

- (void)checkEventStoreAccessForCalendar {
	EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];

	switch (status) {
		case EKAuthorizationStatusAuthorized:[self accessGrantedForCalendar];
			break;

		case EKAuthorizationStatusNotDetermined:[self requestCalendarAccess];
			break;

		case EKAuthorizationStatusDenied:
		case EKAuthorizationStatusRestricted:
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Privacy Warning" message:@"Permission was not granted for Calendar"
			                                               delegate:nil
			                                      cancelButtonTitle:@"OK"
			                                      otherButtonTitles:nil];
			[alert show];
		}
		break;

		default:
			break;
	}
}

- (void)requestCalendarAccess {
	[self.ekEventStore requestAccessToEntityType:EKEntityTypeEvent completion: ^(BOOL granted, NSError *error)
	{
	    if (granted) {
	        FBFViewController *__weak weakSelf = self;
	        dispatch_async(dispatch_get_main_queue(), ^{
	            [weakSelf accessGrantedForCalendar];
			});
		}
	}];
}

- (void)accessGrantedForCalendar {
	self.ekCalendar = self.ekEventStore.defaultCalendarForNewEvents;
	self.addButton.enabled = YES;
	self.eventsArray = [self getCalendarEventsForLast24Hours];
	//[self.tableView reloadData];
}

#pragma mark -
#pragma mark Get Calendar Events
- (NSMutableArray *)getCalendarEventsForLast24Hours {
	NSDate *startDate = [NSDate date];
	NSDateComponents *tomorrowDateComponents = [[NSDateComponents alloc] init];
	tomorrowDateComponents.day = 1;
	NSDate *endDate = [[NSCalendar currentCalendar] dateByAddingComponents:tomorrowDateComponents
	                                                                toDate:startDate
	                                                               options:0];
	NSArray *calendarArray = [NSArray arrayWithObject:self.ekCalendar];
	NSPredicate *predicate = [self.ekEventStore predicateForEventsWithStartDate:startDate
	                                                                    endDate:endDate
	                                                                  calendars:calendarArray];
	NSMutableArray *events = [NSMutableArray arrayWithArray:[self.ekEventStore eventsMatchingPredicate:predicate]];

	return events;
}

#pragma mark -
#pragma mark Add an event

- (IBAction)addEvent:(id)sender {
	EKEventEditViewController *ekEventEditViewController = [[EKEventEditViewController alloc] init];
	ekEventEditViewController.eventStore = self.ekEventStore;
	ekEventEditViewController.editViewDelegate = self;
	[self presentViewController:ekEventEditViewController animated:YES completion:nil];
}

#pragma mark -
#pragma mark EKEventEditViewDelegate

- (void)eventEditViewController:(EKEventEditViewController *)controller
          didCompleteWithAction:(EKEventEditViewAction)action {
	FBFViewController *__weak weakSelf = self;
	[self dismissViewControllerAnimated:YES completion: ^
	{
	    if (action != EKEventEditViewActionCanceled) {
	        dispatch_async(dispatch_get_main_queue(), ^{
	            weakSelf.eventsArray = [self getCalendarEventsForLast24Hours];
			});
		}
	}];
}

- (EKCalendar *)eventEditViewControllerDefaultCalendarForNewEvents:(EKEventEditViewController *)controller {
	return self.ekCalendar;
}

@end
