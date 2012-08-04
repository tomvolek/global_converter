//
//  CurrencyViewController.h
//  PersianCalculatorPro
//
//  Created by volek on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "CountryInfo.h"
#import "DDUnitConversion.h"
#import "DDUnitConverter.h"
#import "DDCurrencyUnitConverter.h"
#import "LocalizationHelper.h"
#import "CalcLocalize.h"
#import "customKeyboard.h"


@interface CurrencyViewController : UIViewController <UITextFieldDelegate>

{
    UIPickerView       *pickerFrom;
    NSMutableArray     *countryFlagImage;
    NSMutableArray     *AllCountryFlagImage;
    NSArray            *currencySymbol;
    NSArray            *exchangeRates;
    UILabel            *resultLabel;
    UILabel            *lastupdated;
    UITextField        *dollarText;
    
    
    float              currencyFromRate ;
    float              currencyToRate;
    
    NSMutableDictionary *currencyList;
    NSMutableArray *countryCurrancyList;
    NSMutableArray *currentCurrancylist;
    
    NSMutableArray      *countryNames;
    NSMutableArray      *AllCountryNames;
    NSMutableArray      *favorites;
    NSInteger           *currecncyFromRowIndex;
    AVAudioPlayer       *theAudio;
    CustomKeyboard      *keyboardView;
    NSInteger           component0Position;
    NSInteger           component1Position;
    
}

@property (nonatomic,retain)  IBOutlet UIPickerView *pickerFrom;
@property (nonatomic,retain)  IBOutlet UILabel *resultLabel;
@property (nonatomic,retain)  IBOutlet UILabel *lastupdated;
@property (nonatomic,retain)  IBOutlet UITextField *dollarText;
@property (nonatomic,retain)  IBOutlet UIButton *plusFavorite;
@property (nonatomic,retain)  IBOutlet UIButton *minusFavorite;

@property (nonatomic,retain)  NSMutableArray *countryNames;
@property (nonatomic,retain)  NSMutableArray *AllCountryNames;
@property (nonatomic,retain)  NSMutableArray *countryFlagImage;
@property (nonatomic,retain)  NSMutableArray *AllCountryFlagImage;
@property (nonatomic,retain)  NSMutableArray *favorites ;
@property (nonatomic,retain)  NSMutableArray *countryCurrancyList;
@property (nonatomic,retain)  NSMutableArray *currentCurrancylist;

@property (nonatomic,retain)  NSMutableDictionary *currencyList;
@property (nonatomic,retain)  NSArray *exchangeRates;
@property (nonatomic,retain)  NSArray *currencySymbol;



@property (nonatomic,retain) CustomKeyboard *keyboardView;


//-(IBAction) textFieldReturn: (id) sender;

-(IBAction) lastUpdated;
-(IBAction) keyboardShow;
-(IBAction) keyboardHide;
-(IBAction) addtoFavorite;
-(IBAction) removeFromFavorite;
-(IBAction) listFavorite;
-(IBAction) listAll;


-(void) keyPressed: (id)sender;
-(void) equalKey;



@end