//
//  FBFViewController.h
//  ContactZ
//
//  Created by Bayon Forte on 2/17/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface FBFViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate,ABPersonViewControllerDelegate,
ABNewPersonViewControllerDelegate, ABUnknownPersonViewControllerDelegate>
{
    
}

-(IBAction)createPerson:(id)sender;
-(IBAction)readContacts:(id)sender;
-(NSArray *)getAllContacts;
@end
