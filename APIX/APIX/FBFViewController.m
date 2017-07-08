//
//  FBFViewController.m
//  APIX
//
//  Created by Bayon Forte on 2/19/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "FBFViewController.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "AsyncNetwork.h"
#import "Constants.h"
#import "AsyncXMLNetwork.h"


@interface FBFViewController ()
{
	UIActivityIndicatorView *spinner;
	AsyncNetwork *asyncNetwork;
    AsyncXMLNetwork *asyncXMLNetwork;
    
}
@property (nonatomic, retain) UIActivityIndicatorView *spinner;
@property (nonatomic, assign) BOOL isJSON;
@end

@implementation FBFViewController

@synthesize   artistTableView, arrayOfArtistModels, enterButton, textInput, tap, spinner;
@synthesize      reachability, isJSON;

- (void)viewDidLoad {
	[super viewDidLoad];
    isJSON = true;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(afterAsyncThreadCompletes:) name:kNotifySuccess object:asyncNetwork];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataFailed) name:kNotifyFail object:nil];
    
	spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	textInput.delegate = self;
	[enterButton resignFirstResponder];
	tap = [[UITapGestureRecognizer alloc]
	       initWithTarget:self
           action:@selector(dismissKeyboard)];
	[self.view addGestureRecognizer:tap];
    
	[textInput setText:@"rem"];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (IBAction)process:(id)sender {
	Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
	NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
	if (networkStatus == NotReachable) {
		NSString *msg = @"Please check your network";
		UIAlertView *alertmsg = [[UIAlertView alloc] initWithTitle:@"Network" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
		[alertmsg show];
	}
	else {
        
        if( isJSON ){
            spinner.center = CGPointMake(160, 70);
            spinner.hidesWhenStopped = YES;
            [self.view addSubview:spinner];
            [spinner startAnimating];
            [self dismissKeyboard];
            NSString *baseURL = @"http://ws.spotify.com/search/1/album.json?q=%@";
            asyncNetwork = [[AsyncNetwork alloc]init];
            
            [asyncNetwork load:baseURL withSearchTerm:textInput.text];
        }else{
            NSLog(@"XML testing....");
            NSString *baseURL = @"http://api.geonames.org/postalCodeSearch?";
            
            // needs username and passsord
            //hashMapQueryKeysAndValues.put("username", "indatustest");
            //send a dictionary of parameters { "postalcode"= textInput.text, "username" = "indatustest" }
            NSDictionary *dictionaryOfQueryParams = @{
                                      @"postalcode": textInput.text,
                                      @"username": @"indatustest"
                                      };
            
            asyncXMLNetwork = [[AsyncXMLNetwork alloc]init];
           // [asyncXMLNetwork load:baseURL withSearchTerm:textInput.text];
            [asyncXMLNetwork load:baseURL withParameters:dictionaryOfQueryParams];
            
        }
        
		
	}
}

-(IBAction)segmentedAction :(id)sender{
    
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        NSLog(@"JSON");
         isJSON = true;
        
    }else{
        NSLog(@"XML");
         isJSON = false;
        
    }
    
}








- (void)dataFailed {
	NSString *msg =  @"Failed to get data with space in search word.";
	UIAlertView *alertmsg = [[UIAlertView alloc] initWithTitle:@"No Data" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
	[alertmsg show];
	[spinner stopAnimating];
}

- (void)afterAsyncThreadCompletes:(NSNotification *)notification {
	arrayOfArtistModels = [notification userInfo][kArrayOfMusicModels];
	[self.artistTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
	[spinner stopAnimating];
}

#pragma mark - Table Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [arrayOfArtistModels count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	MusicCell *cell = (MusicCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[MusicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	MusicModel *musicModel = arrayOfArtistModels[indexPath.row];
	cell.leftLabel.text = musicModel.artist;
	cell.rightLabel.text = musicModel.album;
    
	return cell;
}

#pragma mark - TextField Delegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textInput resignFirstResponder];
	[enterButton resignFirstResponder];
	[self process:nil];
    
	return YES;
}

- (void)dismissKeyboard {
	[textInput resignFirstResponder];
}
@end









/*
 //SEGMENTED CONTROLLER 
 
 //SEGMENTED CONTROL
 NSArray *itemArray = [NSArray arrayWithObjects: @"Estimates", @"Projects", nil];
 UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
 segmentedControl.frame = CGRectMake(275, 10, 250, 40);
 segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
 [segmentedControl addTarget:self action:@selector(action:)  forControlEvents:UIControlEventValueChanged];
 segmentedControl.selectedSegmentIndex = 1;
 [viewContainer addSubview:segmentedControl];
 
 //action: Change View
- (void)action:(id)sender{
NSLog(@"FILE->FUNCTION: %s",__FUNCTION__);
UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;

 if (selectedSegment == 0) {
 //NSLog(@"A");
 UIView *estimatesView = [[UIView alloc] initWithFrame:CGRectMake( 0, 80, 800, 1000 )]; 
 estimatesView.backgroundColor =[UIColor whiteColor];
 [self.view addSubview:estimatesView];
 }else{
 //NSLog(@"B");
 UIView *projectsView = [[UIView alloc] initWithFrame:CGRectMake( 0, 80, 800, 1000 )]; 
 projectsView.backgroundColor =[UIColor grayColor];
 [self.view addSubview:projectsView];
 }
 
 
 //FROM NIB FILE
 //FROM NIB FILE
 UIViewController *vc = [[UIViewController alloc] initWithNibName:@"EstimatesView" bundle:nil];
 UIView *estimatesView = vc.view;
 estimatesView.backgroundColor =[UIColor yellowColor];
 estimatesView.frame = CGRectMake( 0, 80, 800, 1000 );
 [self.view   addSubview:estimatesView];

*/

/*
 //CHANGE COLOR
 for (int i=0; i<[segmentedControl.subviews count]; i++)
 {
 if ([[segmentedControl.subviews objectAtIndex:i]isSelected] )
 {
 //Custom Color
 UIColor *tintcolor = [UIColor colorWithRed:0.886f green:0.075f blue:0.075 alpha:1.0f ];
 [[segmentedControl.subviews objectAtIndex:i] setTintColor:tintcolor];
 break;
 }
 }

 */










