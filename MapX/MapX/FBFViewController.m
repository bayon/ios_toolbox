//
//  FBFViewController.m
//  MapX
//
//  Created by Bayon Forte on 2/17/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "FBFViewController.h"

@interface FBFViewController ()

@end

@implementation FBFViewController


@synthesize mapView,locationManager,geocoder,getAddressButton,placemark = _placemark,weblink, tassleGraphic;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [self resetOrientation];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectOrientation2) name:@"UIDeviceOrientationDidChangeNotification2" object:nil];
        
    }
    return self;
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (IBAction)openMocuraDotCom:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.mocura.com"]];
}
-(void)resetOrientation{
    
    //tassleGraphic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    //[self.view addSubview:tassleGraphic];
    //[self.view bringSubviewToFront: tassleGraphic];
    
    
}
// orientation: detect change in layout, portrait, landscape...
-(void) detectOrientation2
{
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft)
    {
        //Set up left
        [self resetOrientation];
    } else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)
    {
        //Set up Right
        [self resetOrientation];
    } else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown)
    {
        //It's portrait time!
        [self resetOrientation];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Create a geocoder and save it for later.
    self.geocoder = [[CLGeocoder alloc] init];
    
    self.mapView.delegate = self;
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.mapView setShowsUserLocation:YES];
    
    [self getLocationByWrittenAddress];
    
    
}

-(void)getLocationByWrittenAddress{
    NSString *location = @" 118 E. Main St., Louisville, KY 40202";
    //CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:location
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     if (placemarks && placemarks.count > 0) {
                         CLPlacemark *topResult = [placemarks objectAtIndex:0];
                         MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                         
                         MKCoordinateRegion region = self.mapView.region;
                         //region.center = placemark.region.center;
                         region.span.longitudeDelta /= 8.0;
                         region.span.latitudeDelta /= 8.0;
                         
                         [self.mapView setRegion:region animated:YES];
                         [self.mapView addAnnotation:placemark];
                     }
                 }
     ];
}


//zoom into location
- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
{
    MKAnnotationView *annotationView = [views objectAtIndex:0];
    id<MKAnnotation> mp = [annotationView annotation];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate] ,250,250);
    
    [mv setRegion:region animated:YES];
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
	// Center the map the first time we get a real location change.
	static dispatch_once_t centerMapFirstTime;
    
	if ((userLocation.coordinate.latitude != 0.0) && (userLocation.coordinate.longitude != 0.0)) {
		dispatch_once(&centerMapFirstTime, ^{
			[self.mapView setCenterCoordinate:userLocation.coordinate animated:YES];
		});
	}
	
	// Lookup the information for the current location of the user.
    [self.geocoder reverseGeocodeLocation:self.mapView.userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
		if ((placemarks != nil) && (placemarks.count > 0)) {
			// If the placemark is not nil then we have at least one placemark. Typically there will only be one.
			_placemark = [placemarks objectAtIndex:0];
			
			// we have received our current location, so enable the "Get Current Address" button
			[self.getAddressButton setEnabled:YES];
		}
		else {
			// Handle the nil case if necessary.
		}
    }];
}

@end
