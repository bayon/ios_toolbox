//
//  DetailViewController.m
//  CollectionViewX
//
//  Created by Bayon Forte on 2/24/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (nonatomic, weak) IBOutlet UIImageView *imageView;@end

@implementation DetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.imageView.image = self.image;
}


@end
