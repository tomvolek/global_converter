//
//  CreditsViewController.m
//  PersianCalculatorPro
//
//  Created by volek on 9/14/12.
//
//

#import "CreditsViewController.h"

@interface CreditsViewController ()

@end

@implementation CreditsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    //Return YES for supported orientations
    return YES;
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

// Facebook* facebook = [[Facebook alloc] initWithAppId:"121674787908450"];
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //[textFiled1 setBorderStyle:UITextBorderStyleRoundedRect];
    
	return NO;  // return no, so there will be no keyoard display
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
