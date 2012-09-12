//
//  currencyViewController.m
//  PersianCalculatorPro
//
//  Created by volek on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "currencyViewController.h"
#import "Currency.h"
@implementation CurrencyViewController

@synthesize pickerFrom, 
            countryNames,
            AllCountryNames,
            exchangeRates, 
            countryFlagImage,
            AllCountryFlagImage,
            currencySymbol,
            currencyList,
            countryCurrancyList,
            currentCurrancylist,
            favorites,
            keyboardView,
            resultLabel,lastupdated, dollarText,
            minusFavorite,
            plusFavorite
            ;


bool soundFlag;
bool isFavorite;

#pragma mark -
#pragma mark PickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    
    return [currentCurrancylist count];
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
    
    

    //UIImageView *temp = [[UIImageView alloc] initWithImage:[self.countryFlagImage objectAtIndex:row]];
    UIImageView *temp = [[UIImageView alloc] initWithImage:[[currentCurrancylist objectAtIndex:row] imageFlag]];
    temp.frame = CGRectMake(0,0,58,58);
    
    //setup lable for Currency abbreviation
    UILabel *channelLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, -10, 58, 58)];
   // channelLabel.text = [countryNames objectAtIndex:row];
    channelLabel.text = [[currentCurrancylist objectAtIndex:row] countryABR];
    channelLabel.textAlignment = UITextAlignmentLeft;
    channelLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    channelLabel.backgroundColor = [UIColor clearColor];
    
    //setup label for country name
    UILabel *countryNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 95, 58)];
    //countryNameLabel.text = [DDCurrencyUnitConverter nameOfCurrencyUnit:row];
    countryNameLabel.text = [[currentCurrancylist objectAtIndex:row] countryName];
    
    countryNameLabel.textAlignment = UITextAlignmentLeft;
    countryNameLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:12];
    countryNameLabel.backgroundColor = [UIColor clearColor];
    countryNameLabel.textColor = [UIColor blueColor];
    
    UIView *tmpView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 155, 58)] autorelease];
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
    
     /*
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
    */
    
    [pickerFrom layoutIfNeeded];
    
    //Localize the numbers being displayed
    CalcLocalize *myCalcLocalize = [[CalcLocalize alloc] init];
    resultLabel.text=[myCalcLocalize convertLocalToEngNumbers:(NSString *) resultLabel.text] ;

    
   // DDUnitConverter *converter = [DDUnitConverter currencyUnitConverter];
    DDUnitConverter *converter = [DDUnitConverter currencyUnitConverter];

    NSNumber *inputAmount = [NSNumber numberWithInt:[dollarText.text floatValue]];
    NSNumber *to = nil;

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


-(void) listAllme:(id)sender{
    
    [currentCurrancylist removeAllObjects];
    [minusFavorite setEnabled:NO  ];
    [plusFavorite setEnabled:YES  ];
    
    [currentCurrancylist addObjectsFromArray:countryCurrancyList];
    
    //[pickerFrom layoutIfNeeded];
    
    [pickerFrom reloadAllComponents];
    [pickerFrom selectRow:0 inComponent:0 animated:YES];
    [pickerFrom selectRow:0 inComponent:1 animated:YES];
}


-(void) listFavoriteme:(id) sender{
    component0Position = 0 ;
    component1Position = 0 ;
    [plusFavorite setEnabled:NO  ];
    [minusFavorite setEnabled:YES  ];
    if ([favorites count]  < 1 ) {
        [currentCurrancylist removeAllObjects];
        [pickerFrom reloadAllComponents];
    }
    else {
        [currentCurrancylist removeAllObjects];
        [currentCurrancylist addObjectsFromArray:favorites];
        [pickerFrom reloadAllComponents];
        [pickerFrom selectRow:0 inComponent:0 animated:YES];
        [pickerFrom selectRow:0 inComponent:1 animated:YES];
    }
    
}


-(void) addtoFavorite:(id) sender{
    
    BOOL found=FALSE;
   
    // check to see if the selected item in componnet0 in picker exists in our faviort list 
    for (int i =0; i < self.favorites.count; ++i) {
        if ([[countryCurrancyList objectAtIndex:component0Position] countryABR] == [[favorites objectAtIndex:i] countryABR ]){
            found = TRUE ;
        }
    }
    if (!found){
        [favorites addObject:[countryCurrancyList objectAtIndex:component0Position]];
    }

    // check to see if the selected item in componnet1 in picker exists in our faviort list
    for (int i =0; i < self.favorites.count; ++i) {
        if ([[countryCurrancyList objectAtIndex:component1Position] countryABR] == [[favorites objectAtIndex:i] countryABR ]){
            found = TRUE ;
        }
    }
    if (!found){
        [favorites addObject:[countryCurrancyList objectAtIndex:component1Position]];
    }
}




-(void)removeFromFavorite: (id) sender{
    
    //BOOL found=FALSE;
    if ([favorites count] > 0 ) {
        
        // check to see if the selected item in componnet0 in picker exists in our faviort list
        for (int i =0; i < self.favorites.count; ++i) {
            if ([[currentCurrancylist objectAtIndex:component0Position] countryABR] == [[favorites objectAtIndex:i] countryABR ]){
               // found = TRUE ;
                [favorites removeObjectAtIndex: i];
            }
        }
        
        // check to see if the selected item in componnet1 in picker exists in our faviort list
        for (int i =0; i < self.favorites.count; ++i) {
            if ([[currentCurrancylist objectAtIndex:component1Position] countryABR] == [[favorites objectAtIndex:i] countryABR ]){
                //found = TRUE ;
                [favorites removeObjectAtIndex: i];
            }
        }
    }
    [currentCurrancylist removeAllObjects];
    [currentCurrancylist addObjectsFromArray:favorites];
    [pickerFrom reloadAllComponents];
    [pickerFrom selectRow:0 inComponent:0 animated:YES];
    [pickerFrom selectRow:0 inComponent:1 animated:YES];

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
    else if ([keyletters.titleLabel.text isEqualToString:NSLocalizedString(@"Clear",nil) ] ) {
        
        dollarText.text=@"";
        resultLabel.text=@"";
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
    [dateFormatter setDateFormat:@"EEE,MM-dd-yyyy HH:mm:ss"];
    // Get the date time in NSString
    NSString *dateInStringFormated = [dateFormatter stringFromDate:currentDateTime];
    [lastupdated setText:dateInStringFormated];
    
    DDCurrencyUnitConverter *converter = [DDCurrencyUnitConverter currencyUnitConverter];
    [converter refreshExchangeRates];
    
    //Localize the numbers being displayed
    CalcLocalize *myCalcLocalize = [[CalcLocalize alloc] init];
    lastupdated.text=[myCalcLocalize convertEngToLocalNumbers:(NSString *) lastupdated.text] ;
    [myCalcLocalize release ];
    [dateFormatter release];
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
    UILabel *rateUpdate = [[[UILabel alloc] initWithFrame:CGRectMake(6, 58, 104, 22)] autorelease];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(listAllme:)
     forControlEvents:UIControlEventTouchDown];
    [button setTitle:NSLocalizedString(@"List All",nil) forState:UIControlStateNormal];
     button.frame = CGRectMake(0.0, 5.0, 75.0, 35.0);
    UIImage *buttonImage = [UIImage imageNamed:@"blue_button_gloss.png"];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [self.view addSubview:button];
    //[button release];
    //[buttonImage release];
    
    UIButton *buttonFavorite = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonFavorite addTarget:self
               action:@selector(listFavoriteme:)
     forControlEvents:UIControlEventTouchDown];
    [buttonFavorite setTitle:NSLocalizedString(@"Favorites",nil) forState:UIControlStateNormal];
    buttonFavorite.titleLabel.font = [UIFont systemFontOfSize:14];
    //buttonFavorite.titleLabel.adjustsFontSizeToFitWidth = YES;
    buttonFavorite.frame = CGRectMake(232, 5, 87, 35);
    UIImage *buttonImageFavorite = [UIImage imageNamed:@"blue_button_gloss.png"];
    [buttonFavorite setBackgroundImage:buttonImageFavorite forState:UIControlStateNormal];
    [self.view addSubview:buttonFavorite];
   // [buttonFavorite release];
   //[buttonImageFavorite release];
    
    
    plusFavorite = [UIButton buttonWithType:UIButtonTypeCustom];
    [plusFavorite addTarget:self
                            action:@selector(addtoFavorite:)
                  forControlEvents:UIControlEventTouchDown];
    [plusFavorite setTitle:NSLocalizedString(@"+Favorit",nil) forState:UIControlStateNormal];
    plusFavorite.frame = CGRectMake(75, 5, 87, 35);
    UIImage *buttonImageFavoritePlus = [UIImage imageNamed:@"green_button_gloss.png"];
    [plusFavorite setBackgroundImage:buttonImageFavoritePlus forState:UIControlStateNormal];
    [self.view addSubview:plusFavorite];
    [plusFavorite release];
    //[buttonImageFavoritePlus release];
    
    
    
    minusFavorite = [UIButton buttonWithType:UIButtonTypeCustom];
    [minusFavorite addTarget:self
               action:@selector(removeFromFavorite:)
     forControlEvents:UIControlEventTouchDown];
    [minusFavorite setTitle:NSLocalizedString(@"-Favorit",nil) forState:UIControlStateNormal];
    minusFavorite.frame = CGRectMake(153, 5, 87, 35);
    UIImage *buttonImageFavoriteMinus = [UIImage imageNamed:@"green_button_gloss.png"];
    [minusFavorite setBackgroundImage:buttonImageFavoriteMinus forState:UIControlStateNormal];
    [self.view addSubview:minusFavorite];
    //[minusFavorite release];
   // [buttonImageFavoriteMinus release];
    
    
    
    
    

	rateUpdate.text = NSLocalizedString(@"Rates Updated:",nil);
    rateUpdate.backgroundColor = [UIColor clearColor];
    rateUpdate.textColor = [UIColor blackColor];
    rateUpdate.font = [UIFont fontWithName:@"Helvetica" size: 14.0];
    [self.view addSubview:rateUpdate];
    
    //setup initial exchange rate 
    //currencyFromRate = 1.0 ;
    //currencyToRate = 1;
    
    //init dialer positions
    component0Position = 0 ;
    component1Position = 0 ;
    
    // set initial display to ALL_CURRENTY_LIST
    isFavorite = FALSE ;
    
    dollarText.text = NSLocalizedString(dollarText.text, nil);
    dollarText.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"middleRowSelected.png"]];
    resultLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"middleRowSelected.png"]];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.favorites = [[[NSMutableArray alloc] initWithCapacity:100]autorelease];
    
     
    // setup dictionary  for countries currency index
    self.currencyList = [[[NSMutableDictionary alloc] initWithCapacity:100]autorelease];
    
    
    // First crate objects for each country  Needs to be implemented bellow Tom
    countryCurrancyList = [[NSMutableArray alloc] initWithCapacity:55] ;
    currentCurrancylist = [[NSMutableArray alloc] initWithCapacity:55] ;
    
    //setup each countries Object
    Currency *EUR = [[[Currency alloc] init] autorelease];
    EUR.positionRelatedToTheClass = DDCurrencyUnitEuro;
    EUR.countryName =  NSLocalizedString(@"Euro",nil);
    EUR.countryABR = @"EUR";
    EUR.imageFlag = [UIImage imageNamed:@"Euro-Flag-64.png"];
    [countryCurrancyList addObject:EUR];
    
    Currency *JPY = [[[Currency alloc] init] autorelease];
    JPY.positionRelatedToTheClass = DDCurrencyUnitJapaneseYen;
    JPY.countryName = NSLocalizedString(@"Japan",nil);
    JPY.countryABR = @"JPY";
    JPY.imageFlag= [UIImage imageNamed:@"Japan-Flag-64.png"];
    [countryCurrancyList addObject:JPY];
    
    Currency *GBP = [[[Currency alloc] init] autorelease];
    GBP.positionRelatedToTheClass = DDCurrencyUnitUKPoundSterling;
    GBP.countryName = NSLocalizedString(@"England",nil);
    GBP.countryABR = @"GBP";
    GBP.imageFlag = [UIImage imageNamed:@"England-Flag-64.png"] ;
    [countryCurrancyList addObject:GBP];
    
    Currency *USD = [[[Currency alloc] init] autorelease];
    USD.positionRelatedToTheClass = DDCurrencyUnitUSDollar;
    USD.countryName = NSLocalizedString(@"USA",nil);
    USD.countryABR = @"USD";
    USD.imageFlag = [UIImage imageNamed:@"United-States-Flag-64.png"] ;
    [countryCurrancyList addObject:USD];
    
    Currency *DZD = [[[Currency alloc] init] autorelease ];
    DZD.positionRelatedToTheClass = DDCurrencyUnitAlgerianDinar;
    DZD.countryName = NSLocalizedString(@"Algeria",nil);
    DZD.countryABR = @"DZD";
    DZD.imageFlag = [UIImage imageNamed:@"Algeria-Flag-64.png"] ;
    [countryCurrancyList addObject:DZD];
    
    Currency *ARS = [[[Currency alloc] init] autorelease ];
    ARS.positionRelatedToTheClass = DDCurrencyUnitArgentinePeso;
    ARS.countryName = NSLocalizedString(@"Argantina",nil);
    ARS.countryABR = @"ARS";
    ARS.imageFlag = [UIImage imageNamed:@"Argentina-Flag-64.png"] ;
    [countryCurrancyList addObject:ARS];
    
    Currency *AUD = [[[Currency alloc] init] autorelease];
    AUD.positionRelatedToTheClass = DDCurrencyUnitAustralianDollar;
    AUD.countryName = NSLocalizedString(@"Australia",nil);
    AUD.countryABR = @"AUD";
    AUD.imageFlag = [UIImage imageNamed:@"Australia-Flag-64.png"];
    [countryCurrancyList addObject:AUD];
    
    Currency *BHD = [[[Currency alloc] init] autorelease];
    BHD.positionRelatedToTheClass = DDCurrencyUnitBahrainDinar;
    BHD.countryName = NSLocalizedString(@"Bahrain",nil);
    BHD.countryABR = @"BHD";
    BHD.imageFlag = [UIImage imageNamed:@"Bahrain-Flag-64.png"];
    [countryCurrancyList addObject:BHD];
    
    Currency *BWP = [[[Currency alloc] init] autorelease];
    BWP.positionRelatedToTheClass = DDCurrencyUnitBotswanaPula;
    BWP.countryName = NSLocalizedString(@"Botswana",nil);
    BWP.countryABR = @"BWP";
    BWP.imageFlag = [UIImage imageNamed:@"Botswana-Flag-64.png"];
    [countryCurrancyList addObject:BWP];
   
    Currency *BRL = [[[Currency alloc] init]autorelease];
    BRL.positionRelatedToTheClass = DDCurrencyUnitBrazilianReal;
    BRL.countryName = NSLocalizedString(@"Brazil",nil);
    BRL.countryABR = @"BRL";
    BRL.imageFlag = [UIImage imageNamed:@"Brazil-Flag-64.png"];
    [countryCurrancyList addObject:BRL];

    Currency *BND = [[[Currency alloc] init] autorelease];
    BND.positionRelatedToTheClass = DDCurrencyUnitBruneiDollar;
    BND.countryName = NSLocalizedString(@"Brunei",nil);
    BND.countryABR = @"BND";
    BND.imageFlag = [UIImage imageNamed:@"Brunei-Flag-64.png"];
    [countryCurrancyList addObject:BND];
    
    Currency *CAD = [[[Currency alloc] init] autorelease];
    CAD.positionRelatedToTheClass = DDCurrencyUnitCanadianDollar;
    CAD.countryName = NSLocalizedString(@"Canada",nil);
    CAD.countryABR = @"CAD";
    CAD.imageFlag = [UIImage imageNamed:@"Canada-Flag-64.png"];
    [countryCurrancyList addObject:CAD];
   
    Currency *CLP = [[[Currency alloc] init] autorelease];
    CLP.positionRelatedToTheClass = DDCurrencyUnitChileanPeso;
    CLP.countryName = NSLocalizedString(@"Chile",nil);
    CLP.countryABR = @"CLP";
    CLP.imageFlag = [UIImage imageNamed:@"Chile-Flag-64.png"];
    [countryCurrancyList addObject:CLP];
    
    
    Currency *CNY = [[[Currency alloc] init] autorelease];
    CNY.positionRelatedToTheClass = DDCurrencyUnitChineseYuan;
    CNY.countryName = NSLocalizedString(@"China",nil);
    CNY.countryABR = @"CNY";
    CNY.imageFlag = [UIImage imageNamed:@"China-Flag-64.png"];
    [countryCurrancyList addObject:CNY];
    
    Currency *COP = [[[Currency alloc] init] autorelease];
    COP.positionRelatedToTheClass = DDCurrencyUnitColombianPeso;
    COP.countryName = NSLocalizedString(@"Colombia",nil);
    COP.countryABR = @"COP";
    COP.imageFlag = [UIImage imageNamed:@"Colombia-Flag-64.png"];
    [countryCurrancyList addObject:COP];
    
    Currency *CZK = [[[Currency alloc] init] autorelease];
    CZK.positionRelatedToTheClass = DDCurrencyUnitCzechKoruna;
    CZK.countryName = NSLocalizedString(@"Check republic",nil);
    CZK.countryABR = @"CZK";
    CZK.imageFlag = [UIImage imageNamed:@"Czech-Republic-Flag-64.png"];
    [countryCurrancyList addObject:CZK];
    
    Currency *DKK = [[[Currency alloc] init] autorelease];
    DKK.positionRelatedToTheClass = DDCurrencyUnitDanishKrone;
    DKK.countryName = NSLocalizedString(@"Denmark",nil);
    DKK.countryABR = @"DKK";
    DKK.imageFlag = [UIImage imageNamed:@"Denmark-Flag-64.png"];
    [countryCurrancyList addObject:DKK];
    
    Currency *HUF = [[[Currency alloc] init] autorelease];
    HUF.positionRelatedToTheClass = DDCurrencyUnitHungarianForint;
    HUF.countryName = NSLocalizedString(@"Hungary",nil);
    HUF.countryABR = @"HUF";
    HUF.imageFlag = [UIImage imageNamed:@"Hungary-Flag-64.png"];
    [countryCurrancyList addObject:HUF];
    
    Currency *ISK = [[[Currency alloc] init] autorelease];
    ISK.positionRelatedToTheClass = DDCurrencyUnitIcelandicKrona;
    ISK.countryName = NSLocalizedString(@"Iceland",nil);
    ISK.countryABR = @"ISK";
    ISK.imageFlag = [UIImage imageNamed:@"Iceland-Flag-64.png"];
    [countryCurrancyList addObject:ISK];
    
    Currency *INR = [[[Currency alloc] init] autorelease];
    INR.positionRelatedToTheClass = DDCurrencyUnitIndianRupee;
    INR.countryName = NSLocalizedString(@"India",nil);
    INR.countryABR = @"INR";
    INR.imageFlag = [UIImage imageNamed:@"India-Flag-64.png"];
    [countryCurrancyList addObject:INR];
    
    Currency *IDR = [[[Currency alloc] init] autorelease];
    IDR.positionRelatedToTheClass = DDCurrencyUnitIndonesianRupiah;
    IDR.countryName = NSLocalizedString(@"Indonesia",nil);
    IDR.countryABR = @"IDR";
    IDR.imageFlag = [UIImage imageNamed:@"Indonesia-Flag-64.png"];
    [countryCurrancyList addObject:IDR];
    
    Currency *IRR = [[[Currency alloc] init] autorelease];
    IRR.positionRelatedToTheClass = DDCurrencyUnitIranianRial;
    IRR.countryName = NSLocalizedString(@"Iran",nil);
    IRR.countryABR = @"IRR";
    IRR.imageFlag = [UIImage imageNamed:@"Iran-Flag-64.png"]; 
    [countryCurrancyList addObject:IRR];
    
    Currency *ISL = [[[Currency alloc] init] autorelease];
    ISL.positionRelatedToTheClass = DDCurrencyUnitIsraeliNewSheqel;
    ISL.countryName = NSLocalizedString(@"Israel",nil);
    ISL.countryABR = @"ISL";
    ISL.imageFlag = [UIImage imageNamed:@"Israel-Flag-64.png"];
    [countryCurrancyList addObject:ISL];
    
    Currency *KGS = [[[Currency alloc] init] autorelease];
    KGS.positionRelatedToTheClass = DDCurrencyUnitKazakhstaniTenge;
    KGS.countryName = NSLocalizedString(@"Kazakhstan",nil);
    KGS.countryABR = @"KGS";
    KGS.imageFlag =[UIImage imageNamed:@"Kazakhstan-Flag-64.png"];
    [countryCurrancyList addObject:KGS];
    
    Currency *KRW = [[[Currency alloc] init] autorelease];
    KRW.positionRelatedToTheClass = DDCurrencyUnitKoreanWon;
    KRW.countryName = NSLocalizedString(@"Korea",nil);
    KRW.countryABR = @"KRW";
    KRW.imageFlag = [UIImage imageNamed:@"Korea-Flag-64.png"];
    [countryCurrancyList addObject:KRW];
    
    Currency *KWD = [[[Currency alloc] init] autorelease];
    KWD.positionRelatedToTheClass = DDCurrencyUnitKuwaitiDinar;
    KWD.countryName = NSLocalizedString(@"Kuwait",nil);
    KWD.countryABR = @"KWD";
    KWD.imageFlag = [UIImage imageNamed:@"Kuwait-Flag-64.png"];
    [countryCurrancyList addObject:KWD];
    
    
    Currency *LYD = [[[Currency alloc] init] autorelease];
    LYD.positionRelatedToTheClass = DDCurrencyUnitLibyanDinar;
    LYD.countryName = NSLocalizedString(@"Libya",nil);
    LYD.countryABR = @"LYD";
    LYD.imageFlag =[UIImage imageNamed:@"Libya-Flag-64.png"];
    [countryCurrancyList addObject:LYD];
    
    Currency *MYR = [[[Currency alloc] init] autorelease];
    MYR.positionRelatedToTheClass = DDCurrencyUnitMalaysianRinggit;
    MYR.countryName = NSLocalizedString(@"Malaysia",nil);
    MYR.countryABR = @"MYR";
    MYR.imageFlag = [UIImage imageNamed:@"Malaysia-Flag-64.png"];
    [countryCurrancyList addObject:MYR];
    
    Currency *MUR = [[[Currency alloc] init] autorelease];
    MUR.positionRelatedToTheClass = DDCurrencyUnitMauritianRupee;
    MUR.countryName = NSLocalizedString(@"Mauritania",nil);
    MUR.countryABR = @"MUR";
    MUR.imageFlag =[UIImage imageNamed:@"Mauritania-Flag-64.png"];
    [countryCurrancyList addObject:MUR];
    
    Currency *MXN = [[[Currency alloc] init] autorelease];
    MXN.positionRelatedToTheClass = DDCurrencyUnitMexicanPeso;
    MXN.countryName = NSLocalizedString(@"Mexico",nil);
    MXN.countryABR = @"MXN";
    MXN.imageFlag =[UIImage imageNamed:@"Mexico-Flag-64.png"];
    [countryCurrancyList addObject:MXN];
    
    Currency *NPR = [[[Currency alloc] init] autorelease];
    NPR.positionRelatedToTheClass = DDCurrencyUnitNepaleseRupee;
    NPR.countryName = NSLocalizedString(@"Nepal",nil);
    NPR.countryABR = @"NPR";
    NPR.imageFlag =[UIImage imageNamed:@"Nepal-Flag-64.png"];
    [countryCurrancyList addObject:NPR];
    
    Currency *NZD = [[[Currency alloc] init] autorelease];
    NZD.positionRelatedToTheClass = DDCurrencyUnitNewZealandDollar;
    NZD.countryName = NSLocalizedString(@"New Zeland",nil);
    NZD.countryABR = @"NZD";
    NZD.imageFlag = [UIImage imageNamed:@"New-Zealand-Flag-64.png"];
    [countryCurrancyList addObject:NZD];
    
    Currency *NOK = [[[Currency alloc] init] autorelease];
    NOK.positionRelatedToTheClass = DDCurrencyUnitNorwegianKrone;
    NOK.countryName = NSLocalizedString(@"Norway",nil);
    NOK.countryABR = @"NOK";
    NOK.imageFlag = [UIImage imageNamed:@"Norway-Flag-64.png"];
    [countryCurrancyList addObject:NOK];
    
    Currency *OMR = [[[Currency alloc] init] autorelease];
    OMR.positionRelatedToTheClass = DDCurrencyUnitRialOmani;
    OMR.countryName = NSLocalizedString(@"Oman",nil);
    OMR.countryABR = @"OMR";
    OMR.imageFlag = [UIImage imageNamed:@"Oman-Flag-64.png"];
    [countryCurrancyList addObject:OMR];
    
    Currency *PKR = [[[Currency alloc] init] autorelease];
    PKR.positionRelatedToTheClass = DDCurrencyUnitPakistaniRupee;
    PKR.countryName = NSLocalizedString(@"Pakistan",nil);
    PKR.countryABR = @"PKR";
    PKR.imageFlag = [UIImage imageNamed:@"Pakistan-Flag-64.png"];
    [countryCurrancyList addObject:PKR];
    
    Currency *PEN = [[[Currency alloc] init] autorelease];
    PEN.positionRelatedToTheClass = DDCurrencyUnitNuevoSol;
    PEN.countryName = NSLocalizedString(@"Peru",nil);
    PEN.countryABR = @"PEN";
    PEN.imageFlag =[UIImage imageNamed:@"Peru-Flag-64.png"];
    [countryCurrancyList addObject:PEN];
    
    Currency *PHP = [[[Currency alloc] init] autorelease];
    PHP.positionRelatedToTheClass = DDCurrencyUnitPhilippinePeso;
    PHP.countryName = NSLocalizedString(@"Philippine",nil);
    PHP.countryABR = @"PHP";
    PHP.imageFlag =[UIImage imageNamed:@"Philippines-Flag-64.png"];
    [countryCurrancyList addObject:PHP];
    
    Currency *PLN = [[[Currency alloc] init] autorelease];
    PLN.positionRelatedToTheClass = DDCurrencyUnitPolishZloty;
    PLN.countryName = NSLocalizedString(@"Poland",nil);
    PLN.countryABR = @"PLN";
    PLN.imageFlag = [UIImage imageNamed:@"Poland-Flag-64.png"];
    [countryCurrancyList addObject:PLN];
    
    Currency *QAR = [[[Currency alloc] init] autorelease];
    QAR.positionRelatedToTheClass = DDCurrencyUnitQatarRiyal;
    QAR.countryName = NSLocalizedString(@"Qatar",nil);
    QAR.countryABR = @"QAR";
    QAR.imageFlag =  [UIImage imageNamed:@"Qatar-Flag-64.png"];
    [countryCurrancyList addObject:QAR];
    
    Currency *RUB = [[[Currency alloc] init] autorelease];
    RUB.positionRelatedToTheClass = DDCurrencyUnitRussianRuble;
    RUB.countryName = NSLocalizedString(@"Russia",nil);
    RUB.countryABR = @"RUB";
    RUB.imageFlag =  [UIImage imageNamed:@"Russia-Flag-64.png"];
    [countryCurrancyList addObject:RUB];
    
    Currency *SAR = [[[Currency alloc] init] autorelease];
    SAR.positionRelatedToTheClass = DDCurrencyUnitSaudiArabianRiyal;
    SAR.countryName = NSLocalizedString(@"Saudi Arabia",nil);
    SAR.countryABR = @"SAR";
    SAR.imageFlag =  [UIImage imageNamed:@"Saudi-Arabia-Flag-64.png"];
    [countryCurrancyList addObject:SAR];
    
    Currency *SGD = [[[Currency alloc] init] autorelease];
    SGD.positionRelatedToTheClass = DDCurrencyUnitSingaporeDollar;
    SGD.countryName = NSLocalizedString(@"Singapore",nil);
    SGD.countryABR = @"SGD";
    SGD.imageFlag = [UIImage imageNamed:@"Singapore-Flag-64.png"];
    [countryCurrancyList addObject:SGD];
    
    Currency *ZAR = [[[Currency alloc] init] autorelease];
    ZAR.positionRelatedToTheClass = DDCurrencyUnitSouthAfricanRand;
    ZAR.countryName = NSLocalizedString(@"South Africa",nil);
    ZAR.countryABR = @"ZAR";
    ZAR.imageFlag =[UIImage imageNamed:@"South-Africa-Flag-64.png"];
    [countryCurrancyList addObject:ZAR];
    
    Currency *LKR = [[[Currency alloc] init]autorelease];
    LKR.positionRelatedToTheClass = DDCurrencyUnitSriLankaRupee;
    LKR.countryName = NSLocalizedString(@"Sri lanka",nil);
    LKR.countryABR = @"LKR";
    LKR.imageFlag =[UIImage imageNamed:@"Sri-Lanka-Flag-64.png"];
    [countryCurrancyList addObject:LKR];
    
    Currency *SEK = [[[Currency alloc] init] autorelease];
    SEK.positionRelatedToTheClass = DDCurrencyUnitSwedishKrona;
    SEK.countryName = NSLocalizedString(@"Sweden",nil);
    SEK.countryABR = @"SEK";
    SEK.imageFlag = [UIImage imageNamed:@"Sweden-Flag-64.png"];
    [countryCurrancyList addObject:SEK];
    
    Currency *CHF = [[[Currency alloc] init] autorelease];
    CHF.positionRelatedToTheClass = DDCurrencyUnitSwissFranc;
    CHF.countryName = NSLocalizedString(@"Swiss",nil);
    CHF.countryABR = @"CHF";
    CHF.imageFlag = [UIImage imageNamed:@"Swiss-Flag-64.png"];
    [countryCurrancyList addObject:CHF];
    
    Currency *THB = [[[Currency alloc] init] autorelease];
    THB.positionRelatedToTheClass = DDCurrencyUnitThaiBaht;
    THB.countryName = NSLocalizedString(@"Thailand",nil);
    THB.countryABR = @"THB";
    THB.imageFlag = [UIImage imageNamed:@"Thailand-Flag-64.png"];
    [countryCurrancyList addObject:THB];
    
    Currency *TTD = [[[Currency alloc] init] autorelease];
    TTD.positionRelatedToTheClass = DDCurrencyUnitTrinidadAndTobagoDollar;
    TTD.countryName = NSLocalizedString(@"Trinidad",nil);
    TTD.countryABR = @"TTD";
    TTD.imageFlag = [UIImage imageNamed:@"Trinidad-Flag-64.png"];
    [countryCurrancyList addObject:TTD];
    
    Currency *TND = [[[Currency alloc] init] autorelease];
    TND.positionRelatedToTheClass = DDCurrencyUnitTunisianDinar;
    TND.countryName = NSLocalizedString(@"Tunisia",nil);
    TND.countryABR = @"TND";
    TND.imageFlag =  [UIImage imageNamed:@"Tunisia-Flag-64.png"];
    [countryCurrancyList addObject:TND];
    
    Currency *AED = [[[Currency alloc] init] autorelease];
    AED.positionRelatedToTheClass = DDCurrencyUnitUAEDirham;
    AED.countryName = NSLocalizedString(@"United Arab Emirates",nil);
    AED.countryABR = @"AED";
    AED.imageFlag = [UIImage imageNamed:@"UAE-Flag-64.png"];
    [countryCurrancyList addObject:AED];
    
    
    Currency *UYU = [[[Currency alloc] init] autorelease];
    UYU.positionRelatedToTheClass = DDCurrencyUnitPesoUruguayo;
    UYU.countryName = NSLocalizedString(@"Uruguay",nil);
    UYU.countryABR = @"UYU";
    UYU.imageFlag = [UIImage imageNamed:@"Uruguay-Flag-64.png"];
    [countryCurrancyList addObject:UYU];
    
    Currency *BOB = [[[Currency alloc] init] autorelease];
    BOB.positionRelatedToTheClass = DDCurrencyUnitBolivarFuerte;
    BOB.countryName = NSLocalizedString(@"Bolivia",nil);
    BOB.countryABR = @"BOB";
    BOB.imageFlag = [UIImage imageNamed:@"Bolivia-Flag-64.png"];
    [countryCurrancyList addObject:BOB];
    
    Currency *SDR = [[[Currency alloc] init] autorelease];
    SDR.positionRelatedToTheClass = DDCurrencyUnitSDR;
    SDR.countryName = NSLocalizedString(@"Spain",nil);
    SDR.countryABR = @"SDR";
    SDR.imageFlag =[UIImage imageNamed:@"Spain-Flag-64.png"];
    [countryCurrancyList addObject:SDR];

    
    [currentCurrancylist addObjectsFromArray:countryCurrancyList];
    
   /* 
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
    */

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
    
    [pickerFrom selectRow:component0Position inComponent:0 animated:NO];
    [pickerFrom selectRow:component1Position inComponent:1 animated:NO];

    //setup custom keyboard
    self.keyboardView = [[[CustomKeyboard alloc] initWithFrame:CGRectMake(0, 440, 320, 140)]autorelease];
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

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    //NSLog(@"What is the orientation: %i", toInterfaceOrientation);
    if ( (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) ||(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) )
    {
        
        PersianCalculatorLandscape *myOwnController = [[[[PersianCalculatorLandscape alloc] init]  initWithNibName:@"PersianCalculatorLandscape" bundle:nil whichTab:2]autorelease];
        NSMutableArray* newArray = [NSMutableArray arrayWithArray:self.tabBarController.viewControllers];
        [newArray replaceObjectAtIndex:2 withObject:myOwnController];
        [self.tabBarController setViewControllers:newArray animated:YES];
    }
    else
    {
        //[self.navigationController setNavigationBarHidden:FALSE animated:FALSE];
        //[self.navigationController popToRootViewControllerAnimated:NO];
    }
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    //CGRect previousRect = self.view.frame;
    UIInterfaceOrientation toOrientation = self.interfaceOrientation;
    
    if ( self.tabBarController.view.subviews.count >= 2 )
    {
        
        UIView *tabBar = [self.tabBarController.view.subviews objectAtIndex:1];
        
        if(toOrientation == UIInterfaceOrientationLandscapeLeft || toOrientation == UIInterfaceOrientationLandscapeRight) {
            //transView.frame = CGRectMake(0, 0, 480, 320 );
            tabBar.hidden = TRUE;
        }
        else
        {
            tabBar.hidden = FALSE;
        }
    }
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
    [AllCountryFlagImage release];
    [currencyList release];
    [currentCurrancylist release];
    [favorites release];
    [keyboardView release];
    [super dealloc];
    
}


@end
