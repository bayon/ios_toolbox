//
//  AsyncXMLNetwork.h
//  APIX
//
//  Created by Bayon Forte on 2/19/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import <Foundation/Foundation.h>
/** This class handles the call to the service providing the musicians information. */

@interface AsyncXMLNetwork : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

/**---------------------------------------------------------------------------------------
 * @name load
 *  ---------------------------------------------------------------------------------------
 */

/** This method calls the service
 
 @param string searchTerm
 @return NSMutableArray
 */

- (void)load:(NSString *)baseURL withSearchTerm :(NSString *)searchTerm;
- (void)load:(NSString *)baseURL withParameters :(NSDictionary *)parameters;
- (NSMutableArray *)parseResponseData:(NSMutableData *)mutableResponseData;
@end
