//
//  FBFViewController.h
//  MapX
//
//  Created by Bayon Forte on 2/17/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FBFViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, retain)   IBOutlet MKMapView *mapView;
@property (nonatomic, retain)   CLLocationManager *locationManager;
@property (nonatomic, weak)     IBOutlet UIBarButtonItem *getAddressButton;
@property (nonatomic, weak)     IBOutlet UIButton *weblink;
@property (nonatomic, strong)   CLGeocoder *geocoder;
@property (nonatomic, strong)   MKPlacemark *placemark;
@property (nonatomic, strong)   IBOutlet UIImageView *tassleGraphic;

@end
