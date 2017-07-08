//
//  Cell.m
//  CollectionViewX
//
//  Created by Bayon Forte on 2/24/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "Cell.h"

@implementation Cell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        // CustomCellBackground *backgroundView = [[CustomCellBackground alloc] initWithFrame:CGRectZero];
        //self.selectedBackgroundView = backgroundView;
        //see this for details
        //https://developer.apple.com/library/ios/samplecode/CollectionView-Simple/Introduction/Intro.html
    }
    return self;
}
@end
