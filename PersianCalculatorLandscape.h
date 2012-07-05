//
//  PersianCalculatorLandscape.h
//  PersianCalculator
//
//  Created by volek on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <AVFoundation/AVFoundation.h>
#import <Foundation/FoundationErrors.h>
#import "DDMathParser.h"
#import "CalcLocalize.h"
#import "LocalizationHelper.h"
#import "InfoViewController.h"




//#import "CalculatorViewController.h"

@interface PersianCalculatorLandscape : UIViewController<MFMailComposeViewControllerDelegate,UITextViewDelegate, UINavigationControllerDelegate,AVAudioPlayerDelegate,UIAlertViewDelegate> {
    
    
    IBOutlet UITextView *display; //Label to display results
    IBOutlet UILabel    *degreeLabel;
    IBOutlet UIButton   *sinButton;
    IBOutlet UIButton   *cosButton;
    IBOutlet UIButton   *tanButton;
    IBOutlet UIButton   *lnButton;
    IBOutlet UIButton   *sinhButton;
    IBOutlet UIButton   *coshButton;
    IBOutlet UIButton   *tanhButton;
    IBOutlet UIButton   *exButton;
    IBOutlet UIButton  *infoButton;
    
    NSMutableArray      *calcRecord;
    NSString            *degreeButton; // Degree or ran button value           
    int                 secondButtonFlag;//flag for pressing 2nd button 

    AVAudioPlayer   *theAudio;
    UIImageView     *magnifiedLetter;
    UIImageView     *magnifiedLetterRubOut;
    NSString        *memory;
    int             selectedTabindex;
}

@property (nonatomic,retain) UITextView *display;
@property (nonatomic,retain) UILabel *degreeLabel;
@property (nonatomic,retain) UIButton *sinButton;
@property (nonatomic,retain) UIButton *cosButton;
@property (nonatomic,retain) UIButton *tanButton;
@property (nonatomic,retain) UIButton *lnButton;
@property (nonatomic,retain) UIButton *sinhButton;
@property (nonatomic,retain) UIButton *coshButton;
@property (nonatomic,retain) UIButton *tanhButton;
@property (nonatomic,retain) UIButton *exButton;
@property (nonatomic,retain) UIImageView *magnifiedLetter;
@property (nonatomic,retain) UIImageView *magnifiedLetterRubOut;

@property (nonatomic,retain) NSMutableArray *calcRecord;
@property (nonatomic,retain) NSString *inputedFormula ;
@property (nonatomic,retain) NSString  *memory ;

-(NSString*) convertLocalizedToUSNumbers:(id) sender;
-(NSString*) convertUSToLocalizedNumbers:(id) sender;

-(IBAction) clear;
-(IBAction) removeLastCharacter;
-(IBAction) equalButtonLandscape:(id) sender;
-(IBAction) emailResults;

-(IBAction) userTouchDown:(id) sender;
-(IBAction) signPressed:(id) sender ; 
-(IBAction) numericKeyPressed:(id) sender ;
-(IBAction) secondButton:(id)sender ;
-(IBAction) showInfo:(id) sender;
-(IBAction) showDoneMessage:(id)sender;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil whichTab:(int)tabselected;

@end
