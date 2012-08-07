//
//  InfoViewController.m
//  PersianCalculatorPro
//
//  Created by volek on 10/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "InfoViewController.h"
//#import "LocalizationSystem.h"

@implementation InfoViewController

@synthesize soundSwitch;
@synthesize languageTableView;
@synthesize listOfLanguages;
@synthesize lastIndexPath;
@synthesize languageSet;
@synthesize fractionValue;
@synthesize  myStepper;



-(IBAction) setSoundSwitch {    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
       [standardUserDefaults setBool:[soundSwitch isOn] forKey:@"audioSwitch"];
        soundSwitch.onTintColor = [UIColor greenColor];
        }
    [standardUserDefaults synchronize];
   DLog(@"audioswitch= %@", soundSwitch.on ? @"On" : @"Off");
  

}


- (IBAction) stepperValueChanged:(id)sender
{
    self.fractionValue.text = [NSString stringWithFormat:@"%d",[[NSNumber numberWithDouble:[(UIStepper *) sender value]] intValue]];
 
    self.fractionValue.text = NSLocalizedString(self.fractionValue.text,nil);
}

- (IBAction)saveInfoView :(id)sender { 
    // read User defaults     
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //create instance of CalcLocalize to convert numbers to localString number
    CalcLocalize *myCalcLocalize = [[CalcLocalize alloc] init];
    [userDefaults setObject:[myCalcLocalize convertLocalToEngNumbers:(NSString *) self.fractionValue.text] forKey:@"Fraction"];
    
    
    [userDefaults synchronize];
    //[self dismissModalViewControllerAnimated:YES ];
    
    [myCalcLocalize release ];
    
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

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //Only one section since we don't need any headers or footers
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"list of languages is: %i", [listOfLanguages count]);
    return [listOfLanguages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView 
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSArray *data = [listOfLanguages objectAtIndex:indexPath.row];
    NSString *languageCode = [data objectAtIndex:2];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleDefault 
                 reuseIdentifier:CellIdentifier] 
                autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.accessoryType = UITableViewCellAccessoryNone;

    }
    if ( [[languageSet objectAtIndex:0] isEqualToString:languageCode] )
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.lastIndexPath = indexPath;
       // NSLog(@"%i update the checkmark indexpath", indexPath.row);
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
   // NSLog(@"%i the indexpath", indexPath.row);
    cell.imageView.image = [UIImage imageNamed:[data objectAtIndex:1]];
    cell.textLabel.text = [data objectAtIndex:0];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *newCell =[tableView cellForRowAtIndexPath:indexPath];
	//int newRow = [indexPath row];
	//int oldRow = [lastIndexPath row];
	
	if (lastIndexPath != indexPath)
    {
        UITableViewCell *newCell = [tableView  cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath: lastIndexPath]; 
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        
        NSLog(@"%i selected row", indexPath.row);
        self.lastIndexPath = indexPath;	
        NSArray *data = [listOfLanguages objectAtIndex:indexPath.row];
        //LocalizationSetLanguage(@"English");
        
        [[NSUserDefaults standardUserDefaults] setObject: [NSArray arrayWithObjects:[data objectAtIndex:2], nil] forKey:@"AppleLanguages"];
        self.languageSet = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    //[[LocalizationSystem sharedLocalSystem] setLanguage:@"Arabic"];
    
    
}

/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Languages";
}
 */

// Do tasks before view becomes visible
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // localize all strings on a given view 
    for(UIView *view in [self.view subviews]) {
        if([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton*)view; 
            
            [btn setTitle:NSLocalizedString([btn titleForState:UIControlStateNormal],nil) forState:UIControlStateNormal];
        }
        else if ([view isKindOfClass:[UILabel class]]){
                 
            UILabel *lbl = (UILabel*)view;
            lbl.text =  NSLocalizedString(lbl.text,nil);
            }
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{       
    [super viewDidLoad];
    
    
     // read Back user preferences from NSUserdefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [soundSwitch setOn:[userDefaults boolForKey:@"audioSwitch"]];
    soundSwitch.onTintColor = [UIColor greenColor];
    self.fractionValue.text= NSLocalizedString([userDefaults stringForKey:@"Fraction"],nil);
    
    //CalcLocalize *myCalcLocalized = [[CalcLocalize alloc] init];
    
    //self.fractionValue.text = [myCalcLocalized convertLocalToEngNumbers:(NSString *) self.fractionValue.text];
    
    if (self.fractionValue.text == nil ) self.fractionValue.text = NSLocalizedString(@"2" ,nil);
        
    //create a structure to read and hold UserDefaultss
    self.languageSet = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    self.listOfLanguages = [[NSMutableArray alloc] initWithCapacity:9];
    
    NSArray *data = [NSArray arrayWithObjects:NSLocalizedString(@"Farsi", @"Farsi Language"), @"Iran-Flag-64.png", @"fa", nil];    
    [self.listOfLanguages addObject:data];
    
    data = [NSArray arrayWithObjects:NSLocalizedString(@"German",  @"German Lanhuage"),  @"Germany-Flag-64.png", @"de", nil];    
    [self.listOfLanguages addObject:data];
    
    data = [NSArray arrayWithObjects:NSLocalizedString(@"Arabic", @"Arabic Language"), @"Saudi-Arabia-Flag-64.png", @"ar", nil];
    [self.listOfLanguages addObject:data];
    
    data = [NSArray arrayWithObjects:NSLocalizedString(@"Chinese", @"Chinese Language"), @"China-Flag-64.png", @"zh", nil];
    [self.listOfLanguages addObject:data];
    
    data = [NSArray arrayWithObjects:NSLocalizedString(@"English", @"English Language"), @"United-States-Flag-64.png", @"en", nil];
    [self.listOfLanguages addObject:data];
    
    data = [NSArray arrayWithObjects:NSLocalizedString(@"Japanese", @"Japanese Lanhuage"), @"Japan-Flag-64.png", @"ja", nil];
    [self.listOfLanguages addObject:data];
    
    data = [NSArray arrayWithObjects:NSLocalizedString(@"Spanish", @"Spanish Language"), @"Spain-Flag-64.png", @"es", nil];
    [self.listOfLanguages addObject:data];
    
    data = [NSArray arrayWithObjects:NSLocalizedString(@"Polish",  @"Ploish Lanhuage"),  @"Poland-Flag-64.png", @"pl", nil];    
    [self.listOfLanguages addObject:data];
    
    data = [NSArray arrayWithObjects:NSLocalizedString(@"French",  @"french Lanhuage"),  @"France-Flag-64.png", @"fr", nil];    
    [self.listOfLanguages addObject:data];
    
    
    self.languageTableView = [[UITableView alloc] initWithFrame:CGRectMake(15, 115, 280, 190) style:UITableViewStyleGrouped];
    
    languageTableView.delegate = self;
    languageTableView.dataSource = self;
    languageTableView.rowHeight = 45;
       
   /* UILabel *tableHeader = [[[UILabel alloc] initWithFrame:CGRectMake(35,80, 200, 32)] autorelease];
    
    tableHeader.backgroundColor = [UIColor clearColor];
    tableHeader.font = [UIFont boldSystemFontOfSize:25];
    tableHeader.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.8];
    tableHeader.textAlignment = UITextAlignmentCenter;
    tableHeader.textColor =[[UIColor alloc] initWithRed:255 / 255 green:255 / 255 blue:220.0 / 255 alpha:1.0];
    
    tableHeader.text = NSLocalizedString(@"Language", @"");
   */
   // languageTableView.tableHeaderView = tableHeader;       
    
    
    languageTableView.backgroundColor = [UIColor clearColor];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"worldMapBackgroud.png"]];
                                              
    [self.view addSubview:languageTableView];
    //[languageTableView reloadData];
   
    if (soundSwitch.on) NSLog(@"switch state: on");
	else NSLog(@"switch state: off");
    NSString *currentLanguage = [languageSet objectAtIndex:0];
    NSLog(@"Lnaguage = %@", currentLanguage);
    
    //Localize any strings on the views
    [LocalizationHelper localizeView:self.view];
    [[self tabBarItem] setTitle:NSLocalizedString(@"Settings",nil)];
}

/*
- (void)awakeFromNib
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [soundSwitch setOn:[userDefaults boolForKey:@"audioSwitch"]];  
    NSLog(@"%@ awakefromNIB", soundSwitch.on ? @"On" : @"Off");
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
   
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
     //Return YES for supported orientations
    return YES;
   // return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {    
    [soundSwitch release]; 
    [listOfLanguages release];
    [languageTableView release];
    [super dealloc];
    }

@end
