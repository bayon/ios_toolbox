//
//  AsyncNetwork.m
//  Music Search
//
//  Created by Bayon Forte on 1/13/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "AsyncNetwork.h"
#import "Constants.h"
#import "MusicModel.h"

@interface AsyncNetwork () {
	NSURLConnection *connection;
	NSMutableData *responseData;
}

@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic) int spaceIndex;

@end

@implementation AsyncNetwork
@synthesize connection, responseData, spaceIndex;

- (void)load:(NSString *)baseURL withSearchTerm :(NSString *)searchTerm {
	searchTerm = [searchTerm stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	searchTerm = [searchTerm stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

	NSURL *myURL = [NSURL URLWithString:[NSString stringWithFormat:baseURL, searchTerm]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark - NSURL Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[[NSNotificationCenter defaultCenter] postNotificationName:kNotifyFail object:nil];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	if (responseData != nil) {
		[self parseResponseData:responseData];
	}
	else {
		[[NSNotificationCenter defaultCenter] postNotificationName:kNotifyFail object:nil];
	}
}

#pragma mark - Parse Dictionary
 /**
  This method parses the json response as NSMutableData, then creates and sends a dictionary
  back with the notification if successful.
  */

- (NSMutableArray *)parseResponseData:(NSMutableData *)mutableResponseData {
    //note: This method returns an array for the sake of a unit test.
    NSMutableArray *localArrayOfMusicModels = [[NSMutableArray alloc] init];
	@try {
		NSError *e;
		NSDictionary *dictionaryOfJsonFromResponseData =
		    [NSJSONSerialization JSONObjectWithData:mutableResponseData
		                                    options:NSJSONReadingMutableContainers
		                                      error:&e];

		NSMutableArray *arrayOfAlbums = dictionaryOfJsonFromResponseData[@"albums"];

		

		for (NSDictionary *dict in arrayOfAlbums) {
			MusicModel *musicModel = [[MusicModel alloc] initWithJsonDictionary:dict];
			[localArrayOfMusicModels addObject:musicModel];
		}

		NSDictionary *dictionaryOfMusicModels = @{ kArrayOfMusicModels : localArrayOfMusicModels };

		[[NSNotificationCenter defaultCenter] postNotificationName:kNotifySuccess object:self userInfo:dictionaryOfMusicModels];
	}
	@catch (NSException *exception)
	{
		[[NSNotificationCenter defaultCenter] postNotificationName:kNotifyFail object:nil];
	}
    return localArrayOfMusicModels;
}

@end
