//
//  EmergencyViewController.h
//  PersianCalculatorPro
//
//  Created by volek on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#define METERS_PER_MILE 1609.344


@interface EmergencyViewController : UIViewController <MKMapViewDelegate>{
    BOOL _doneInitialZoom;
    
    NSMutableArray *cityAnnotations;
    NSArray *capitalCity;
}

@property (retain, nonatomic) IBOutlet MKMapView *_mapView;

-(BOOL) checkIfPhoneCanOpenAppUrlScheme:(NSString *) aCustomURLScheme;


@end
