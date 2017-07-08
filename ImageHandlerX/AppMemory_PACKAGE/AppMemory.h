//
//  AppMemory.h
//  jack
//
//  Created by frederick forte on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDataObject.h"

@interface AppMemory : AppDataObject{
    NSString *mem_text1;
    NSString *mem_text2;
    
    NSString *mem_master_id;
    NSString *mem_detail_id;
    NSString *mem_subdetai_id; 
    
    NSString *mem_master_name;
    NSString *mem_detail_name;
    NSString *mem_subdetai_name;
    
    NSMutableArray *mutableArray;
    
}
@property(nonatomic,copy)NSString *mem_text1;
@property(nonatomic,copy)NSString *mem_text2;
 
@property(nonatomic,retain)NSString *mem_master_id;
@property(nonatomic,retain)NSString *mem_detail_id;
@property(nonatomic,retain)NSString *mem_subdetail_id;

@property(nonatomic,retain)NSString *mem_master_name;
@property(nonatomic,retain)NSString *mem_detail_name;
@property(nonatomic,retain)NSString *mem_subdetail_name;

@property(nonatomic,retain) NSMutableArray *mutableArray;

@end