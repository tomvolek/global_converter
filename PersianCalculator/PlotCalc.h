//
//  PlotCalc.h
//  PersianCalculatorPro
//
//  Created by volek on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "LocalizationHelper.h"
#import "PersianCalculatorLandscape.h"
#import "CalcLocalize.h"
#import "customKeyboard.h"

@interface PlotCalc : UIViewController <CPTPlotDataSource,CPTPlotSpaceDelegate,UIGestureRecognizerDelegate,UIInputViewAudioFeedback,UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource>
{
    CPTXYGraph *graph;
    UIPickerView *myPickerView;
    NSArray             *equations; 
    CustomKeyboard      *keyboardView;
    AVAudioPlayer       *theAudio;
    UITextField *functionText;
    UITextField *yTextfield;
    UITextField  *inputFormula;
    UILabel *x1label, *x2label, *x3label, *x4label, *x5label, *x6label;
    UITextField *y1TextField, *y2TextField, *y3TextField, *y4TextField, *y5TextField, *y6TextField;
    
    
}

@property (nonatomic, retain)  UITextField *functionText;
@property (nonatomic, retain)  UITextField *yTextfield;
@property (nonatomic, retain)  UITextField *inputFormula;
@property (nonatomic, retain) CustomKeyboard *keyboardView;
@property (nonatomic, retain) UIPickerView *myPickerView;

@property (nonatomic, retain) UILabel *x1label;
@property (nonatomic, retain) UILabel *x2label;
@property (nonatomic, retain) UILabel *x3label;
@property (nonatomic, retain) UILabel *x4label;
@property (nonatomic, retain) UILabel *x5label;
@property (nonatomic, retain) UILabel *x6label;

@property (nonatomic, retain) UITextField *y1TextField;
@property (nonatomic, retain) UITextField *y2TextField;
@property (nonatomic, retain) UITextField *y3TextField;
@property (nonatomic, retain) UITextField *y4TextField;
@property (nonatomic, retain) UITextField *y5TextField;
@property (nonatomic, retain) UITextField *y6TextField;







-(void) keyboardShow;
-(void) keyboardHide;
-(void) keyPressed: (id)sender;
-(IBAction) plotFormula;
-(void) equalKey;

@end
