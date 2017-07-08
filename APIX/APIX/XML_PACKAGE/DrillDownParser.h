//
//  DrillDownParser.h
//  sandbox
//
//  Created by David Durik on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import	"CoreDataHelper.h"
//ENTITY SPECIFIC
#import "MusicModel.h"

@interface DrillDownParser : NSObject <NSXMLParserDelegate>{
    NSMutableString *contentsOfCurrentProperty;
	NSManagedObjectContext *managedObjectContext;
    //ENTITY SPECIFIC
    MusicModel *currentMusicModel;
    
}
@property (retain, nonatomic) NSManagedObjectContext *managedObjectContext;

-(id) initWithContext: (NSManagedObjectContext *) managedObjContext;
-(BOOL)parseXMLFileAtURL:(NSURL *)URL parseError:(NSError **)error;
-(void) emptyDataContext;

@end

