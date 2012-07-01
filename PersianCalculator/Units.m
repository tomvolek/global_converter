//
//  Units.m
//  PersianCalculatorPro
//
//  Created by volek on 11/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Units.h"

@implementation Units

@synthesize unitConverter,
            fromUnit,
            toUnit,
            unitDataArray,
            fromTextView,
            toTextView,
            fromTextFeild,
            keyboardView;

bool soundFlag;


-(void) keyPressed: (id)sender{	
    UIButton  *keyletters = (UIButton*)sender ;
    
    
    if ([keyletters.titleLabel.text isEqualToString:@"="] ) {
        if ([fromTextView.text length] < 1) {
            // Do nothing, user has pressed without any numbers
        }
        else {
                //Call the function to calculate Unit conversion 
                fromTextView.selectedRange = NSMakeRange(fromTextView.text.length - 1, 0);
            }
        } 
    else if ([keyletters.titleLabel.text isEqualToString:@"C"] ) {
        
        fromTextView.text=@"";
        toTextView.text=@"";
    }
    else if ([keyletters.titleLabel.text isEqualToString:@"v"] ) {
        
        [self keyboardHide];
    }
        //implement character rubout 
    else if ([keyletters.titleLabel.text isEqualToString:@"xx"] ) {
        if (fromTextView.text.length < 1) { }
        else {
            NSRange selectedRange = fromTextView.selectedRange;
            
            if ( selectedRange.location > 0 ) {
                NSString *tempString = [fromTextView.text substringFromIndex:selectedRange.location];
                fromTextView.text = [fromTextView.text substringToIndex:selectedRange.location -1];
                fromTextView.text = [fromTextView.text stringByAppendingString:tempString];
            }
        }
    }
    else {
        //All other characters just add them to the string 
        fromTextView.text = [fromTextView.text  stringByAppendingString:NSLocalizedString(keyletters.titleLabel.text, nil)];
    }
} //keyPressed




// Method to define the numberOfComponent in a picker view.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

// Method to define the numberOfRows in a component using the array.
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent :(NSInteger)component 
{ 
    if (component==0)
    {
        //return [unitCategory count];
        return [unitDataArray count];
    }
    else if (component==1)
    {
        return[fromUnit count];
    }
    else return[toUnit count];
}


// Method to show the title of row for a component.
/*- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    switch (component) 
    {
        case 0:
            return [unitCategory objectAtIndex:row];
            break;
        case 1:
            return [fromUnit objectAtIndex:row];
            break;
        case 2: 
            return [toUnit objectAtIndex:row];
            break;
    }
    return nil;
}
*/

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *retval = (id)view;
    if (!retval) {
        retval= [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)] autorelease];
    }

    retval.font = [UIFont systemFontOfSize:15];
    retval.textAlignment = UITextAlignmentCenter;
    retval.backgroundColor = [UIColor clearColor];
    retval.textColor = [UIColor blueColor];

   // retval.backgroundColor= [UIColor groupTableViewBackgroundColor ];
    
   // [UIColor colorWithRed:E5 green:E5F0 blue:0.0 alpha:1.0];
    //[UIColor colorWithRed: 231/255 green: 0/255 blue: 141/255 alpha:1.0];
    

    switch (component) 
    {
        case 0:
           // retval.text =  [unitCategory objectAtIndex:row];
           retval.text =  [[unitDataArray objectAtIndex:row] objectAtIndex:0];
            
            break;
        case 1:
            retval.text = [fromUnit objectAtIndex:row];
            break;
        case 2: 
            retval.text = [toUnit objectAtIndex:row];
            break;
    }
    //Localize any strings on the views
    [LocalizationHelper localizeView:self.view];

    return retval;
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
    
    if (component == 0 ) {
        component0Position = row;
        int i =0; //start on second position. first position is the names on component one
        [fromUnit removeAllObjects]; // clean componenet 1 (fromUnit) and 2 (toUnit)
        [toUnit removeAllObjects];
        for (NSString *item in [unitDataArray objectAtIndex:row]){
            if (i > 0 ) {
                [fromUnit insertObject:item atIndex:i-1];
                [toUnit insertObject:item atIndex:i-1];
            }
            i++;
        }
        component1Position = 0 ; 
        component2Position = 0 ;
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView selectRow:0 inComponent:2 animated:YES];
                
    }
    else if (component == 1){
        component1Position = row;
        
        NSString *component0Name = [[unitDataArray objectAtIndex:component0Position]  objectAtIndex:0 ];
      
        NSString *UnitConverterMethodName ;
        UnitConverterMethodName =  [NSString stringWithFormat:@"%@UnitConverter",component0Name] ;
        UnitConverterMethodName = [UnitConverterMethodName stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[UnitConverterMethodName substringToIndex:1] lowercaseString]];
        
        //construct the second dialer string to be passed into calcualtion method
        NSMutableString *component1Name  = [[NSMutableString alloc]  init] ;
        [component1Name appendString:@"DD"];
        [component1Name appendString: [[unitDataArray objectAtIndex:component0Position]  objectAtIndex:0 ]  ];
        [component1Name appendString:@"Unit"];
        [component1Name appendString:[ fromUnit objectAtIndex:row]];
        
        NSLog(@"component1Name = %@",[component1Name stringByTrimmingCharactersInSet:
                                 [NSCharacterSet whitespaceCharacterSet]]);
                
        CalcLocalize *myCalcLocalize = [[CalcLocalize alloc] init];
        fromTextView.text=[myCalcLocalize convertLocalToEngNumbers:(NSString *) fromTextView.text] ;

        DDUnitConverter *myconverter =  [DDUnitConverter performSelector:NSSelectorFromString(UnitConverterMethodName)] ; 
        NSLog(@"UnitConverterMethodName=%@",UnitConverterMethodName);
        
    
        NSNumber * value =  [myconverter  
                            convertNumber:[NSNumber numberWithInt:[fromTextView.text integerValue]]
                             fromUnit:component1Position
                             toUnit:component2Position];
        
        
        NSLog(@"value from DDUnit=%@",value);
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
        [formatter setMaximumFractionDigits:2]; //round to 2 decimal
        
        toTextView.text =  [formatter  stringFromNumber:value];       
        toTextView.text=[myCalcLocalize convertEngToLocalNumbers:(NSString *) toTextView.text] ;
        [formatter release];

        [myCalcLocalize release ];
    }
    else if (component == 2){
        component2Position = row;
        NSString *component0Name = [[unitDataArray objectAtIndex:component0Position]  objectAtIndex:0 ];
        
        NSString *UnitConverterMethodName ;
        UnitConverterMethodName =  [NSString stringWithFormat:@"%@UnitConverter",component0Name] ;
        UnitConverterMethodName = [UnitConverterMethodName stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[UnitConverterMethodName substringToIndex:1] lowercaseString]];
        
        //construct the third dialer string to be passed into calcualtion method
        NSMutableString *component2Name  = [[NSMutableString alloc]  init] ;
        [component2Name appendString:@"DD"];
        [component2Name appendString: [[unitDataArray objectAtIndex:component0Position]  objectAtIndex:0 ]  ];
        [component2Name appendString:@"Unit"];
        [component2Name appendString:[ toUnit objectAtIndex:row]];
        
        NSLog(@"component2Name = %@",[component2Name stringByTrimmingCharactersInSet:
                                      [NSCharacterSet whitespaceCharacterSet]]);
        
        CalcLocalize *myCalcLocalize = [[CalcLocalize alloc] init];
        toTextView.text=[myCalcLocalize convertLocalToEngNumbers:(NSString *) toTextView.text] ;
        
        DDUnitConverter *myconverter =  [DDUnitConverter performSelector:NSSelectorFromString(UnitConverterMethodName)] ; 
        NSLog(@"UnitConverterMethodName=%@",UnitConverterMethodName);
        
        
        NSNumber * value =  [myconverter  
                             convertNumber:[NSNumber numberWithInt:[fromTextView.text integerValue]]
                             fromUnit:component1Position
                             toUnit:component2Position];
        
        
        NSLog(@"value from DDUnit=%@",value);
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
        [formatter setMaximumFractionDigits:2]; //round to 2 decimal
        
        toTextView.text =  [formatter  stringFromNumber:value];       
        toTextView.text=[myCalcLocalize convertEngToLocalNumbers:(NSString *) toTextView.text] ;
        [formatter release];
        [myCalcLocalize release ];
    }
}


- (CGFloat)pickerView:(UIPickerView *)pickerView
rowHeightForComponent:(NSInteger)component {
    return 45.0;
}



- (CGFloat)pickerView:(UIPickerView *)pickerView
    widthForComponent:(NSInteger)component {
    switch(component) {
            case 0: return 110;
            case 1: return 110;
            case 2: return 110;
        default: return 22;
    }

    return 110.0;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


//implement the delete button on dislay text area
-(IBAction) eraseCharacter{
    if (soundFlag) {
        [theAudio play];
    }
    if (fromTextView.text.length < 1) { }
    else {
        NSRange selectedRange = fromTextView.selectedRange;
        
        if ( selectedRange.location > 0 ) {
            NSString *tempString = [fromTextView.text substringFromIndex:selectedRange.location];
            fromTextView.text = [fromTextView.text substringToIndex:selectedRange.location -1];
            fromTextView.text = [fromTextView.text stringByAppendingString:tempString];
        }
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //  [projectNavigationController viewWillAppear:animated];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    soundFlag= [userDefaults boolForKey:@"audioSwitch"];
    
    NSArray* languages = [userDefaults objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    NSLog(@"preferredLang Unit=%@",preferredLang);
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:preferredLang, nil] forKey:@"AppleLanguages"];
    
    //Localize any strings on the views
    [LocalizationHelper localizeView:self.view];
    [unitConverter reloadComponent:0];
    [unitConverter reloadComponent:1];

    
    
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"worldMapBackgroud.png"]];
    

    self.navigationController.navigationBarHidden = NO;
    //[[fromTextView layer] setCornerRadius:5];    
    //[fromTextView setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:22]];
    fromTextView.text = NSLocalizedString(@"1", nil);
    component1Position = 0;   //init dialer 2 position
    component2Position = 0;   //init dialer 3 position
    //add Image to both formula and history UITextView
    fromTextView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"middleRowSelected.png"]];
    toTextView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"middleRowSelected.png"]];
    
    // SetUp sound 
    NSString *path = [[NSBundle mainBundle] pathForResource:@"button5" ofType:@"wav"];
    theAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    // now initialize the player 
    theAudio.delegate=self;
    [theAudio prepareToPlay];

    //code to create a customized selector for picker
  /*  UIImage *selectorImage = [UIImage imageNamed:@"selectorImage.png"]; // You have to make it strechable, probably
    UIView *customSelector = [[UIImageView alloc] initWithImage:selectorImage];
    customSelector.frame = CGRectZero; // Whatever rect to match the UIImagePicker
    [self.view addSubview:customSelector];
    [customSelector release];

    */
   
   unitConverter.backgroundColor = [UIColor blueColor];
   
    
    // two dimentional array for Init names and coresponding enum values
    //to call DDUnitConverter
    
    unitDataArray = [[NSMutableArray alloc] initWithCapacity: 20];
    
    [unitDataArray insertObject:[NSMutableArray arrayWithObjects:@"Acceleration",@"Feet",@"Galileos",@"GForce",@"Kilometers",@"Meters",@"Miles",nil] atIndex:0];
    
    [unitDataArray insertObject:[NSMutableArray arrayWithObjects:@"Angle",@"Circles",@"Degrees",@"Gons",@"Grades",@"Minutes",@"Mils",@"NauticalRhumbs",@"Quadrants",@"Radians",@"Revolutions",@"Seconds",@"Turns",nil] atIndex:1];
    
    [unitDataArray insertObject:[NSMutableArray arrayWithObjects:@"Area",@"Acres",@"Barns",@"Hectares",@"Roods",@"Centimeters",@"Decimeters",@"Feet",@"Inches",@"Kilometers",@"Meters",@"Miles",@"Millimeters",@"Rods",@"Yards",nil] atIndex:2];
    
    [unitDataArray insertObject:[NSMutableArray arrayWithObjects:@"Data",@"Byte",@"Bit",@"Crumb",@"Nibble",@"Byte",@"Decabit",@"Hectobit",@"Kilobit",@"Megabit",@"Gigabit",@"Terabit",@"Petabit",@"Exabit",@"Zettabit",@"Yottabit",@"Decabyte",@"Hectobyte",@"Kilobyte",@"Megabyte",@"Gigabyte",@"Terabyte",@"Petabyte",@"Exabyte",@"Zettabyte",@"Yottabyte",@"Kibibit",@"Mebibit",@"Gibibit",@"Tebibit",@"Pebibit",@"Exbibit",@"Kibibyte",@"Mebibyte",@"Gibibyte",@"Tebibyte",@"Pebibyte",@"Exbibyte",nil] atIndex:3];
    
    [unitDataArray insertObject:[NSMutableArray arrayWithObjects:@"Current",@"Amperes",@"Electromagnetic",@"Milliamperes",nil] atIndex:4];
    
    [unitDataArray insertObject:[NSMutableArray arrayWithObjects:@"Energy",@"BTUs",@"Calories",@"ElectronVolts",@"Ergs",@"FootPoundForces",@"Joules",@"KilogramForceMeters",@"KilowattHours",@"NewtonMeters",@"Therms",@"WattHours",nil] atIndex:5];
    
    [unitDataArray insertObject:[NSMutableArray arrayWithObjects:@"Force",@"Dynes",@"KilogramForces",@"Newtons",@"Poundals",@"PoundForces",@"Sthenes",nil] atIndex:6];

    [unitDataArray insertObject:[NSMutableArray arrayWithObjects:@"Illumination",@"FootCandles",@"Lumens/Centimeter",@"Lumens/SquareFoot",@"Lumens/SquareMeter,",@"Nox",@"Phots",@"ClearDaySun",nil] atIndex:7];
    
    [unitDataArray insertObject:[NSMutableArray arrayWithObjects:@"Inductance",@"Electromagnetic",@"Electrostatic",@"Henrys",@"Millihenrys",@"Microhenrys",nil] atIndex:8];
    
    [unitDataArray insertObject:[NSMutableArray arrayWithObjects:@"Length",@"Astronomic",@"Centimeters",@"Chains",@"Inches",@"Fathoms",@"Feet",@"Furlongs",@"Kilometers",@"Lightyears",@"Meters",@"Millimeters",@"Miles",@"InternationalNauticalMiles",@"NauticalMiles",@"Parsecs",@"Yards",@"Angstroms",nil] atIndex:9];
    
    [unitDataArray insertObject:[NSMutableArray arrayWithObjects:@"Magnitude",@"Yocto",@"Zepto",@"Atto",@"Femto",@"Pico",@"Nano",@"Micro",@"Milli",@"Centi",@"Deci",@"Normal",@"Deka",@"Hecto",@"Kilo",@"Mega",@"Giga",@"Tera",@"Peta",@"Exa",@"Zetta",@"Yotta",nil] atIndex:10];
    
    [unitDataArray insertObject:[NSMutableArray arrayWithObjects:@"Mass",@"AtomicMassUnits",@"Drachms",@"Drams",@"Grains",@"Grams",@"HundredWeights",@"Kilograms",@"Milligrams",@"TroyOunces",@"USOunces",@"Pennyweights",@"TroyPounds",@"USPounds",@"Quarters",@"Scruples",@"ShortHundredWeights",@"ShortTons",@"Slugs",@"Stones",@"UKTons",@"Tonnes",@"Firkins",nil] atIndex:11];

    [unitDataArray insertObject:[NSMutableArray arrayWithObjects:@"Power",@"Foot/Pound",@"UnitHorsepower",@"MetricHorsepower",@"JoulesPerSecond",@"KilogramForceMeters",@"Watts",nil] atIndex:12];
    
    [unitDataArray insertObject:[NSMutableArray arrayWithObjects:@"Pressure",@"Atmospheres",@"Bars",@"InchesOfMercury",@"InchesOfWater",@"MillimetersOfMercury",@"Newtons/SquareMeter",@"Pascals",@"PoundForces/SquareFoot",@"PoundForces/SquareInch",@"Torrs",nil] atIndex:13];
    
    [unitDataArray insertObject:[NSMutableArray arrayWithObjects:@"Radiation",@"Becquerels",@"Curies",nil] atIndex:14];
    
    [unitDataArray insertObject:[NSMutableArray arrayWithObjects:@"Temperature",@"Celcius",@"Farenheit",@"Kelvin",@"Reaumur",@"Rankine",nil] atIndex:15];
    
    [unitDataArray insertObject:[NSMutableArray arrayWithObjects:@"Time",@"Blinks",@"Centuries",@"Cesium133",@"Days",@"Decades",@"Fortnights",@"Hours",@"Microseconds",@"Millenia",@"Milliseconds",@"Minutes",@"Months",@"Nanoseconds",@"Seconds",@"Ticks",@"Weeks",@"Years",@"LunarYears",@"SiderealSeconds",@"SiderealMinutes",@"SiderealHours",@"SiderealDays",@"SiderealWeeks",@"SiderealYears",@"Microfortnights",nil] atIndex:16];
    
    [unitDataArray insertObject:[NSMutableArray arrayWithObjects:@"Torque",@"DyneCentimeters",@"GramForceCentimeters",@"KilogramForceCentimeters",@"KilogramForceMeters",@"NewtonCentimeters",@"NewtonMeters",@"OunceForceInches",@"PoundalFeet",@"PoundForceFeet",@"PoundForceInches",nil] atIndex:17];
    
    [unitDataArray insertObject:[NSMutableArray arrayWithObjects:@"Velocity",@"CentimetersPerHour",@"CentimetersPerMinute",@"CentimetersPerSecond",@"FeetPerHour",@"FeetPerMinute",@"FeetPerSecond",@"InchesPerHour",@"InchesPerMinute",@"InchesPerSecond",@"KilometersPerHour",@"KilometersPerMinute",@"KilometersPerSecond",@"Knots",@"Light",@"Mach",@"MetersPerHour",@"MetersPerMinute",@"MetersPerSecond",@"MilesPerHour",@"MilesPerMinute",@"MilesPerSecond",@"FurlongsPerMicrofortnight",nil] atIndex:18];
    
    [unitDataArray insertObject:[NSMutableArray arrayWithObjects:@"Volume",@"DryBarrels",@"LiquidBarrels"@"UKBushels",@"USBushels",@"Centiliters",@"CoffeeSpoons",@"CubicCentimeters",@"CubicDecimeters",@"CubicFeet",@"CubicInches",@"CubicKilometers",@"CubicMeters",@"CubicMiles",@"CubicMillimeters",@"CubicYards",@"Cups",@"Dashes",@"Deciliters",@"Drachms",@"Drams",@"Drops",@"Gallons",@"UKGills",@"USGills",@"Liters",@"Milliliters",@"UKMinims",@"USMinims",@"UKFluidOunces",@"USFluidOunces",@"UKPecks",@"USPecks",@"Pinches",@"UKPints",@"USDryPints",@"USFluidPints",@"UKQuarts",@"USDryQuarts",@"USLiquidQuarts",@"Tablespoons",@"Teaspons",@"Number2Point5Cans",@"Number10Cans",nil] atIndex:19];
    
    
    //create and initalize  fromUnit,toUnit dialer arrays from first row of unitDataArray
    fromUnit = [[NSMutableArray alloc] initWithCapacity:30];
    toUnit = [[NSMutableArray alloc] initWithCapacity:30];
    int i =0;
    for (NSString *item in [unitDataArray objectAtIndex:0]){
        if(i > 0 ) {
            [fromUnit insertObject:item atIndex:i -1];
            [toUnit insertObject:item atIndex:i -1];
        }
        i++;
    }
   
    
    
    //setup keyboard
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
    [[self tabBarItem] setTitle:NSLocalizedString(@"Units",nil)];
    
    //reload componets after localization
    [unitConverter reloadComponent:0];
    [unitConverter reloadComponent:1];
    
    //add our custom keyboard to the fromTextView inputview
    fromTextFeild.inputView = self.keyboardView; 
    
    } //viewDidLoad



-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.fromTextFeild.inputView = self.keyboardView;
     textField.inputView = self.keyboardView;
     //[self mykeyboardShow]; 
     NSLog(@"textfieldLog");
        return YES;  // Hide both keyboard and blinking cursor.
}

-(BOOL) textViewShouldBeginEditing:(UITextView*) myfromTextView{
     myfromTextView.inputView = self.keyboardView;
    [myfromTextView resignFirstResponder];
    [self keyboardShow];
    return NO;
    
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

-(void)dealloc
{
    [keyboardView release];
    [unitConverter release];
    [fromUnit release];
    [toUnit release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
    
}
@end
