//
//  PersianCalculatorLandscape.m
//  PersianCalculator
//
//  Created by volek on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//  43.405x963.134

#import "PersianCalculatorLandscape.h"
#import "CalculatorViewController.h"
#import "PlotCalc.h"

@implementation PersianCalculatorLandscape

@synthesize display;
@synthesize degreeLabel;
@synthesize sinButton ;
@synthesize cosButton;
@synthesize tanButton;
@synthesize lnButton;
@synthesize sinhButton;
@synthesize coshButton;
@synthesize tanhButton;
@synthesize exButton;

@synthesize calcRecord;

@synthesize inputedFormula ;
@synthesize magnifiedLetter;
@synthesize magnifiedLetterRubOut;
@synthesize memory;


int     secondButtonFlag = 0 ; 
int     radianFlag  = 1 ;
bool    soundFlag;
NSError *eval_error = nil;
NSString *fractionValue;


-(IBAction) userTouchDown:(id)sender{ 
    UIButton *keyButton = (UIButton*) sender ;
    [keyButton setContentMode:UIViewContentModeCenter];
    CGRect keyButtonFrame = keyButton.frame;
    CGRect magFrame = magnifiedLetter.frame;
    magFrame.origin.x = (keyButtonFrame.origin.x) - 3;
    magFrame.origin.y = keyButtonFrame.origin.y - 60;
    
    if(keyButton.tag == 8) {
        magnifiedLetterRubOut.frame = magFrame;
        magnifiedLetterRubOut.contentMode = UIViewContentModeScaleAspectFit;
        [self.view  addSubview:magnifiedLetterRubOut];
        [self.view  bringSubviewToFront:magnifiedLetterRubOut ];        
        magnifiedLetterRubOut.hidden=NO;

        }
    else {
        magnifiedLetter.frame = magFrame;
        magnifiedLetter.contentMode = UIViewContentModeScaleAspectFit;
        UILabel *tempText = [[UILabel alloc] initWithFrame:CGRectMake(10, -20, 40, 90)];
    
        tempText.text = NSLocalizedString(keyButton.titleLabel.text,nil);
        tempText.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(18.0)];
        tempText.backgroundColor = [UIColor clearColor];
        tempText.contentMode = UIViewContentModeCenter;
        tempText.adjustsFontSizeToFitWidth = YES ;
        tempText.textAlignment =  UITextAlignmentCenter;
        tempText.tag = 500;

        [magnifiedLetter addSubview:tempText];
        [tempText release];
        [self.view  addSubview:magnifiedLetter];
        [self.view  bringSubviewToFront:magnifiedLetter ];        
        magnifiedLetter.hidden=NO;
    }
}

-(IBAction) numericKeyPressed: (id)sender{	
	UIButton *keyButton = (UIButton*)sender;
    if (soundFlag) {
        [theAudio play];
    }
        
    //user lifts his finger, remove magnifying letter from view 
    magnifiedLetter.hidden=YES;
    [[magnifiedLetter viewWithTag:500] removeFromSuperview];
    [[self.view viewWithTag:2000] removeFromSuperview];

    display.text = [display.text  stringByAppendingString:NSLocalizedString(keyButton.titleLabel.text,nil)];
    inputedFormula  = [inputedFormula stringByAppendingString:keyButton.titleLabel.text];
}


-(IBAction) signPressed: (id) sender {
    UIButton *signButton = (UIButton*)sender;
    
    if (soundFlag) {
        [theAudio play];
    }
    
    //user lifts his finger, remove magnifying letter from view 
    magnifiedLetter.hidden=YES;
    [[magnifiedLetter viewWithTag:500] removeFromSuperview];
    [[self.view viewWithTag:2000] removeFromSuperview];
    
    
    if ([signButton.titleLabel.text isEqualToString:@"("] ) {
     display.text = [display.text  stringByAppendingString:signButton.titleLabel.text];
     inputedFormula  = [inputedFormula stringByAppendingString:signButton.titleLabel.text];
           }
    else if ([signButton.titleLabel.text isEqualToString:@")"] ) {
        display.text = [display.text  stringByAppendingString:signButton.titleLabel.text];
        inputedFormula  = [inputedFormula stringByAppendingString:signButton.titleLabel.text];
    }
    else if ([signButton.titleLabel.text isEqualToString:@"m+"] )
    {
       if (display.text.length > 0){
           NSString *tempDisplay = [self convertLocalizedToUSNumbers:display.text];
        
           int tempValue= [tempDisplay intValue] + [self.memory intValue];
           self.memory = [NSString stringWithFormat:@"%d", tempValue];
           //set state of the mr(tag=13) button to active 
           UIButton *m_plus = (UIButton *)[signButton.superview viewWithTag:13];
           [m_plus setBackgroundImage:[UIImage imageNamed:@"green_button_gloss.png"]   forState:UIControlStateNormal];
       }
    }
    else if ([signButton.titleLabel.text isEqualToString:@"m-"] )
    {
        if (display.text.length > 0){
        NSString *tempDisplay = [self convertLocalizedToUSNumbers:display.text];
        int tempValue= [tempDisplay intValue] - [self.memory intValue];
        self.memory = [NSString stringWithFormat:@"%d", tempValue];
        //set state of the m- button to active 
        }
    }
    else if ([signButton.titleLabel.text isEqualToString:@"mr"] )
    {
        if (self.memory > 0){
        display.text = [display.text stringByAppendingString:[self convertUSToLocalizedNumbers:self.memory]];
        }
    }
    else if ([signButton.titleLabel.text isEqualToString:@"mc"] )
    {
        self.memory = nil;
        UIButton *m_plus = (UIButton *)[signButton.superview viewWithTag:13];
        [m_plus setBackgroundImage:[UIImage imageNamed:@"white_button_gloss.png"]   forState:UIControlStateNormal];
    }
    else if ([signButton.titleLabel.text isEqualToString:@"%"] ) {
        display.text = [display.text  stringByAppendingString:signButton.titleLabel.text];
        inputedFormula  = [inputedFormula stringByAppendingString:signButton.titleLabel.text];
    }
    else if ([signButton.titleLabel.text isEqualToString:NSLocalizedString(@"1/x",nil) ] ){
        display.text = [display.text  stringByAppendingString:NSLocalizedString(@"1/",nil)];
    }
    else if ([signButton.titleLabel.text isEqualToString:NSLocalizedString(@"x2",nil)] ) {
        display.text = [display.text  stringByAppendingString:NSLocalizedString(@"**2",nil)];
    }
    else if ([signButton.titleLabel.text isEqualToString:NSLocalizedString(@"x3",nil)] ) {
        display.text = [display.text  stringByAppendingString:NSLocalizedString(@"**3",nil)];
    }
    else if ([signButton.titleLabel.text isEqualToString:@"yx"] ) {
        display.text = [display.text  stringByAppendingString:@"**"];
    }
    else if ([signButton.titleLabel.text isEqualToString:@"x!"] ) {
        display.text = [display.text  stringByAppendingString:@"!"];
    }
    else if ([signButton.titleLabel.text isEqualToString:@"√"] ) {
        display.text = [display.text  stringByAppendingString:@"sqrt("];
    }
    else if ([signButton.titleLabel.text isEqualToString:@"y^x"] ) {
        display.text = [display.text  stringByAppendingString:@"^"];
    }
    else if ([signButton.titleLabel.text isEqualToString:@"log"] ) {
        display.text = [display.text  stringByAppendingString:@"log("];
    }
    else if ([signButton.titleLabel.text isEqualToString:@"sin"] ) {
        if (radianFlag == 1) {
            display.text = [display.text  stringByAppendingString:@"sin("];
        } else {
            display.text = [display.text  stringByAppendingString:@"sin(dtor("];
            //display.text = [display.text  stringByAppendingString:@"sin°);
            
        }
    }
    else if ([signButton.titleLabel.text isEqualToString:@"cos"] ) {
        if (radianFlag == 1) {
        display.text = [display.text  stringByAppendingString:@"cos("];
        
        }
        else {
            display.text = [display.text  stringByAppendingString:@"cos(dtor("];
           
        }
    }
    else if ([signButton.titleLabel.text isEqualToString:@"tan"] ) {
         if (radianFlag == 1) {
        display.text = [display.text  stringByAppendingString:@"tan("];
        
         }
         else {
             display.text = [display.text  stringByAppendingString:@"tan(dtor("];
         }
    }
    else if ([signButton.titleLabel.text isEqualToString:@"ln"] ) {
        display.text = [display.text  stringByAppendingString:@"ln("];
    }
    else if ([signButton.titleLabel.text isEqualToString:@"sinh"] ) {
        if (radianFlag == 1) {
        display.text = [display.text  stringByAppendingString:@"sinh("];
        }
        else {  
            display.text = [display.text  stringByAppendingString:@"sinh(dtor("];
        }
    }
    else if ([signButton.titleLabel.text isEqualToString:@"cosh"] ) {
         if (radianFlag == 1) {
        display.text = [display.text  stringByAppendingString:@"cosh("];
         }
         else {
             display.text = [display.text  stringByAppendingString:@"cosh(dtor("];
            }
    }
    else if ([signButton.titleLabel.text isEqualToString:@"tanh"] ) {
         if (radianFlag == 1) {
        display.text = [display.text  stringByAppendingString:@"tanh("];
         }
         else {
             display.text = [display.text  stringByAppendingString:@"tanh(dtor("];
         }
    }
    else if ([signButton.titleLabel.text isEqualToString:@"ex"] ) {
        display.text = [display.text  stringByAppendingString:
         NSLocalizedString(@"2.718252**",nil)];
    }
    else if ([signButton.titleLabel.text isEqualToString:@"π"] ) {
        display.text = [display.text  stringByAppendingString: 
                        NSLocalizedString(@"3.141592653589793",nil)];
  
    }
    else if ([signButton.titleLabel.text isEqualToString:@"EE"] ) {
        display.text = [display.text  stringByAppendingString:
                        NSLocalizedString(@"10^",nil)];
                        
    }
    else if ([signButton.titleLabel.text isEqualToString:@"Rand"] ) {
        display.text = [display.text  stringByAppendingString:NSLocalizedString(@"random(0,1000)",nil)];
    }
    else if ([signButton.titleLabel.text isEqualToString:NSLocalizedString(@"sin-1",nil)] ) {
        if (radianFlag == 1) {
        display.text = [display.text  stringByAppendingString:@"asin("];
        }
        else {
            display.text = [display.text  stringByAppendingString:@"asin(dtor("];
        }
    }
    else if ([signButton.titleLabel.text isEqualToString:NSLocalizedString(@"cos-1",nil)] ) {
         if (radianFlag == 1) {
        display.text = [display.text  stringByAppendingString:@"acos("];
         }
         else {
             display.text = [display.text  stringByAppendingString:@"acos(dtor("];
         }
    }

    else if ([signButton.titleLabel.text isEqualToString:NSLocalizedString(@"tan-1",nil)] ) {
        if (radianFlag == 1) {
            display.text = [display.text  stringByAppendingString:@"atan("];
        }
        else {
            display.text = [display.text  stringByAppendingString:@"atan(dtor("];
        }
    }

    else if ([signButton.titleLabel.text isEqualToString:NSLocalizedString(@"log2",nil)] ) {
        display.text = [display.text  stringByAppendingString:NSLocalizedString(@"log2(",nil)];
    }

    else if ([signButton.titleLabel.text isEqualToString:NSLocalizedString(@"sinh-2",nil)] ) {
        if (radianFlag == 1) {
        display.text = [display.text  stringByAppendingString:@"asinh("];
        }
        else {
            display.text = [display.text  stringByAppendingString:@"asinh(dtor("];
        }
    }
    else if ([signButton.titleLabel.text isEqualToString:NSLocalizedString(@"cosh-1",nil)] ) {
        if (radianFlag == 1) {
        display.text = [display.text  stringByAppendingString:@"acosh("];
        }
        else {
            display.text = [display.text  stringByAppendingString:@"acosh(dtor("];
        } 
    }

    else if ([signButton.titleLabel.text isEqualToString:NSLocalizedString(@"tanh-1",nil)] ) {
        if (radianFlag == 1) {
        display.text = [display.text  stringByAppendingString:@"atanh("];
        }
        else {
            display.text = [display.text  stringByAppendingString:@"atanh(dtor("];
        }
    }

    else if ([signButton.titleLabel.text isEqualToString:NSLocalizedString(@"2^x",nil)] ) {
        display.text = [display.text  stringByAppendingString:NSLocalizedString(@"2**",nil)];
    }
    
    else if ([signButton.titleLabel.text isEqualToString:@"+"] ) {
        display.text = [display.text  stringByAppendingString:signButton.titleLabel.text];
    }
    else if ([signButton.titleLabel.text isEqualToString:@"-"] ) {
        display.text = [display.text  stringByAppendingString:signButton.titleLabel.text];
    }
    else if ([signButton.titleLabel.text isEqualToString:@"×"] ) {
        display.text = [display.text  stringByAppendingString:signButton.titleLabel.text];
    }
    else if ([signButton.titleLabel.text isEqualToString:@"÷"] ) {
        display.text = [display.text  stringByAppendingString:@"÷"];        
    }
    else if ([signButton.titleLabel.text isEqualToString:@"+/-"] ) {
        
            if([display.text hasSuffix:@"-"] )
            {     
            display.text = [display.text substringToIndex:display.text.length -1];
            }else{
                display.text = [display.text  stringByAppendingString:@"(-"];
            }
    }
    else if ([signButton.titleLabel.text isEqualToString:@"Deg"] ) {
        [signButton setTitleColor:[UIColor redColor]  forState:UIControlStateNormal]; 
        [signButton setTitle:@"Rad" forState:UIControlStateNormal ];
        degreeLabel.text = @"Deg";
        //set Radian falg to be checked when user inputs Trigonometry
        radianFlag = 0 ; 
    }
    else if ([signButton.titleLabel.text isEqualToString:@"Rad"] ) {                
        [signButton setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal]; 
        [signButton setTitle:@"Deg" forState:UIControlStateNormal ];
        degreeLabel.text = @"Rad";
         //set Radian falg to be checked when user inputs Trigonometry
        radianFlag = 1 ; 
    }
       
    
    signButton.titleLabel.text= NSLocalizedString(signButton.titleLabel.text,nil);
}


-(NSString*) convertUSToLocalizedNumbers:(NSString*)result{ 
    result= [result stringByReplacingOccurrencesOfString:@"1" withString:NSLocalizedString(@"1", nil)];
    result =[result stringByReplacingOccurrencesOfString:@"2" withString:NSLocalizedString(@"2", nil)];
    result =[result stringByReplacingOccurrencesOfString:@"3" withString:NSLocalizedString(@"3", nil)];
    result =[result stringByReplacingOccurrencesOfString:@"4" withString:NSLocalizedString(@"4", nil)];
    result =[result stringByReplacingOccurrencesOfString:@"5" withString:NSLocalizedString(@"5", nil)];
    result =[result stringByReplacingOccurrencesOfString:@"6" withString:NSLocalizedString(@"6", nil)];
    result =[result stringByReplacingOccurrencesOfString:@"7" withString:NSLocalizedString(@"7", nil)];
    result =[result stringByReplacingOccurrencesOfString:@"8" withString:NSLocalizedString(@"8", nil)];
    result =[result stringByReplacingOccurrencesOfString:@"9" withString:NSLocalizedString(@"9", nil)];
    result =[result stringByReplacingOccurrencesOfString:@"0" withString:NSLocalizedString(@"0", nil)];
    result =[result stringByReplacingOccurrencesOfString:@"." withString:NSLocalizedString(@".", nil)];
    result =[result stringByReplacingOccurrencesOfString:@"*" withString:NSLocalizedString(@"x", nil)];
    
    //display.text = result; 
    return result;
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
    result = [result stringByReplacingOccurrencesOfString:NSLocalizedString(@"x",nil)withString: @"*"];
	
    return  result;
}
   

-(IBAction) equalButtonLandscape:(id)sender {
    if (soundFlag) {
        [theAudio play];
    }
    
    if (display.text.length < 1)
    {  // do nothing user inputed nothing
    }
    else {
        eval_error = nil;
        display.text = [self convertLocalizedToUSNumbers:display.text];
    
        DDMathEvaluator *eval = [DDMathEvaluator sharedMathEvaluator];
        NSNumber *eval_result= nil;
        eval_result = [eval evaluateString:display.text withSubstitutions:nil error:&eval_error]; 
        if(eval_result != nil & eval_error == nil) {
    
            DLog(@"eval_result !=nill");
            // format result with user after ecimial decision in mind.
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setRoundingMode: NSNumberFormatterRoundUp];
            numberFormatter.maximumFractionDigits =  [fractionValue integerValue] ;

            display.text  =   [display.text stringByAppendingString:@"="];
            display.text = [display.text stringByAppendingString:  [numberFormatter stringFromNumber:eval_result]];         
            display.text = [self convertUSToLocalizedNumbers:display.text];
            display.text = [ display.text stringByAppendingString:@"\n"];
            
            // add results to result array for record keeping.
            [calcRecord addObject:display.text ];

            
            [numberFormatter release];
            }
        else {
            
            if(eval_error==nil) {}
            else {
                NSString * ErrorCode = @"errorcode" ;
                ErrorCode = [ErrorCode stringByAppendingString:[NSString stringWithFormat:@"%d", eval_error.code]];
                
                display.text =[display.text stringByAppendingFormat:@"="];
                display.text = [self convertUSToLocalizedNumbers:display.text];
                display.text = [display.text stringByAppendingString:NSLocalizedString(ErrorCode, nill)];
                display.text = [display.text stringByAppendingString:@"\n"];
                NSLog(@"Error code %d", eval_error.code);
                NSLog(@"Error domain %@", eval_error.domain);
                }
            }
        display.selectedRange = NSMakeRange(display.text.length - 1, 0);
        
        
        
    }
} 
    


-(IBAction)emailResults {
    if (soundFlag) {
        [theAudio play];
    }
        
	MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
	composer.mailComposeDelegate = self ;
	if ([MFMailComposeViewController canSendMail]) {		
		
    
        NSLog(@"Size of array = %d",[calcRecord count]);
        
		NSString *emailMessage ;
         
        emailMessage = [calcRecord componentsJoinedByString:@" "];
        emailMessage = [emailMessage stringByAppendingString:@"\n"];
        		
		[composer setToRecipients:[NSArray arrayWithObjects:@"tomvolek@yahoo.com",nil ]]; 
		[composer setSubject:NSLocalizedString(@"Calculator Results:",nil)];
		[composer setMessageBody:emailMessage isHTML:NO];
        
		[self presentModalViewController:composer animated:YES];
    }
    [composer release];
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




// "2sn" Button was pressed, Change certain buttons for their second fucntionality
-(IBAction) secondButton:(id)sender{
    if (soundFlag) {
        [theAudio play];
    }
    
    UIButton *myButton = (UIButton*) sender ;
    //keyButton.tag = 1000;
    [myButton setContentMode:UIViewContentModeCenter];
    CGRect keyButtonFrame = myButton.frame;
    CGRect magFrame = magnifiedLetter.frame;
    magFrame.origin.x = (keyButtonFrame.origin.x) - 3;
    magFrame.origin.y = keyButtonFrame.origin.y - 60;
    magnifiedLetter.frame = magFrame;
    magnifiedLetter.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel *tempText = [[UILabel alloc] initWithFrame:CGRectMake(10, -20, 40, 90)];
    tempText.text = myButton.titleLabel.text;
    tempText.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(18.0)];
    tempText.backgroundColor = [UIColor clearColor];
    tempText.contentMode = UIViewContentModeCenter;
    tempText.adjustsFontSizeToFitWidth = YES ;
    tempText.textAlignment =  UITextAlignmentCenter;
    tempText.tag = 500;
    [magnifiedLetter addSubview:tempText];
    [tempText release];
    
    [self.view  addSubview:magnifiedLetter];
    [self.view  bringSubviewToFront:magnifiedLetter ];
    
    magnifiedLetter.hidden=NO;
    
    UIButton *keyButton = (UIButton*)sender;
    //test to see if secondButton is not pressed, then set state to press if it is true. 
    if (secondButtonFlag == 0 ) {
        secondButtonFlag = 1 ; 
        [keyButton setTitleColor:[UIColor redColor]  forState:UIControlStateNormal]; 
        
        [keyButton setBackgroundImage:[UIImage imageNamed:@"green_button_gloss.png"]  forState:UIControlStateNormal];
    
        [sinButton setTitle:NSLocalizedString(@"sin-1",nil) forState:UIControlStateNormal ];
        [cosButton setTitle:NSLocalizedString(@"cos-1",nil) forState:UIControlStateNormal ];
        [tanButton setTitle:NSLocalizedString(@"tan-1",nil) forState:UIControlStateNormal ];
        [lnButton  setTitle:NSLocalizedString(@"log2",nil) forState:UIControlStateNormal ];
        [sinhButton setTitle:NSLocalizedString(@"sinh-1",nil) forState:UIControlStateNormal ];
        [coshButton setTitle:NSLocalizedString(@"cosh-1",nil) forState:UIControlStateNormal ];
        [tanhButton setTitle:NSLocalizedString(@"tanh-1",nil) forState:UIControlStateNormal ];
        [exButton   setTitle:NSLocalizedString(@"2^x",nil) forState:UIControlStateNormal ];
    }
    else {
        secondButtonFlag = 0 ; // set back secondButton flag to 0
        [keyButton setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
        [keyButton setBackgroundImage:[UIImage imageNamed:@"white_button_gloss.png"]  forState:UIControlStateNormal];
    
        [sinButton setTitle:@"sin" forState:UIControlStateNormal ];
        [cosButton setTitle:@"cos" forState:UIControlStateNormal ];
        [tanButton setTitle:@"tan" forState:UIControlStateNormal ];
        [lnButton  setTitle:@"ln" forState:UIControlStateNormal ];
        [sinhButton setTitle:@"sinh" forState:UIControlStateNormal ];
        [coshButton setTitle:@"cosh" forState:UIControlStateNormal ];
        [tanhButton setTitle:@"tanh" forState:UIControlStateNormal ];
        [exButton   setTitle:@"ex" forState:UIControlStateNormal ];
    
    }
    
}


- (IBAction)showInfo:(id)sender {    
	InfoViewController *controller = [[[InfoViewController alloc] initWithNibName:@"InfoView" bundle:nil] autorelease];	
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self.navigationController presentModalViewController:controller animated:YES];
	//[controller release];
}


-(IBAction)clear {
    if (soundFlag) {
        [theAudio play];
    }
    
	display.text = @"";
}


//implement the delete button on dislay text area
#pragma mark removecharacter 
-(IBAction) removeLastCharacter{
    if (soundFlag) {
        [theAudio play];
    }
    
    magnifiedLetterRubOut.hidden=YES;
    //[[magnifiedLetter viewWithTag:500] removeFromSuperview];
    [[self.view viewWithTag:2001] removeFromSuperview];

    
    if (display.text.length >0) {
        
         NSRange selectedRange = display.selectedRange;
    
        //Erase the character at the spot user pressed his finer
        if ( selectedRange.location > 0 ) {
        NSString *tempString = [display.text substringFromIndex:selectedRange.location];
        display.text = [display.text substringToIndex:selectedRange.location -1];
        display.text = [display.text stringByAppendingString:tempString]; 
       
     }
    }    
}

//disable iphone keyboard on text area
#pragma mark UITextViewDelegate 
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView{
    //NSRange range = NSMakeRange([[textView textStorage] length], 0);
    //[textView setSelectedRange: range];    
    //[textView resignFirstResponder];
	//return NO;  // return no, so there will be no keyoard display	
    
    //display.inputView = [[UIView new] autorelease];
    return YES;
}


- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                            selector:@selector(keyboardWillShow:)
                        name:UIKeyboardWillShowNotification object:nil];
    
}


- (void)keyboardWillShow:(NSNotification*)aNotification
{
    [display resignFirstResponder];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil whichTab:(int)tabselected
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        selectedTabindex = tabselected;
        [self registerForKeyboardNotifications];
        
       
    }
    return self;
}



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



- (void)initMagnifiedLetter { 
    
    UIImage *magniferImage = [UIImage imageNamed:@"keysymbol.png"];
    self.magnifiedLetter = [[ UIImageView alloc ] initWithFrame:CGRectMake(0.0, 0.0, magniferImage.size.width, magniferImage.size.height)];
    
    NSLog(@"Magwidthe: %f",magniferImage.size.width);
    NSLog(@"Magheigh: %f",magniferImage.size.height);
    
    magnifiedLetter.image = magniferImage;
    self.magnifiedLetter.tag = 2000 ;
    // opaque for better performance  
    self.magnifiedLetter.opaque = YES;  
    
    // construct an UIImage view to host the magnifying effect for rubout
    UIImage *magniferImageRubOut = [UIImage imageNamed:@"keysymbolrub.png"];
   // magnifiedLetterRubOut = [[ UIImageView alloc ] initWithFrame:CGRectMake(0.0, 0.0, magniferImageRubOut.size.width, magniferImageRubOut.size.height)];
    
    
    magnifiedLetterRubOut = [[ UIImageView alloc ] initWithFrame:CGRectMake(0.0, 0.0, magniferImage.size.width, magniferImage.size.height)];
    magnifiedLetterRubOut.image = magniferImageRubOut;
    self.magnifiedLetterRubOut.tag = 2001 ;
    self.magnifiedLetterRubOut.opaque = YES; 
    
}  



#pragma mark - viewDidLoad

- (void)viewDidLoad
{    
    [super viewDidLoad];
    
    NSLog(@"We are in landscape mode");
    //self.navigationController.navigationBarHidden = YES;
    //self.tabBarController.tabBar.hidden = YES;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    soundFlag= [userDefaults boolForKey:@"audioSwitch"];
    fractionValue = [userDefaults stringForKey:@"Fraction"];

    calcRecord = [[NSMutableArray alloc] init];
    
    // Do any additional setup after loading the view from its nib.
    //attach an inputView to be able to hide keyboard on display UITextView
    display.inputView = [[UIView new] autorelease];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gradientBackground.jpg"]];
    imageView.frame = CGRectMake(0, 0, display.frame.size.width, display.frame.size.height );
    [display addSubview: imageView];
    [display sendSubviewToBack:imageView];
    //[imageView release];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"button5" ofType:@"wav"];
    theAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    
    theAudio.delegate=self;
    [theAudio prepareToPlay];

    
    [[display layer] setCornerRadius:5];
    
    //Call initMagnifiedLetter to set magnification Icon 
    [self initMagnifiedLetter];  
    
    // look for all BUttons on the main view and localize their title string.
    for(UIView *view in [self.view subviews]) {
        if([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton*)view; 
            btn.titleLabel.text = NSLocalizedString(btn.titleLabel.text, nil);
            [btn  setTitle:NSLocalizedString(btn.titleLabel.text,nil) forState:UIControlStateNormal];
            }
        else{}
    }  
    //Localize any strings on the views
    [LocalizationHelper localizeView:self.view];
    [[self tabBarItem] setTitle:NSLocalizedString(@"Scientific",nil)];

}


- (IBAction)showDoneMessage:(id)sender {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Calc Preferences!"
                                                      message:NSLocalizedString(@"You need to exit and come back for Preferences to take effect.",nil)
                                                     delegate:nil
                                            cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                            otherButtonTitles:nil];
    
    [message show];
    [message release];
}

- (void)viewDidUnload
{
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if ( (toInterfaceOrientation == UIInterfaceOrientationPortrait) || (toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) )
    {
        if (selectedTabindex == 0)
        {
            CalculatorViewController *calcViewController = [[[[CalculatorViewController alloc] init]  initWithNibName:@"CalculatorViewController" bundle:nil]autorelease];
            NSMutableArray* tabbarArray = [NSMutableArray arrayWithArray:self.tabBarController.viewControllers];
            [tabbarArray replaceObjectAtIndex:0 withObject:calcViewController];
            [self.tabBarController setViewControllers:tabbarArray animated:YES];
            
            UIViewController *tab1 = [tabbarArray objectAtIndex:0];
            tab1.tabBarItem.image = [UIImage imageNamed:@"161-calculator.png"];
            tab1.tabBarItem.title = NSLocalizedString(@"Calculator",nill);
            
        }
        else if (selectedTabindex == 1) {
           PlotCalc *plotViewController = [[[[PlotCalc alloc] init]  initWithNibName:@"PlotCalc" bundle:nil]autorelease];
            NSMutableArray* tabbarArray = [NSMutableArray arrayWithArray:self.tabBarController.viewControllers];
            [tabbarArray replaceObjectAtIndex:1 withObject:plotViewController];
            [self.tabBarController setViewControllers:tabbarArray animated:YES];
            
            UIViewController *tab1 = [tabbarArray objectAtIndex:1];
            tab1.tabBarItem.image = [UIImage imageNamed:@"16-line-chart.png"];
            tab1.tabBarItem.title = NSLocalizedString(@"Plot",nill);
        }
        
        
        
    
    }
    
    
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation { 
    //CGRect previousRect = self.view.frame;
    UIInterfaceOrientation toOrientation = self.interfaceOrientation;
    
    if ( self.tabBarController.view.subviews.count >= 2 )
    {
        UIView *transView = [self.tabBarController.view.subviews objectAtIndex:0];
        UIView *tabBar = [self.tabBarController.view.subviews objectAtIndex:1];
        
        if ( (toOrientation == UIInterfaceOrientationPortrait) || (toOrientation == UIInterfaceOrientationPortraitUpsideDown) ) {                                     
            //transView.frame = CGRectMake(0, 0, 480, 320 );
            tabBar.hidden = FALSE;
        }
        else
        {                               
            transView.frame = CGRectMake(0, 0, 480, 320 );         
            tabBar.hidden = TRUE;
        }
    }
}



- (void)dealloc
{
    
    [magnifiedLetter release];
    [calcRecord release];
    [super dealloc];
}

@end
