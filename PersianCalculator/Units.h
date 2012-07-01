//
//  Units.h
//  PersianCalculatorPro
//
//  Created by volek on 11/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "CalcLocalize.h"
#import "LocalizationHelper.h"
#import "customKeyboard.h"
#import "DDUnitConversion.h"


@interface Units : UIViewController<AVAudioPlayerDelegate,UITextFieldDelegate,UITextViewDelegate >{
    IBOutlet UIPickerView     *unitConverter;
    IBOutlet UITextView       *fromTextView;
    IBOutlet UITextView       *toTextView;
    IBOutlet UITextField      *fromTextFeild;
    NSMutableArray            *fromUnit;
    NSMutableArray            *toUnit;
    NSMutableArray            *unitDataArray;

    AVAudioPlayer             *theAudio;
    CustomKeyboard            *keyboardView;
    NSInteger                 component0Position;
    NSInteger                 component1Position;
    NSInteger                 component2Position;
    
}

@property (nonatomic, retain) UIPickerView *unitConverter;
@property (nonatomic, retain) NSMutableArray *fromUnit; 
@property (nonatomic, retain) NSMutableArray *toUnit; 
@property (nonatomic, retain) NSMutableArray *unitDataArray;

@property (nonatomic,retain) IBOutlet UITextView *fromTextView;
@property (nonatomic,retain) IBOutlet UITextView *toTextView;
@property (nonatomic,retain) UITextField *fromTextFeild;
@property (nonatomic,retain) CustomKeyboard *keyboardView;




-(IBAction) eraseCharacter;
-(IBAction) keyboardShow;
-(IBAction) keyboardHide;

-(void) keyPressed: (id)sender;

@end


