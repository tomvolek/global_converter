//
//  PersianCalculatorAppDelegate.h
//  PersianCalculator
//
//  Created by volek on 4/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalculatorViewController;


@interface PersianCalculatorAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    CalculatorViewController *viewController;
     
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
//@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
//@property (nonatomic, retain) IBOutlet CalculatorViewController *viewController;

@end
