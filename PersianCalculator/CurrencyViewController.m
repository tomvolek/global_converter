//
//  currencyViewController.m
//  PersianCalculatorPro
//
//  Created by volek on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "currencyViewController.h"

@implementation CurrencyViewController

@synthesize pickerFrom, 
            countryNames,
            AllCountryNames,
            exchangeRates, 
            countryFlagImage,
            AllCountryFlagImage,
            currencySymbol,
            currencyList,
            favorites,
            keyboardView;

@synthesize resultLabel,lastupdated, dollarText;
bool soundFlag;

#pragma mark -
#pragma mark PickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [countryNames count];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView
rowHeightForComponent:(NSInteger)component {
    return 60.0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView
    widthForComponent:(NSInteger)component {
    return 160.0;
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
         forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    NSLog(@"viewForRow called ");

    UIImageView *temp = [[UIImageView alloc] initWithImage:[self.countryFlagImage objectAtIndex:row]];
    temp.frame = CGRectMake(0,0,58,58);
    
    //setup lable for Currency abbreviation
    UILabel *channelLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, -10, 58, 58)];
    channelLabel.text = [countryNames objectAtIndex:row];
    channelLabel.textAlignment = UITextAlignmentLeft;
    channelLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    channelLabel.backgroundColor = [UIColor clearColor];
    
    //setup label fo country name
    UILabel *countryNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 95, 58)];
    countryNameLabel.text = [DDCurrencyUnitConverter nameOfCurrencyUnit:row];
    countryNameLabel.textAlignment = UITextAlignmentLeft;
    countryNameLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:12];
    countryNameLabel.backgroundColor = [UIColor clearColor];
    countryNameLabel.textColor = [UIColor blueColor];
    
    UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 155, 58)];
    [tmpView insertSubview:temp atIndex:0];
    [tmpView insertSubview:channelLabel atIndex:1];
    [tmpView insertSubview:countryNameLabel atIndex:2];
    //[tmpView setBounds: CGRectMake(0, 0, tmpView.frame.size.width -20 , 44)];
   
    [temp release];
    [channelLabel release];
    [countryNameLabel release];
    //[tmpView release];
   
    //Check with boby, we are leaking when do we release tmpView
    return tmpView;
    
}


#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    UIImageView *imageView = nil;
    UILabel *label = nil;        
    UIView *view  = [self pickerView:pickerView viewForRow:row forComponent:component reusingView:nil];
    
    for (UIView  *subView in [view subviews]){
        if ([subView isKindOfClass:[UILabel class]]) {
            label  = (UILabel *) subView;
        }
        else if ([subView isKindOfClass:[UIImageView class]]) {
            imageView = (UIImageView *) subView;
        }
    }
    //Localize the numbers being displayed
    CalcLocalize *myCalcLocalize = [[CalcLocalize alloc] init];
    resultLabel.text=[myCalcLocalize convertLocalToEngNumbers:(NSString *) resultLabel.text] ;

    
   // DDUnitConverter *converter = [DDUnitConverter currencyUnitConverter];
    DDUnitConverter *converter = [DDUnitConverter currencyUnitConverter];

    NSNumber *inputAmount = [NSNumber numberWithInt:[dollarText.text floatValue]];
    NSNumber *to;

    if (component == 0 ) {
        component0Position = row;
        to = [converter convertNumber:inputAmount fromUnit:component0Position   toUnit:component1Position];
    }
    else if (component == 1){
        component1Position = row;
        to = [converter convertNumber:inputAmount fromUnit:component0Position   toUnit:component1Position];
           
        }
    
    resultLabel.text = [to stringValue];
    
    //Localize any strings on the Views
    [LocalizationHelper localizeView:self.view];
    
    //Localize the numbers being displayed
    resultLabel.text=[myCalcLocalize convertEngToLocalNumbers:(NSString *) resultLabel.text] ;
    [myCalcLocalize release ];

}


-(IBAction) listAll{
    [countryNames removeAllObjects];
    [countryNames addObjectsFromArray:AllCountryNames];
    [countryFlagImage removeAllObjects];
    [countryFlagImage addObjectsFromArray:AllCountryFlagImage];
    
    [pickerFrom reloadAllComponents];
    [pickerFrom selectRow:0 inComponent:0 animated:YES];
    [pickerFrom selectRow:0 inComponent:1 animated:YES];
}



-(IBAction) listFavorite{
    component0Position = 0 ; 
    component1Position = 0 ;
    if ([favorites count]  < 1 ) {
       [countryNames removeAllObjects];
       //self.countryNames = [favorites mutableCopy];
       [pickerFrom reloadAllComponents]; 
    }
    else {
        [countryNames removeAllObjects];
        for (int i= 0; i < [favorites count] ; i++) {
            for(NSNumber *item in [favorites objectAtIndex:i]) {
                //need to load UiPicker from favorite list. 
                NSLog(@"fav=%@",item);
            }
        }
        self.countryNames = [self.favorites mutableCopy];
        [pickerFrom reloadAllComponents];
        [pickerFrom selectRow:0 inComponent:0 animated:YES];
        [pickerFrom selectRow:0 inComponent:1 animated:YES];
    } 
    
}


-(IBAction) addtoFavorite{
    NSLog(@"compnet0Postion= %i",component0Position);
    NSLog(@"compnet1Postion= %i",component1Position);
    
    [favorites addObject:[NSArray arrayWithObjects:[NSNumber numberWithInt:component0Position],[NSNumber numberWithInt:component1Position],nil]] ;
    //[countryFlagImage addObject:<#(id)#>
     
}

-(IBAction)removeFromFavorite{
    int i;
    if ([favorites count] > 0 ) {
        NSLog(@"favorites count = %i",[favorites count]);
        for (i= 0; i < [favorites count]; i++) {
            BOOL item1;
            for(NSNumber *item in [favorites objectAtIndex:i]) {
                if ([item intValue]  == component0Position ) 
                {item1 = YES;
                    NSLog(@"item1= %i",item1);}
                    else if ( ([item intValue] == component1Position) && item1 ==YES )
                        { 
                            NSLog(@"item2= %i",item1);
                            [favorites removeObjectAtIndex: i]; //we have a match remove from favorite list
                        }      
                }
            item1= NO;
        
        }
    }

}//removefromFavorite


-(void) keyPressed: (id)sender{	
    UIButton  *keyletters = (UIButton*)sender ;
    
    if ([keyletters.titleLabel.text isEqualToString:@"="] ) {
        if ([dollarText.text length] < 1) {
            
            // Do nothing, user has pressed without any numbers
        }
        else {
            //Call the function to calculate Unit conversion 
            [self equalKey];
        }
    } 
    else if ([keyletters.titleLabel.text isEqualToString:@"C"] ) {
        
        dollarText.text=@"";
    }
    else if ([keyletters.titleLabel.text isEqualToString:@"v"] ) {
        
        [self keyboardHide];
    }
    //implement character rubout 
    else if ([keyletters.titleLabel.text isEqualToString:@"xx"] ) {
        if (dollarText.text.length < 1) { }
        else {
            dollarText.text = [dollarText.text substringToIndex:dollarText.text.length-1];
            }
        }
    else {
        //All other characters just add them to the string 
        dollarText.text = [dollarText.text  stringByAppendingString:NSLocalizedString(keyletters.titleLabel.text, nil)];
    }
} //keyPressed


-(IBAction) keyboardShow {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    self.keyboardView.transform = CGAffineTransformIdentity;
    self.keyboardView.frame = CGRectMake(0,285 , 320, 140);
    [UIView commitAnimations];
}

-(IBAction) keyboardHide {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    self.keyboardView.transform = CGAffineTransformIdentity;
    self.keyboardView.frame = CGRectMake(0,680 , 320, 140);
    [UIView commitAnimations];
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
     textField.inputView = self.keyboardView;
    [textField resignFirstResponder];
    [self keyboardShow];
   
    return NO;  // Hide both keyboard and blinking cursor.
    
}

/*
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    // do anything you want before, than:
    return NO;
}
*/



-(IBAction)lastUpdated{
    
    // Get current date time
    NSDate *currentDateTime = [NSDate date];
    // Instantiate a NSDateFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // Set the dateFormatter format
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // or this format to show day of the week Sat,11-12-2011 23:27:09
    [dateFormatter setDateFormat:@"EEE ,MM-dd-yyyy HH:mm:ss"];
    // Get the date time in NSString
    NSString *dateInStringFormated = [dateFormatter stringFromDate:currentDateTime];
    [lastupdated setText:dateInStringFormated];
    
    DDCurrencyUnitConverter *converter = [DDCurrencyUnitConverter currencyUnitConverter];
    [converter refreshExchangeRates];
    
    //Localize the numbers being displayed
    CalcLocalize *myCalcLocalize = [[CalcLocalize alloc] init];
    lastupdated.text=[myCalcLocalize convertEngToLocalNumbers:(NSString *) lastupdated.text] ;
    [myCalcLocalize release ];
}

-(void)equalKey{
    if (soundFlag) {
        [theAudio play];
    }

    CalcLocalize *myCalcLocalized = [[CalcLocalize alloc] init];
    resultLabel.text=[myCalcLocalized convertLocalToEngNumbers:resultLabel.text];
    
  //  NSUInteger selectedRowComp0 = [pickerFrom selectedRowInComponent:0];
  //  NSUInteger selectedRowComp1 = [pickerFrom selectedRowInComponent:1];
    
    
    DDUnitConverter *converter = [DDUnitConverter currencyUnitConverter];
    NSNumber *inputAmount = [NSNumber numberWithInt:[dollarText.text floatValue]];
    NSNumber *to = [converter convertNumber:inputAmount fromUnit:component0Position   toUnit:component1Position];
    resultLabel.text = [to stringValue];

    resultLabel.text=[myCalcLocalized convertEngToLocalNumbers:resultLabel.text];
    [myCalcLocalized release];

}//equalKey



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}//initWithNibName

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}//didReceiveMemoryWarning


-(void)  viewWillAppear{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    
    NSArray* languages = [userDefaults objectForKey:@"AppleLanguages"];
    
    NSString* preferredLang = [languages objectAtIndex:0];
    NSLog(@"Current Lang:currencyViewController:viewWillAper%@",preferredLang);
    
    int Index =  [[userDefaults objectForKey:@"currencyFromRow"] intValue];
    int Index2 = [[userDefaults objectForKey:@"currencyToRow"] intValue];
    
    [pickerFrom selectRow:Index inComponent:0 animated:YES];
    [pickerFrom selectRow:Index2 inComponent:1 animated:YES];
    //Localize any strings on the views
    [LocalizationHelper localizeView:self.view];
}//viewWillAppear

#pragma mark - view
- (void)viewWillDisappear:(BOOL) animated
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        [standardUserDefaults setObject:[NSNumber numberWithInt:component0Position ]forKey:@"currencyFromRow"] ;
        [standardUserDefaults setObject:[NSNumber numberWithInt:component1Position ]forKey:@"currencyToRow"] ;
    }
    [standardUserDefaults synchronize];
    
} //viewWillDisappear


#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //setup keyboard
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
   /* int Index =[[userDefaults objectForKey:@"currencyFromRow"] intValue];
    [pickerFrom selectRow:Index inComponent:0 animated:YES];
   */ 
    
    //setup initial exchange rate 
    currencyFromRate = 1;
    currencyToRate = 1;
    
    //init dialer positions
    component0Position = 0 ;
    component1Position = 0 ;
    
    dollarText.text = NSLocalizedString(dollarText.text, nil);
    dollarText.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"middleRowSelected.png"]];
    resultLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"middleRowSelected.png"]];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.favorites = [[[NSMutableArray alloc] initWithCapacity:100]autorelease];
     
    // setup dictionary  for countries currency index
    self.currencyList = [[[NSMutableDictionary alloc] initWithCapacity:100]autorelease];
    
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitEuro] forKey: @"EUR"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitJapaneseYen] forKey: @"JPY"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitUKPoundSterling] forKey: @"GBP"];
	[currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitUSDollar] forKey: @"USD"];
	[currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitAlgerianDinar] forKey: @"DZD"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitArgentinePeso] forKey: @"ARS"];
	[currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitAustralianDollar] forKey: @"AUD"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitBahrainDinar] forKey: @"BHD"];
	[currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitBotswanaPula] forKey: @"BWP"];
	[currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitBrazilianReal] forKey: @"BRL"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitBruneiDollar] forKey: @"BND"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitCanadianDollar] forKey: @"CAD"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitChileanPeso] forKey: @"CLP"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitChineseYuan] forKey: @"CNY"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitColombianPeso] forKey: @"COP"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitCzechKoruna] forKey: @"CZK"];
	[currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitDanishKrone] forKey: @"DKK"];
	[currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitHungarianForint] forKey: @"HUF"];    
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitIcelandicKrona] forKey: @"ISK"];
	[currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitIndianRupee] forKey: @"INR"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitIndonesianRupiah] forKey: @"IDR"];
	[currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitIranianRial] forKey: @"IRR"];
	[currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitIsraeliNewSheqel] forKey: @"ISL"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitKazakhstaniTenge] forKey: @"KGS"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitKoreanWon] forKey: @"KRW"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitKuwaitiDinar] forKey: @"KWD"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitLibyanDinar] forKey: @"LYD"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitMalaysianRinggit] forKey: @"MYR"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitMauritianRupee] forKey: @"MUR"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitMexicanPeso] forKey: @"MXN"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitNepaleseRupee] forKey: @"NPR"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitNewZealandDollar] forKey: @"NZD"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitNorwegianKrone] forKey: @"NOK"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitRialOmani] forKey: @"OMR"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitPakistaniRupee] forKey: @"PKR"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitNuevoSol] forKey: @"PEN"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitPhilippinePeso] forKey: @"PHP"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitPolishZloty] forKey: @"PLN"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitQatarRiyal] forKey: @"QAR"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitRussianRuble] forKey: @"RUB"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitSaudiArabianRiyal] forKey: @"SAR"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitSingaporeDollar] forKey: @"SGD"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitSouthAfricanRand] forKey: @"ZAR"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitSriLankaRupee] forKey: @"LKR"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitSwedishKrona] forKey: @"SEK"];
	[currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitSwissFranc] forKey: @"CHF"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitThaiBaht] forKey: @"THB"];
	[currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitTrinidadAndTobagoDollar] forKey: @"TTD"];
	[currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitTunisianDinar] forKey: @"TND"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitUAEDirham] forKey: @"AED"];
	[currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitPesoUruguayo] forKey: @"UYU"];
	[currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitBolivarFuerte] forKey: @"BOB"];
    [currencyList setObject: [NSNumber numberWithInt:DDCurrencyUnitSDR] forKey: @"SDR"];

    self.countryFlagImage = [[[NSMutableArray alloc] initWithCapacity:100] autorelease];
    [countryFlagImage addObject:[UIImage imageNamed:@"Euro-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Japan-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"England-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"United-States-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Algeria-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Argentina-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Australia-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Bahrain-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Botswana-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Brazil-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Brunei-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Canada-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Chile-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"China-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Colombia-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Czech-Republic-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Denmark-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Hungary-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Iceland-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"India-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Indonesia-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Iran-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Israel-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Kazakhstan-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Korea-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Kuwait-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Libya-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Malaysia-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Mauritania-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Mexico-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Nepal-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"New-Zealand-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Norway-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Oman-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Pakistan-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Peru-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Philippines-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Poland-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Qatar-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Russia-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Saudi-Arabia-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Singapore-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"South-Africa-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Sri-Lanka-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Sweden-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Swiss-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Thailand-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Trinidad-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Tunisia-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"UAE-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Uruguay-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Bolivia-Flag-64.png"]];
    [countryFlagImage addObject:[UIImage imageNamed:@"Spain-Flag-64.png"]];
                
    
    self.AllCountryFlagImage = [[[NSMutableArray alloc] initWithCapacity:100] autorelease];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Euro-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Japan-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"England-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"United-States-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Algeria-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Argentina-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Australia-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Bahrain-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Botswana-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Brazil-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Brunei-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Canada-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Chile-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"China-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Colombia-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Czech-Republic-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Denmark-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Hungary-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Iceland-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"India-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Indonesia-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Iran-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Israel-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Kazakhstan-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Korea-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Kuwait-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Libya-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Malaysia-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Mauritania-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Mexico-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Nepal-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"New-Zealand-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Norway-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Oman-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Pakistan-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Peru-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Philippines-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Poland-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Qatar-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Russia-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Saudi-Arabia-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Singapore-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"South-Africa-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Sri-Lanka-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Sweden-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Swiss-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Thailand-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Trinidad-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Tunisia-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"UAE-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Uruguay-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Bolivia-Flag-64.png"]];
    [AllCountryFlagImage addObject:[UIImage imageNamed:@"Spain-Flag-64.png"]];
                              
                              
                           

    self.countryNames = [[[NSMutableArray alloc] initWithCapacity:100] autorelease];
    [countryNames addObject:@"EUR"];
    [countryNames addObject:@"JPY"];
    [countryNames addObject:@"GBP"];
    [countryNames addObject:@"USD"];
    [countryNames addObject:@"DZD"];
    [countryNames addObject:@"ARS"];
    [countryNames addObject:@"AUD"];
    [countryNames addObject:@"BHD"];
    [countryNames addObject:@"BWP"];
    [countryNames addObject:@"BRL"];
    [countryNames addObject:@"BND"];
    [countryNames addObject:@"CAD"];
    [countryNames addObject:@"CLP"];
    [countryNames addObject:@"CNY"];
    [countryNames addObject:@"COP"];
    [countryNames addObject:@"CZK"];
    [countryNames addObject:@"DKK"];
    [countryNames addObject:@"HUF"];
    [countryNames addObject:@"ISK"];
    [countryNames addObject:@"INR"];
    [countryNames addObject:@"IDR"];
    [countryNames addObject:@"IRR"];
    [countryNames addObject:@"ISL"];
    [countryNames addObject:@"KGS"];
    [countryNames addObject:@"KRW"];
    [countryNames addObject:@"KWD"];
    [countryNames addObject:@"LYD"];
    [countryNames addObject:@"MYR"];
    [countryNames addObject:@"MUR"];
    [countryNames addObject:@"MXN"];
    [countryNames addObject:@"NPR"];
    [countryNames addObject:@"NZD"];
    [countryNames addObject:@"NOK"];
    [countryNames addObject:@"OMR"];
    [countryNames addObject:@"PKR"];
    [countryNames addObject:@"PEN"];
    [countryNames addObject:@"PHP"];
    [countryNames addObject:@"PLN"];
    [countryNames addObject:@"QAR"];
    [countryNames addObject:@"RUB"];
    [countryNames addObject:@"SAR"];
    [countryNames addObject:@"SGD"];
    [countryNames addObject:@"ZAR"];
    [countryNames addObject:@"LKR"];
    [countryNames addObject:@"SEK"];
    [countryNames addObject:@"CHF"];
    [countryNames addObject:@"THB"];
    [countryNames addObject:@"TND"];
    [countryNames addObject:@"AED"];
    [countryNames addObject:@"UYU"];
    [countryNames addObject:@"BOB"];
    [countryNames addObject:@"SDR"]; 
    

    self.AllCountryNames = [[[NSMutableArray alloc] initWithCapacity:100] autorelease];
    [AllCountryNames addObject:@"EUR"];
    [AllCountryNames addObject:@"JPY"];
    [AllCountryNames addObject:@"GBP"];
    [AllCountryNames addObject:@"USD"];
    [AllCountryNames addObject:@"DZD"];
    [AllCountryNames addObject:@"ARS"];
    [AllCountryNames addObject:@"AUD"];
    [AllCountryNames addObject:@"BHD"];
    [AllCountryNames addObject:@"BWP"];
    [AllCountryNames addObject:@"BRL"];
    [AllCountryNames addObject:@"BND"];
    [AllCountryNames addObject:@"CAD"];
    [AllCountryNames addObject:@"CLP"];
    [AllCountryNames addObject:@"CNY"];
    [AllCountryNames addObject:@"COP"];
    [AllCountryNames addObject:@"CZK"];
    [AllCountryNames addObject:@"DKK"];
    [AllCountryNames addObject:@"HUF"];
    [AllCountryNames addObject:@"ISK"];
    [AllCountryNames addObject:@"INR"];
    [AllCountryNames addObject:@"IDR"];
    [AllCountryNames addObject:@"IRR"];
    [AllCountryNames addObject:@"ISL"];
    [AllCountryNames addObject:@"KGS"];
    [AllCountryNames addObject:@"KRW"];
    [AllCountryNames addObject:@"KWD"];
    [AllCountryNames addObject:@"LYD"];
    [AllCountryNames addObject:@"MYR"];
    [AllCountryNames addObject:@"MUR"];
    [AllCountryNames addObject:@"MXN"];
    [AllCountryNames addObject:@"NPR"];
    [AllCountryNames addObject:@"NZD"];
    [AllCountryNames addObject:@"NOK"];
    [AllCountryNames addObject:@"OMR"];
    [AllCountryNames addObject:@"PKR"];
    [AllCountryNames addObject:@"PEN"];
    [AllCountryNames addObject:@"PHP"];
    [AllCountryNames addObject:@"PLN"];
    [AllCountryNames addObject:@"QAR"];
    [AllCountryNames addObject:@"RUB"];
    [AllCountryNames addObject:@"SAR"];
    [AllCountryNames addObject:@"SGD"];
    [AllCountryNames addObject:@"ZAR"];
    [AllCountryNames addObject:@"LKR"];
    [AllCountryNames addObject:@"SEK"];
    [AllCountryNames addObject:@"CHF"];
    [AllCountryNames addObject:@"THB"];
    [AllCountryNames addObject:@"TND"];
    [AllCountryNames addObject:@"AED"];
    [AllCountryNames addObject:@"UYU"];
    [AllCountryNames addObject:@"BOB"];
    [AllCountryNames addObject:@"SDR"]; 
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"worldMapBackgroud.png"]];
        
    //set the delegate for UITextfiled(dollarText
    [self.dollarText setDelegate:self];
    
    //initialize picker to a currency previously decided by user. 
    component0Position =[[userDefaults objectForKey:@"currencyFromRow"] intValue];
    component1Position = [[userDefaults objectForKey:@"currencyToRow"] intValue];
    NSLog(@"currency index=%i",component0Position);
    NSLog(@"currency index2=%i",component1Position);
    
    [pickerFrom selectRow:component0Position inComponent:0 animated:NO];
    [pickerFrom selectRow:component1Position inComponent:1 animated:NO];

   
    
    //setup custom keyboard
    self.keyboardView = [[CustomKeyboard alloc] initWithFrame:CGRectMake(0, 440, 320, 140)];
    self.keyboardView.transform = CGAffineTransformMakeTranslation(0, self.keyboardView.bounds.size.height);
    // self.keyboardView.center = CGPointMake( self.view.center.x, self.view.center.y +480);
    [self.view addSubview:keyboardView];
    self.keyboardView.center = CGPointMake( self.view.center.x, self.view.center.y +480);
    
   
    
    //setup NSNotification for receving key stroks from customKeyboard class
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:) 
                                                 name:@"TestNotification"
                                               object:nil];
    
    //Localize any strings on the views
    [LocalizationHelper localizeView:self.view];
    [[self tabBarItem] setTitle:NSLocalizedString(@"Currency",nil)];
    [self lastUpdated]; //refresh exchange rates
    
    //add our custom keyboard to the fromTextView inputview
    self.dollarText.inputView = self.keyboardView; 
     NSLog(@"countryNames Count viewdidLoad=%i",[countryNames  count]);
    
}

- (void) receiveTestNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:@"TestNotification"])
    {
        UIButton  *keyletters = (UIButton *)notification.object ;
        [self keyPressed:keyletters];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}


- (void)dealloc {
   
    [countryFlagImage release];
    [countryNames release];
    [exchangeRates release];
    [currencySymbol release];
    [pickerFrom release];
    [resultLabel release];
    [lastupdated release];
    [dollarText release];
    [AllCountryNames release];
    [countryFlagImage release];
    [AllCountryFlagImage release];
    [currencyList release];
    [favorites release];
    [CustomKeyboard release];
    
    
    [super dealloc];
}


@end
