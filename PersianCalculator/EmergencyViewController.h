//
//  EmergencyViewController.h
//  PersianCalculatorPro
//
//  Created by volek on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <FacebookSDK/FacebookSDK.h>

#define METERS_PER_MILE 1609.344


@interface EmergencyViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate,FBLoginViewDelegate >
{
    BOOL _doneInitialZoom;
    CLLocationManager *locationManager;
    NSMutableArray *cityAnnotations;
    NSArray *capitalCity;
}

@property (retain, nonatomic) IBOutlet MKMapView *_mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;

@property (unsafe_unretained, nonatomic) IBOutlet FBLoginView *FBLoginView;

-(BOOL) checkIfPhoneCanOpenAppUrlScheme:(NSString *) aCustomURLScheme;


@end
