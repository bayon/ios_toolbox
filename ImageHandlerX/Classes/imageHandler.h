//
//  imageHandler.h
//  tabbartest
//
//  Created by David Durik on 8/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface imageHandler : NSObject{
    NSMutableData *mutableData;
    NSURLConnection *urlConnection;
}
@property(nonatomic,retain)  NSMutableData *mutableData;
@property(nonatomic,retain)  NSURLConnection *urlConnection;
@end
