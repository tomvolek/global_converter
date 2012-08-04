//
//  CalculatorViewController.m
//  Calculator
//
//  Created by volek on 2/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

// NOTE DEBUG_MODE=1 DEBUG  is set Under Build-Compiler-Preprocessor 

#import "CalculatorViewController.h"
//#import "LocalizationSystem.h"

@implementation CalculatorViewController
@synthesize     calcRecord;
@synthesize     formulaDisplay;
@synthesize     computedFormula;


NSString *formulaAnswer;
NSString *fractionValue;
NSError *error = nil;
bool _hasChosen = NO;
bool soundFlag;
NSInteger counter =0;



/*NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
[soundSwitch setOn:[userDefaults boolForKey:@"audioSwitch"]];
*/



-(IBAction) keyPressed: (id)sender{	
    UIButton  *keyletters = (UIButton*)sender ;
    
    if (soundFlag) {
        [theAudio play];
    }
        
    if ([keyletters.titleLabel.text isEqualToString:@"="] ) {
        counter++;
       // label.text = [label.text stringByAppendingString:[NSString stringWithFormat:@"%d", counter]];
       // label.text = [label.text stringByAppendingString:@":"];
        
        if ([formulaDisplay.text length] < 1) {
            computedFormula = nil;
            // Do nothing, user has pressed without any numbers
            formulaDisplay.text = @"";
         }
        else {
            //error = nil;
           formulaDisplay.text = [self convertLocalizedToUSNumbers:formulaDisplay.text];               
            
            DDMathEvaluator *eval = [DDMathEvaluator sharedMathEvaluator];

            NSNumber *eval_result = [eval evaluateString:formulaDisplay.text withSubstitutions:nil error:&error];    
            
             if(eval_result !=nil & error == nil  ) {   
                // format result with user after ecimial decision in mind.
                NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
                [numberFormatter setRoundingMode: NSNumberFormatterRoundUp];
                numberFormatter.maximumFractionDigits =  [fractionValue integerValue] ;
                formulaAnswer  =  [numberFormatter stringFromNumber:eval_result];
                
                 NSLog(@"Error code %d", error.code);
                 NSLog(@"Error domain %@", error.domain);
                 
                 DLog(@"result=%@",formulaAnswer);
                 DLog(@"resultin = keypress:%@",[self convertUSToLocalizedNumbers:formulaAnswer]);  
                
            
                 
                 label.text = [label.text stringByAppendingString:formulaDisplay.text];
                 
                label.text = [label.text stringByAppendingFormat:@"="];
                label.text = [label.text stringByAppendingString:formulaAnswer];
                label.text = [self convertUSToLocalizedNumbers:label.text];
                label.text = [label.text stringByAppendingString:@"\n"];
                  
                formulaDisplay.text = @"";
                
              
                [numberFormatter release];
                
                //Scroll to end of text area. 
                label.selectedRange = NSMakeRange(label.text.length - 1, 0);
            }
            else {
                label.text = [label.text stringByAppendingString:formulaDisplay.text];
                label.text =[label.text stringByAppendingFormat:@"="];
                
                label.text = [self convertUSToLocalizedNumbers:label.text];
                
                NSLog(@"Error code %d", error.code);
                NSLog(@"Error domain %@", error.domain);
                if (error == nil ) {}
                else {
                    // check error message for the error and call localization
                    NSString * ErrorCode = @"errorcode" ;
                    ErrorCode = [ErrorCode stringByAppendingString:[NSString stringWithFormat:@"%d", error.code]];
        
                    
                    label.text = [label.text stringByAppendingString:NSLocalizedString(ErrorCode, nill)];
                    label.text = [label.text stringByAppendingString:@"\n"];

                    formulaDisplay.text = [self convertUSToLocalizedNumbers:formulaDisplay.text];
                    //scroll to the end of the text
                    label.selectedRange = NSMakeRange(label.text.length - 1, 0);
                    
                }
            }
        }
    }  
    else  if ([keyletters.titleLabel.text isEqualToString:@"+/-"] ) {
        if([formulaDisplay.text hasSuffix:@"-"] )
        {     
            formulaDisplay.text = [formulaDisplay.text substringToIndex:formulaDisplay.text.length -1];
        }else{
            formulaDisplay.text = [formulaDisplay.text  stringByAppendingString:@"-"];
        }
    }
    else {
        //All other characters just add them to the string 
        formulaDisplay.text = [formulaDisplay.text  stringByAppendingString:NSLocalizedString(keyletters.titleLabel.text, nil)];

    }
}
    



-(IBAction) eraseFormula;{
   //user pressed the red erase button on formula, erase the entire Formula
    formulaDisplay.text = @"";
    
    
}



// Facebook* facebook = [[Facebook alloc] initWithAppId:"121674787908450"];
#pragma mark UITextFieldDelegate 
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //[textFiled1 setBorderStyle:UITextBorderStyleRoundedRect];
    
	return NO;  // return no, so there will be no keyoard display	
}


-(NSString*) convertUSToLocalizedNumbers:(NSString*)tempresult{ 
    tempresult= [tempresult stringByReplacingOccurrencesOfString:@"1" withString:NSLocalizedString(@"1", nil)];
    tempresult =[tempresult stringByReplacingOccurrencesOfString:@"2" withString:NSLocalizedString(@"2", nil)];
    tempresult =[tempresult stringByReplacingOccurrencesOfString:@"3" withString:NSLocalizedString(@"3", nil)];
    tempresult =[tempresult stringByReplacingOccurrencesOfString:@"4" withString:NSLocalizedString(@"4", nil)];
    tempresult =[tempresult stringByReplacingOccurrencesOfString:@"5" withString:NSLocalizedString(@"5", nil)];
    tempresult =[tempresult stringByReplacingOccurrencesOfString:@"6" withString:NSLocalizedString(@"6", nil)];
    tempresult =[tempresult stringByReplacingOccurrencesOfString:@"7" withString:NSLocalizedString(@"7", nil)];
    tempresult =[tempresult stringByReplacingOccurrencesOfString:@"8" withString:NSLocalizedString(@"8", nil)];
    tempresult =[tempresult stringByReplacingOccurrencesOfString:@"9" withString:NSLocalizedString(@"9", nil)];
    tempresult =[tempresult stringByReplacingOccurrencesOfString:@"0" withString:NSLocalizedString(@"0", nil)];
    tempresult =[tempresult stringByReplacingOccurrencesOfString:@"." withString:NSLocalizedString(@".", nil)];
    tempresult =[tempresult stringByReplacingOccurrencesOfString:@"*" withString:@"x"];
    
    return tempresult; 

}


-(NSString*) convertLocalizedToUSNumbers:(NSString*)result{ 
    result = [result stringByReplacingOccurrencesOfString:NSLocalizedString(@"1",nil)withString: @"1"];
    result = [result stringByReplacingOccurrencesOfString:NSLocalizedString(@"2",nil)withString: @"2"];
    result = [result stringByReplacingOccurrencesOfString:NSLocalizedString(@"3",nil)withString: @"3"];
    result = [result stringByReplacingOccurrencesOfString:NSLocalizedString(@"4",nil)withString: @"4"];
    result = [result stringByReplacingOccurrencesOfString:NSLocalizedString(@"5",nil)withString: @"5"];
    result = [result stringByReplacingOccurrencesOfString:NSLocalizedString(@"6",nil)withString: @"6"];
    result = [result stringByReplacingOccurrencesOfString:NSLocalizedString(@"7",nil)withString: @"7"];
    result = [result stringByReplacingOccurrencesOfString:NSLocalizedString(@"8",nil)withString: @"8"];
    result = [result stringByReplacingOccurrencesOfString:NSLocalizedString(@"9",nil)withString: @"9"];
    result = [result stringByReplacingOccurrencesOfString:NSLocalizedString(@"0",nil)withString: @"0"];
    result = [result stringByReplacingOccurrencesOfString:NSLocalizedString(@".",nil)withString: @"."];
    result = [result stringByReplacingOccurrencesOfString:@"x" withString: @"*"];
	
    return result;
}



-(IBAction)clear {
    if (soundFlag) {
        [theAudio play];
    }
	
    label.text = @"";
	formulaDisplay.text = @"";
}


//implement the delete button on dislay text area
-(IBAction) eraseCharacter{
    if (soundFlag) {
        [theAudio play];
    }
    if (formulaDisplay.text.length < 1) { }
    else {
        NSRange selectedRange = formulaDisplay.selectedRange;
    
        if ( selectedRange.location > 0 ) {
           NSString *tempString = [formulaDisplay.text substringFromIndex:selectedRange.location];
            formulaDisplay.text = [formulaDisplay.text substringToIndex:selectedRange.location -1];
            formulaDisplay.text = [formulaDisplay.text stringByAppendingString:tempString];
    }
    }
    
}


-(IBAction)emailResults {
    if (soundFlag) {
        [theAudio play];
    }
    
	MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
	composer.mailComposeDelegate = self ;
	if ([MFMailComposeViewController canSendMail]) {		
		
		NSString *emailMessage = @"Calculator Results:\n==============\n";
        emailMessage = [emailMessage stringByAppendingString: label.text];
        
		[composer setToRecipients:[NSArray arrayWithObjects:@"tomvolek@yahoo.com",nil ]]; 
		[composer setSubject:@"Calculator Results: "];
		[composer setMessageBody:emailMessage isHTML:NO];
        
		[self presentModalViewController:composer animated:YES];
    }
    [composer release ]; 
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	[self dismissModalViewControllerAnimated:YES];
	if (result == MFMailComposeResultFailed) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Failed to sendemail" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
		
        [alert show ];
		[alert release];
	}
}


//disable iphone keyboard on text area
#pragma mark UITextViewDelegate 
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView{
    //NSRange range = NSMakeRange([[textView textStorage] length], 0);
    //[textView setSelectedRange: range];    
    //[textView resignFirstResponder];
	return NO;  // return no, so there will be no keyoard display	
    
    //display.inputView = [[UIView new] autorelease];
   // return YES;
}


- (IBAction)showInfo:(id)sender {  
   
    
	InfoViewController *controller = [[[InfoViewController alloc] initWithNibName:@"InfoView" bundle:nil] autorelease];	
	
	//controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self.navigationController pushViewController:controller animated:YES];
	
	
}

- (IBAction)showCurrency:(id)sender {  
    
	CurrencyViewController *currencyController = [[[CurrencyViewController alloc] initWithNibName:@"CurrencyView" bundle:nil] autorelease];	
	
	currencyController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    // push the CurranctView to navigation controller stack 
	[self.navigationController pushViewController:currencyController animated:YES];
	
	
}


- (IBAction)showUnits:(id)sender {  
    
	Units *unitController = [[[Units alloc] initWithNibName:@"Units" bundle:nil] autorelease];	
    
	
	unitController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    // push the unitController to navigation controller stack 
    [self.navigationController pushViewController:unitController animated:YES];
	//[self.navigationController presentModalViewController:unitController animated:YES];
	
	
}


// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //Localize any strings on the views
        [LocalizationHelper localizeView:self.view];
        
        

    }
    return self;
}

- (void)awakeFromNib
{
   // self.title = NSLocalizedString(@"Test", @"");
    //Localize any strings on the views
    [LocalizationHelper localizeView:self.view];

    
}


/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */

-(NSString*)retrieveFromUserDefaults
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSString *val = nil;
	
	if (standardUserDefaults) 
		val = [standardUserDefaults objectForKey:@"Prefs"];
	
	return val;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    //NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //soundFlag= [userDefaults boolForKey:@"audioSwitch"];
    //fractionValue = [userDefaults stringForKey:@"Fraction"];
    
    //NSString *currentLanguage = [languageSet objectAtIndex:0];
    //NSLog(@"Lnaguage = %@", currentLanguage);

	// set status bar to black
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    [[label layer] setCornerRadius:5];  
    [[formulaDisplay layer] setCornerRadius:5];    
    [formulaDisplay setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:22]];
    
     //add Image to both formula and history UITextView
     label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"gradientBackground.png"]];
     formulaDisplay.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"middleRowSelected.png"]];
    
    // SetUp sound 
     NSString *path = [[NSBundle mainBundle] pathForResource:@"button5" ofType:@"wav"];
    theAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    // now initialize the player 
    theAudio.delegate=self;
    [theAudio prepareToPlay];
     
    
    // look for all BUttons on the main view and localize their title string.
    for(UIView *view in [self.view subviews]) {
        if([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton*)view; 
            btn.titleLabel.text = NSLocalizedString(btn.titleLabel.text, nil);
            [btn  setTitle:NSLocalizedString(btn.titleLabel.text,nil) forState:UIControlStateNormal];
        }
        else{}
    } 
    
    // call our helper class to localize all strings on a view
    [LocalizationHelper localizeView:self.view];
}


// Do tasks before view becomes visible
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    soundFlag= [userDefaults boolForKey:@"audioSwitch"];
   
    if (!(fractionValue = [userDefaults stringForKey:@"Fraction"])) {
        fractionValue = @"2";
    }
    
    
    NSArray* languages = [userDefaults objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    NSLog(@"preferredLang Read ViewApear=%@",preferredLang);

   [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:preferredLang, nil] forKey:@"AppleLanguages"];
      
    
    // look for all BUttons on the main view and localize their title string.
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
    
    //Localize any strings on the views
    [LocalizationHelper localizeView:self.view];
    
    for (UITabBarItem *tabBarItem in self.tabBarController.tabBar.items )
    {
        tabBarItem.title = NSLocalizedString(tabBarItem.title,nil);
    }
}

// Override to allow orientations other than the default portrait orientation.

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
   return YES ;
    
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    //NSLog(@"What is the orientation: %i", toInterfaceOrientation);
    if ( (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) ||(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) )
    {
        NSLog(@"What is the orientation: %i", toInterfaceOrientation);
        
        PersianCalculatorLandscape *myOwnController = [[[[PersianCalculatorLandscape alloc] init]  initWithNibName:@"PersianCalculatorLandscape" bundle:nil whichTab:0]autorelease];
        NSMutableArray* newArray = [NSMutableArray arrayWithArray:self.tabBarController.viewControllers];
        [newArray replaceObjectAtIndex:0 withObject:myOwnController];
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


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)dealloc {
    [super dealloc];
}

@end

