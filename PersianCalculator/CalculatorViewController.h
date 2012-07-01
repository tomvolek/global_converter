//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Tom Ajayebi on 2/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <AVFoundation/AVFoundation.h>

#import "InfoViewController.h"
#import "CurrencyViewController.h"
#import "PersianCalculatorLandscape.h"
#import "DDMathParser.h"
#import "CountryInfo.h"
#import "Units.h"
#import "LocalizationHelper.h"
#include <tgmath.h>

@interface CalculatorViewController : UIViewController <MFMailComposeViewControllerDelegate ,UINavigationControllerDelegate,UITextViewDelegate,AVAudioPlayerDelegate> {

    IBOutlet UITextView  *formulaDisplay;
	IBOutlet UITextView  *label; //Label to display results
    NSString             *computedFormula;
	
    //IBOutlet UIButton   *infoButton;
    
    AVAudioPlayer       *theAudio;
    NSInteger           counter;
            
    PersianCalculatorLandscape *persianViewController;

}

@property(nonatomic, retain) NSMutableArray *calcRecord;
@property(nonatomic, retain) UITextView *formulaDisplay;
@property(nonatomic, retain) NSString *computedFormula ;


-(NSString*) convertLocalizedToUSNumbers:(id) sender;
-(NSString*) convertUSToLocalizedNumbers:(id) sender;

-(IBAction) keyPressed:(id) sender ;
-(IBAction) clear;
-(IBAction) emailResults;
-(IBAction) eraseCharacter;
-(IBAction) showInfo:(id) sender;
-(IBAction) showCurrency:(id) sender;
-(IBAction) showUnits:(id) sender ;
-(IBAction) eraseFormula;


@end

