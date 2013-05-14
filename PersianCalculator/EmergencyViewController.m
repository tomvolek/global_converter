//
//  EmergencyViewController.m
//  PersianCalculatorPro
//
//  Created by volek on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EmergencyViewController.h"
#import <CoreLocation/CoreLocation.h>


@implementation EmergencyViewController

@synthesize  _mapView,
             locationManager,
             currentLocation;


-(BOOL) checkIfPhoneCanOpenAppUrlScheme:(NSString *) aCustomURLScheme
{
    NSURL *url = [NSURL URLWithString: aCustomURLScheme];
    return [[UIApplication sharedApplication] canOpenURL: url];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view
calloutAccessoryControlTapped:(UIControl *)control {
    //NSString *phoneNo = view.annotation.subtitle;
   // NSString *telString = [NSString stringWithFormat:@"telprompt://%@", phoneNo];
   
    MKPointAnnotation *annotationTapped = (MKPointAnnotation *)view.annotation;
    NSString *telString = [NSString stringWithFormat:@"tel://%@", annotationTapped.subtitle];
    [self postStatusUpdateClick:annotationTapped.subtitle withCoordinate:annotationTapped.coordinate];
    
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
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(FBLoginNotification:)
                                                     name:@"FBLoginInfo"
                                                   object:nil];
    }
    return self;
}

- (void) FBLoginNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:@"FBLoginInfo"]) {
        NSError *error = [notification.userInfo objectForKey:@"error"];
        [self loginView:nil handleError:error];
    }
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
    
    // code for FB start 
    NSArray *perms;
    perms = [NSArray arrayWithObjects:@"status_update", nil];
    [self setFBLoginView:nil];
    //FBLoginView *loginview =
    //[[FBLoginView alloc] initWithPermissions:perms];
    //[FBSession openActiveSessionWithAllowLoginUI:YES];
    
    //loginview.frame = CGRectOffset(loginview.frame, 5, 5);
    //loginview.delegate = self;
    
    //[self.view addSubview:loginview];
    
    // code for FB end 
    
    
    // Do any additional setup after loading the view from its nib.
    // setup the CoreLocation 
    self.locationManager = [[[CLLocationManager alloc] init] autorelease];

    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager setDelegate:self];
    [locationManager startUpdatingLocation];
    //[locationManager release]; released in dealloc
    
    cityAnnotations = [[NSMutableArray  alloc ]initWithCapacity:40];
    NSURL *URL = [NSURL URLWithString:@"tel://900-3440-567"];
    
    capitalCity =
        [[NSArray arrayWithObjects:
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"United States", @"country",
          @"16509611964", @"phone",
          [NSNumber numberWithInt: 38.895000], @"lat",
          [NSNumber numberWithInt: -77.036667], @"long",
          nil],
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
            @"Canada", @"country",
            @"911", @"phone",
            [NSNumber numberWithInt: 45.4215296], @"lat",
            [NSNumber numberWithInt: -75.6971931], @"long",
            nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"Cayman Islands", @"country",
          @"911", @"phone",
          [NSNumber numberWithInt: 19.3298095], @"lat",
          [NSNumber numberWithInt: -81.252337], @"long",
          nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"Chile", @"country",
          @"133", @"phone",
          [NSNumber numberWithInt: -35.675147], @"lat",
          [NSNumber numberWithInt:  -71.542969], @"long",
          nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"China", @"country",
          @"110", @"phone",
          [NSNumber numberWithInt: 35.86166], @"lat",
          [NSNumber numberWithInt:  104.195397], @"long",
          nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"Costa Rica", @"country",
          @"911", @"phone",
          [NSNumber numberWithInt: 9.748917], @"lat",
          [NSNumber numberWithInt:  -83.753428], @"long",
          nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"Croatia", @"country",
          @"192", @"phone",
          [NSNumber numberWithInt: 45.7533427], @"lat",
          [NSNumber numberWithInt:  15.9891256], @"long",
          nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"Cuba", @"country",
          @"26811", @"phone",
          [NSNumber numberWithInt: 21.521757], @"lat",
          [NSNumber numberWithInt:  -77.781167], @"long",
          nil],

        [NSDictionary dictionaryWithObjectsAndKeys:
             @"Mexico", @"country",
             @"911", @"phone",
             [NSNumber numberWithInt: 19.4326077], @"lat",
             [NSNumber numberWithInt: -99.133208], @"long",
             nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"Iran", @"country",
          @"110", @"phone",
          [NSNumber numberWithInt: 32.427908], @"lat",
          [NSNumber numberWithInt: 53.688046], @"long",
          nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
         @"Egypt", @"country",
         @"110", @"phone",
         [NSNumber numberWithInt: 26.820553], @"lat",
         [NSNumber numberWithInt: 30.802498], @"long",
         nil],
         [NSDictionary dictionaryWithObjectsAndKeys:
          @"Egypt", @"country",
          @"110", @"phone",
          [NSNumber numberWithInt: 26.820553], @"lat",
          [NSNumber numberWithInt: 30.802498], @"long",
          nil],
         
       nil] retain];
    
    
}

// FB start code 
- (IBAction)poststatus:(UIButton *)sender {
    NSString *message = [NSString stringWithFormat:@"Test staus update"];
    
    [FBRequestConnection startForPostStatusUpdate:message
                                completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                    
                                    [self showAlert:message result:result error:error];
                                    
                                }];
}
- (void)showAlert:(NSString *)message
           result:(id)result
            error:(NSError *)error {
    
    NSString *alertMsg;
    NSString *alertTitle;
    if (error) {
        alertMsg = error.localizedDescription;
        alertTitle = @"Error";
    } else {
        NSDictionary *resultDict = (NSDictionary *)result;
        alertMsg = [NSString stringWithFormat:@"Successfully posted '%@'.\nPost ID: %@",
                    message, [resultDict valueForKey:@"id"]];
        alertTitle = @"Success";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                        message:alertMsg
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

// FB code end 


- (void)viewDidUnload
{
    [locationManager stopUpdatingLocation];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.locationManager = nil;
}



- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    // NSLog(@”this is %f, %f”,newLocation.coordinate.latitude,newLocation.coordinate.longitude);
    self.currentLocation = newLocation;
    if(newLocation.horizontalAccuracy <= 100.0f) { [locationManager stopUpdatingLocation]; }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if(error.code == kCLErrorDenied) {
        [locationManager stopUpdatingLocation];
    } else if(error.code == kCLErrorLocationUnknown) {
        // retry
    } else {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error retrieving location"
                                              message:[error description]
                                              delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil] autorelease];
        [alert show];
        }

    }


- (void)viewWillAppear:(BOOL)animated {  
    // 1
    
    CLLocationCoordinate2D zoomLocation;
    //zoomLocation.latitude = 39.281516;
    //zoomLocation.longitude= -76.580806;
    
  
    zoomLocation.latitude = 53.709807;
    zoomLocation.longitude= 32.953389;
    NSLog(@"lat%f",self.currentLocation.coordinate.latitude);
    NSLog(@"long%f",currentLocation.coordinate.longitude);
    
    //zoomLocation.latitude =  currentLocation.coordinate.latitude ;
;
    //zoomLocation.longitude=  currentLocation.coordinate.longitude;

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
    [locationManager release];
}

#pragma mark - FBLoginView delegate

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    // Upon login, transition to the main UI by pushing it onto the navigation stack.
    //SCAppDelegate *appDelegate = (SCAppDelegate *)[UIApplication sharedApplication].delegate;
    //[self.navigationController pushViewController:((UIViewController *)appDelegate.mainViewController) animated:YES];
    self.FBLoginView.hidden = YES;
}

- (void)loginView:(FBLoginView *)loginView
      handleError:(NSError *)error{
    NSString *alertMessage, *alertTitle;
    
    // Facebook SDK * error handling *
    // Error handling is an important part of providing a good user experience.
    // Since this sample uses the FBLoginView, this delegate will respond to
    // login failures, or other failures that have closed the session (such
    // as a token becoming invalid). Please see the [- postOpenGraphAction:]
    // and [- requestPermissionAndPost] on `SCViewController` for further
    // error handling on other operations.
    
    if (error.fberrorShouldNotifyUser) {
        // If the SDK has a message for the user, surface it. This conveniently
        // handles cases like password change or iOS6 app slider state.
        alertTitle = @"Something Went Wrong";
        alertMessage = error.fberrorUserMessage;
    } else if (error.fberrorCategory == FBErrorCategoryAuthenticationReopenSession) {
        // It is important to handle session closures as mentioned. You can inspect
        // the error for more context but this sample generically notifies the user.
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
    } else if (error.fberrorCategory == FBErrorCategoryUserCancelled) {
        // The user has cancelled a login. You can inspect the error
        // for more context. For this sample, we will simply ignore it.
        NSLog(@"user cancelled login");
    } else {
        // For simplicity, this sample treats other errors blindly, but you should
        // refer to https://developers.facebook.com/docs/technical-guides/iossdk/errors/ for more information.
        alertTitle  = @"Unknown Error";
        alertMessage = @"Error. Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    // Facebook SDK * login flow *
    // It is important to always handle session closure because it can happen
    // externally; for example, if the current session's access token becomes
    // invalid. For this sample, we simply pop back to the landing page.
    //SCAppDelegate *appDelegate = (SCAppDelegate *)[UIApplication sharedApplication].delegate;
    //if (appDelegate.isNavigating) {
        // The delay is for the edge case where a session is immediately closed after
        // logging in and our navigation controller is still animating a push.
    //    [self performSelector:@selector(logOut) withObject:nil afterDelay:.5];
    //} else {
    //    [self logOut];
    //}
    [self logOut];
}

- (void)logOut {
    self.FBLoginView.hidden = NO;
    //[self.navigationController popToRootViewControllerAnimated:YES];
}

// Convenience method to perform some action that requires the "publish_actions" permissions.
- (void) performPublishAction:(void (^)(void)) action {
    // we defer request for permission to post to the moment of post, then we check for the permission
    if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound) {
        // if we don't already have the permission, then we request it now
        [FBSession.activeSession requestNewPublishPermissions:@[@"publish_actions"]
                                              defaultAudience:FBSessionDefaultAudienceFriends
                                            completionHandler:^(FBSession *session, NSError *error) {
                                                if (!error) {
                                                    action();
                                                }
                                                //For this example, ignore errors (such as if user cancels).
                                            }];
    } else {
        action();
    }
    
}

// Post Status Update button handler; will attempt different approaches depending upon configuration.
- (void)postStatusUpdateClick:(NSString *)data  withCoordinate:(CLLocationCoordinate2D)coordinate {
    // Post a status update to the user's feed via the Graph API, and display an alert view
    // with the results or an error.
    
    NSURL *urlToShare = [NSURL URLWithString:@"http://developers.facebook.com/ios"];
    
    // This code demonstrates 3 different ways of sharing using the Facebook SDK.
    // The first method tries to share via the Facebook app. This allows sharing without
    // the user having to authorize your app, and is available as long as the user has the
    // correct Facebook app installed. This publish will result in a fast-app-switch to the
    // Facebook app.
    // The second method tries to share via Facebook's iOS6 integration, which also
    // allows sharing without the user having to authorize your app, and is available as
    // long as the user has linked their Facebook account with iOS6. This publish will
    // result in a popup iOS6 dialog.
    // The third method tries to share via a Graph API request. This does require the user
    // to authorize your app. They must also grant your app publish permissions. This
    // allows the app to publish without any user interaction.
    
    // If it is available, we will first try to post using the share dialog in the Facebook app
    FBAppCall *appCall = [FBDialogs presentShareDialogWithLink:urlToShare
                                                          name:@"Hello Facebook"
                                                       caption:nil
                                                   description:@"The 'Hello Facebook' sample application showcases simple Facebook integration."
                                                       picture:nil
                                                   clientState:nil
                                                       handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                                           if (error) {
                                                               NSLog(@"Error: %@", error.description);
                                                           } else {
                                                               NSLog(@"Success!");
                                                           }
                                                       }];
    
    if (!appCall) {
        // Next try to post using Facebook's iOS6 integration
        BOOL displayedNativeDialog = [FBDialogs presentOSIntegratedShareDialogModallyFrom:self
                                                                              initialText:nil
                                                                                    image:nil
                                                                                      url:urlToShare
                                                                                  handler:nil];
        
        if (!displayedNativeDialog) {
            // Lastly, fall back on a request for permissions and a direct post using the Graph API
            [self performPublishAction:^{
                NSString *message = [NSString stringWithFormat:@"Updating status for %@ at %@",data, [NSDate date]];
                
                [FBRequestConnection startForPostStatusUpdate:message
                                           // place:<#(id)#> tags:nil,
                                            completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                                
                                                [self showAlert:message result:result error:error];
                                                //self.buttonPostStatus.enabled = YES;
                                            }];
                
                //self.buttonPostStatus.enabled = NO;
            }];
        }
    }
}

@end
