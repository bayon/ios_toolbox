//
//  MusicModel.h
//  Music Search
//
//  Created by Bayon Forte on 12/19/13.
//  Copyright (c) 2013 Mocura. All rights reserved.
//

#import <Foundation/Foundation.h>

/** This class is just a model for the musicians information.

 */

//Create a model object to display results
@interface MusicModel : NSObject

@property (nonatomic, retain) NSString *album;
@property (nonatomic, retain) NSString *artist;
@property (nonatomic, retain) NSString *popularity;

-(MusicModel *)initWithJsonDictionary:(NSDictionary *)dict;

@end
