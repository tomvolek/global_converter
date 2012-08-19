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

#define METERS_PER_MILE 1609.344


@interface EmergencyViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
{
    BOOL _doneInitialZoom;
    CLLocationManager *locationManager;
    NSMutableArray *cityAnnotations;
    NSArray *capitalCity;
}

@property (retain, nonatomic) IBOutlet MKMapView *_mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;

-(BOOL) checkIfPhoneCanOpenAppUrlScheme:(NSString *) aCustomURLScheme;


@end
