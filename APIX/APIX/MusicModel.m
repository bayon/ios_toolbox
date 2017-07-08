//
//  MusicModel.m
//  Music Search
//
//  Created by Bayon Forte on 12/19/13.
//  Copyright (c) 2013 Mocura. All rights reserved.
//

#import "MusicModel.h"

@implementation MusicModel
@synthesize album, artist, popularity;

- (id)initWithJsonDictionary:(NSDictionary *)dict {
	self = [super init];
	if (self) {
		 
        self.album = dict[@"name"];
		      
        self.popularity = dict[@"popularity"];

		NSArray *artists        = dict[@"artists"];
		NSDictionary *artists0  = artists[0];
		NSString *artistName = artists0[@"name"];
		self.artist = artistName;
	}

	return self;
}

@end


