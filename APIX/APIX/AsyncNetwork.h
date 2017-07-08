//
//  AsyncNetwork.h
//  Music Search
//
//  Created by Bayon Forte on 1/13/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import <Foundation/Foundation.h>
/** This class handles the call to the service providing the musicians information. */

@interface AsyncNetwork : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

/**---------------------------------------------------------------------------------------
 * @name load
 *  ---------------------------------------------------------------------------------------
 */

/** This method calls the service

   @param string searchTerm
   @return NSMutableArray
 */

- (void)load:(NSString *)baseURL withSearchTerm :(NSString *)searchTerm;
- (NSMutableArray *)parseResponseData:(NSMutableData *)mutableResponseData;
@end
