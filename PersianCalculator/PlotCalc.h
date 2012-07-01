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
#import "CalcLocalize.h"
#import "customKeyboard.h"

@interface PlotCalc : UIViewController <CPTPlotDataSource,CPTPlotSpaceDelegate,UIGestureRecognizerDelegate,UIInputViewAudioFeedback,UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource>
{
    CPTXYGraph *graph;
    UIPickerView *myPickerView;
    NSArray              *equations; 
    CustomKeyboard      *keyboardView;
    AVAudioPlayer       *theAudio;
    IBOutlet UITextField *functionText;
    IBOutlet UITextField *yTextfield;
    IBOutlet UITextField  *inputFormula;
    
}

@property (nonatomic, retain) IBOutlet UITextField *functionText;
@property (nonatomic, retain) IBOutlet UITextField *yTextfield;
@property (nonatomic, retain) IBOutlet UITextField *inputFormula;
@property (nonatomic, retain) CustomKeyboard *keyboardView;
@property (nonatomic,retain)  UIPickerView *myPickerView;

-(void) keyboardShow;
-(void) keyboardHide;
-(void) keyPressed: (id)sender;
-(IBAction) plotFormula;
-(void) equalKey;

@end
