//
//  EmergencyViewController.m
//  PersianCalculatorPro
//
//  Created by volek on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EmergencyViewController.h"

@implementation EmergencyViewController

@synthesize  _mapView;

-(BOOL) checkIfPhoneCanOpenAppUrlScheme:(NSString *) aCustomURLScheme
{
    NSURL *url = [NSURL URLWithString: aCustomURLScheme];
    return [[UIApplication sharedApplication] canOpenURL: url];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view
calloutAccessoryControlTapped:(UIControl *)control {
    //NSString *phoneNo = view.annotation.subtitle;
   // NSString *telString = [NSString stringWithFormat:@"telprompt://%@", phoneNo];
    NSString *telString = [NSString stringWithFormat:@"tel://16509611964"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telString]];
}

- (MKAnnotationView *)mapView:(MKMapView *)sender viewForAnnotation:(id < MKAnnotation >)annotation
{
    static NSString *reuseId = @"StandardPin";
    
    MKPinAnnotationView *aView = (MKPinAnnotationView *)[sender
                                                         dequeueReusableAnnotationViewWithIdentifier:reuseId];
    if (aView == nil)
    {
        aView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                 reuseIdentifier:reuseId] autorelease];
        aView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        aView.canShowCallout = YES;
    }
    
    aView.annotation = annotation;
    
    return aView;   
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //_mapView.delegate = self;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    /*
     you can open URLs by using UIApplication's openURL: method. note that certain devices have no Phone; you can use canOpenURL: to test if you can call first.
     */
    if ([self checkIfPhoneCanOpenAppUrlScheme:@"tel://"])
    {
        NSLog(@"can make phone call");
    }
    else
    {
        NSLog(@" No Phone device");
    }
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    cityAnnotations = [[NSMutableArray  alloc ]initWithCapacity:40];
    //NSURL *URL = [NSURL URLWithString:@"tel://900-3440-567"];
    
    capitalCity =
        [NSArray arrayWithObjects:
         [NSDictionary dictionaryWithObjectsAndKeys:
             @"kabul", @"country",
             @"119", @"phone",
             [NSNumber numberWithInt: 34.528455], @"lat",
             [NSNumber numberWithInt: 69.1717029], @"long",
            nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
            @"Albania", @"country",
            @"129", @"phone",
            [NSNumber numberWithInt: 41.153332], @"lat",
            [NSNumber numberWithInt: 20.168331], @"long",
            nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
             @"Algeria", @"country",
             @"17", @"phone",
             [NSNumber numberWithInt: 36.7520891569463], @"lat",
            [NSNumber numberWithInt: 3.0377197265625], @"long",
          nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"American Samoa", @"country",
          @"911", @"phone",
          [NSNumber numberWithInt: -14.305941], @"lat",
          [NSNumber numberWithInt: -170.6962002], @"long",
          nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"Angola", @"country",
          @"110", @"phone",
          [NSNumber numberWithInt: -11.202692], @"lat",
          [NSNumber numberWithInt: 17.873887], @"long",
          nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"Argentina", @"country",
          @"101", @"phone",
          [NSNumber numberWithInt: -38.416097], @"lat",
          [NSNumber numberWithInt: -63.616672], @"long",
          nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"Armenia", @"country",
          @"102", @"phone",
          [NSNumber numberWithInt: 40.069099], @"lat",
          [NSNumber numberWithInt: 45.038189], @"long",
          nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"Australia", @"country",
          @"112", @"phone",
          [NSNumber numberWithInt: -25.274398], @"lat",
          [NSNumber numberWithInt: 133.775136], @"long",
          nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"Australia", @"country",
          @"112", @"phone",
          [NSNumber numberWithInt: -25.274398], @"lat",
          [NSNumber numberWithInt: 133.775136], @"long",
          nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"Austria", @"country",
          @"113", @"phone",
          [NSNumber numberWithInt: 47.516231], @"lat",
          [NSNumber numberWithInt: 14.550072], @"long",
          nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"Azerbaijan", @"country",
          @"02", @"phone",
          [NSNumber numberWithInt: 40.143105], @"lat",
          [NSNumber numberWithInt: 47.576927], @"long",
          nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"Bahamas", @"country",
          @"911", @"phone",
          [NSNumber numberWithInt: 25.03428], @"lat",
          [NSNumber numberWithInt: -77.39628], @"long",
          nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"Bahrain", @"country",
          @"999", @"phone",
          [NSNumber numberWithInt: 26.0667], @"lat",
          [NSNumber numberWithInt: 50.5577], @"long",
          nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"Bangladesh", @"country",
          @"999", @"phone",
          [NSNumber numberWithInt: 23.684994], @"lat",
          [NSNumber numberWithInt: 90.356331], @"long",
          nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"Barbados", @"country",
          @"211", @"phone",
          [NSNumber numberWithInt: 13.193887], @"lat",
          [NSNumber numberWithInt: -59.543198], @"long",
          nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"Belarus", @"country",
          @"102", @"phone",
          [NSNumber numberWithInt: 53.709807], @"lat",
          [NSNumber numberWithInt: 27.953389], @"long",
          nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"Belgium", @"country",
          @"112", @"phone",
          [NSNumber numberWithInt: 50.503887], @"lat",
          [NSNumber numberWithInt: 4.469936], @"long",
          nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"Bolivia", @"country",
          @"110", @"phone",
          [NSNumber numberWithInt: -16.290154], @"lat",
          [NSNumber numberWithInt: -63.588653], @"long",
          nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"Bosnia-Herzegovina", @"country",
          @"112", @"phone",
          [NSNumber numberWithInt: 43.915886], @"lat",
          [NSNumber numberWithInt: 17.679076], @"long",
          nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"Botswana", @"country",
          @"911", @"phone",
          [NSNumber numberWithInt: -22.328474], @"lat",
          [NSNumber numberWithInt: 24.684866], @"long",
          nil],
        [NSDictionary dictionaryWithObjectsAndKeys:
            @"United States", @"country",
            @"16509611964", @"phone",
            [NSNumber numberWithInt: 38.895000], @"lat",
            [NSNumber numberWithInt: -77.036667], @"long",
            nil],
        [NSDictionary dictionaryWithObjectsAndKeys:
            @"Canada", @"country",
            @"911", @"phone",
            [NSNumber numberWithInt: 45.4215296], @"lat",
            [NSNumber numberWithInt: -75.6971931], @"long",
            nil],
        [NSDictionary dictionaryWithObjectsAndKeys:
             @"Mexico", @"country",
             @"911", @"phone",
             [NSNumber numberWithInt: 19.4326077], @"lat",
             [NSNumber numberWithInt: -99.133208], @"long",
             nil],
       nil];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {  
    // 1
    CLLocationCoordinate2D zoomLocation;
    //zoomLocation.latitude = 39.281516;
    //zoomLocation.longitude= -76.580806;
    
    zoomLocation.latitude = 38.895000;
    zoomLocation.longitude= -77.036667;
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 2500.5*METERS_PER_MILE, 2500.5*METERS_PER_MILE);
    // 3
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];                
    // 4
    [_mapView setRegion:adjustedRegion animated:YES];
    
    //Add anotations for capital of each country and show the emergancy number 
    CLLocationCoordinate2D annotationCoord;
    
    annotationCoord.latitude = 38.895000;
    annotationCoord.longitude = -77.036667;
    for (int i=0; i < [capitalCity count] ; i++){
        
        annotationCoord.latitude = [[[capitalCity objectAtIndex:i] objectForKey:@"lat"] doubleValue];
        annotationCoord.longitude = [[[capitalCity objectAtIndex:i] objectForKey:@"long"] doubleValue];
    
        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = annotationCoord;
        annotationPoint.title = [[capitalCity objectAtIndex:i] objectForKey:@"country"];
        annotationPoint.subtitle = [[capitalCity objectAtIndex:i] objectForKey:@"phone"];
        
        [_mapView addAnnotation:annotationPoint];
        //[cityAnnotations addObject:annotationPoint];
        [annotationPoint release];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    //Return YES for supported orientations
    return YES;
}

-(void)dealloc{
    //[title release];
    [super dealloc];
}

@end
