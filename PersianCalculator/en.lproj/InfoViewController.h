//
//  InfoViewController.h
//  PersianCalculatorPro
//
//  Created by volek on 10/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalcLocalize.h"
#import "LocalizationHelper.h"
//#import "LocalizationSystem.h"


@interface InfoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    UISwitch    *soundSwitch;
    UITableView *languageTableView;
    UIStepper   *myStepper;
    UILabel *fractionValue;
    NSMutableArray *listOfLanguages;
    NSIndexPath *lastIndexPath;
    NSArray     *languageSet;
    NSString    *Fraction;
	int stepperValue;
}

@property (nonatomic,retain) NSArray *languageSet;
@property (nonatomic,retain) NSIndexPath *lastIndexPath;
@property (nonatomic,retain) NSMutableArray *listOfLanguages;
@property (nonatomic,retain) IBOutlet UISwitch *soundSwitch;
@property (nonatomic,retain) UITableView *languageTableView;
@property (nonatomic,retain) IBOutlet UIStepper   *myStepper;
@property (nonatomic,retain) IBOutlet UILabel *fractionValue;


-(IBAction) setSoundSwitch;
-(IBAction) saveInfoView:(id) sender;
-(IBAction) stepperValueChanged:(id)sender;

@end


