//
//  DrillDownParser.m
//  sandbox
//
//  Created by David Durik on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DrillDownParser.h"


@implementation DrillDownParser

@synthesize managedObjectContext;

- (id)initWithContext:(NSManagedObjectContext *)managedObjContext {
	self = [super init];
	[self setManagedObjectContext:managedObjContext];

	return self;
}

- (BOOL)parseXMLFileAtURL:(NSURL *)URL parseError:(NSError **)error {
	BOOL result = YES;

	NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:URL];
	// Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks.
	[parser setDelegate:self];
	// Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
	[parser parse];

	NSError *parseError = [parser parserError];
	if (parseError && error) {
		*error = parseError;
		result = NO;
	}

	return result;
}

- (void)emptyDataContext {
    
    NSLog(@"\n F I L E -> F U N C T I O N : \n %s \n",__FUNCTION__);
    
    /*
	//ENTITY SPECIFIC
	// Get all counties, It's the top level object and the reference cascade deletion downward
	NSMutableArray *mutableFetchResults = [CoreDataHelper getObjectsFromContext:@"Master":@"name":NO:managedObjectContext];
	// Delete all Counties
	for (int i = 0; i < [mutableFetchResults count]; i++) {
		[managedObjectContext deleteObject:[mutableFetchResults objectAtIndex:i]];
	}
	// Update the data model effectivly removing the objects we removed above.
	NSError *error;
	if (![managedObjectContext save:&error]) {
		// Handle the error.
		NSLog(@"%@", [error domain]);
	}
     */
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	if (qName) {
		elementName = qName;
		NSLog(@"%@", qName);
	}
	else {
		NSLog(@"%s","Problem encountered");
	}


/*

	// If it's the start of the XML, remove everything we've stored so far
	//ONLY REMOVES PREVIOUSLY IMPORTED XML FROM SAME MAIN TAG
	if ([elementName isEqualToString:@"AppDrillDown"]) {
		[self emptyDataContext];
		return;
	}
	//MASTER LEVEL ------------------------------------------------------------------
	if ([elementName isEqualToString:@"master"]) {
		currentMaster = (Master *)[NSEntityDescription insertNewObjectForEntityForName:@"Master" inManagedObjectContext:managedObjectContext];
		[currentMaster setName:[attributeDict objectForKey:@"name"]];
		if ([attributeDict objectForKey:@"master_id"]) {
			//NSString TO NSNumber
			NSNumber *currentNumber = [NSNumber numberWithInt:[[attributeDict objectForKey:@"master_id"] integerValue]];
			[currentMaster setMaster_id:currentNumber];
		}
		return;
	}
	//DETAIL LEVEL --------------------------------------------------------------------------
	else if ([elementName isEqualToString:@"detail"]) {
		currentDetails = (Detail *)[NSEntityDescription insertNewObjectForEntityForName:@"Detail" inManagedObjectContext:managedObjectContext];
		[currentDetails setDetail_name:[attributeDict objectForKey:@"detail_name"]];
		[currentDetails setMaster_name:[attributeDict objectForKey:@"master_name"]];
		if ([attributeDict objectForKey:@"master_id"]) {
			//HANDLE KEY WITH NUMBER VALUE
			NSNumber *currentNumber = [NSNumber numberWithInt:[[attributeDict objectForKey:@"master_id"] integerValue]];
			[currentDetails setMaster_id:currentNumber];
		}
		if ([attributeDict objectForKey:@"detail_id"]) {
			//HANDLE KEY WITH NUMBER VALUE
			NSNumber *currentNumber = [NSNumber numberWithInt:[[attributeDict objectForKey:@"detail_id"] integerValue]];
			[currentDetails setDetail_id:currentNumber];
		}
		[currentMaster addMasterToDetailObject:currentDetails];
	}
	//SUBDETAIL LEVEL --------------------------------------------------------------------------
	else if ([elementName isEqualToString:@"subdetail"]) {
		Subdetail *sd = (Subdetail *)[NSEntityDescription insertNewObjectForEntityForName:@"Subdetail" inManagedObjectContext:managedObjectContext];
		[sd setSubdetail_name:[attributeDict objectForKey:@"subdetail_name"]];
		[sd setDetail_name:[attributeDict objectForKey:@"detail_name"]];
		[sd setMaster_name:[attributeDict objectForKey:@"master_name"]];
		if ([attributeDict objectForKey:@"master_id"]) {
			//HANDLE KEY WITH NUMBER VALUE
			NSNumber *currentNumber = [NSNumber numberWithInt:[[attributeDict objectForKey:@"master_id"] integerValue]];
			[sd setMaster_id:currentNumber];
		}
		if ([attributeDict objectForKey:@"detail_id"]) {
			//HANDLE KEY WITH NUMBER VALUE
			NSNumber *currentNumber = [NSNumber numberWithInt:[[attributeDict objectForKey:@"detail_id"] integerValue]];
			[sd setDetail_id:currentNumber];
		}
		if ([attributeDict objectForKey:@"subdetail_id"]) {
			//HANDLE KEY WITH NUMBER VALUE
			NSNumber *currentNumber = [NSNumber numberWithInt:[[attributeDict objectForKey:@"subdetail_id"] integerValue]];
			[sd setSubdetail_id:currentNumber];
		}
		[currentDetails addDetailToSubdetailObject:sd];
	}
 */
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if (qName) {
		elementName = qName;
	}
	NSLog(@"\n F I L E -> F U N C T I O N : \n %s \n",__FUNCTION__);
    /*
    // If we're at the end of a county. Save changes to object model
	if ([elementName isEqualToString:@"master"]) {
		// Sanity check
		if (currentMaster != nil) {
			NSError *error;
			// Store what we imported already
			if (![managedObjectContext save:&error]) {
				// Handle the error.
				NSLog(@"%@", [error domain]);
			}
		}
	}
     */
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	// We're not reading any text-element data.
    NSLog(@"\n F I L E -> F U N C T I O N : \n %s \n",__FUNCTION__);
}



@end
