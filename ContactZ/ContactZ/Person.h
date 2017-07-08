//
//  Person.h
//  ContactZ
//
//  Created by Bayon Forte on 2/18/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Person : NSObject
{
	
    NSString *firstName;
    NSString * phone;
    NSString *zip;
	NSString *state;
	NSString *address2;
	NSString *address1;
	NSString *country;
	NSString *city;
}
@property (nonatomic, retain) NSString *zip;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *address2;
@property (nonatomic, retain) NSString *address1;
@property (nonatomic, retain) NSString *country;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *phone;

 

@end

