//
//  imageHandler.m
//  tabbartest
//
//  Created by David Durik on 8/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "imageHandler.h"

@implementation imageHandler
//RequestData
@synthesize mutableData,urlConnection;

-(void)sendRequestForJSONReturnData{
    NSLog(@"\n FILE->FUNCTION: %s",__FUNCTION__);
    //method=get_Images will return a list of available images in the database.
    NSString *myRequestString = @"method=get_Images";
    NSData *jsonData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    NSString *url = @"http://www.forteworks.com/jsonImages.php";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLCacheStorageAllowed timeoutInterval:30.0];
    //POST data 
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: jsonData];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    self.mutableData = [NSMutableData data]; 
    self.urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

@end
