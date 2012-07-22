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


@interface EmergencyViewController : UIViewController{
    BOOL _doneInitialZoom;
}

@property (retain, nonatomic) IBOutlet MKMapView *_mapView; 

@end
