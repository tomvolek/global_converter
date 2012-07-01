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
    IBOutlet UIStepper   *myStepper;
    IBOutlet UILabel *fractionValue;
    NSMutableArray *listOfLanguages;
    NSIndexPath *lastIndexPath;
    NSArray     *languageSet;
	int stepperValue;
}

@property (nonatomic,retain) NSArray *languageSet;
@property (nonatomic,retain) NSIndexPath *lastIndexPath;
@property (nonatomic,retain) NSMutableArray *listOfLanguages;
@property (nonatomic,retain) IBOutlet UILabel   *fractionValue;
@property (nonatomic,retain) IBOutlet UISwitch *soundSwitch;
@property (nonatomic,retain) IBOutlet UITableView *languageTableView;



-(IBAction) setSoundSwitch;
-(IBAction) saveInfoView:(id) sender;
-(IBAction) stepperValueChanged:(id)sender;

@end


