//
//  FBFViewController.h
//  GraphX
//
//  Created by Bayon Forte on 2/20/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//
//http://www.raywenderlich.com/13269/how-to-draw-graphs-with-core-plot-part-1
#import <UIKit/UIKit.h>

@interface CPDPieChartViewController : UIViewController <CPTPlotDataSource, UIActionSheetDelegate>
@property (nonatomic, strong) IBOutlet UIToolbar *toolbar;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *themeButton;

-(IBAction)themeTapped:(id)sender;
@end
