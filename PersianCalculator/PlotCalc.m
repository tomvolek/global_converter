//
//  PlotCalc.m
//  PersianCalculatorPro
//
//  Created by volek on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PlotCalc.h"

@implementation PlotCalc

@synthesize functionText,
            yTextfield,
            inputFormula,
            keyboardView,
            myPickerView;
bool soundFlag;
// flag to test which UITextField is receiving input
int whichTextField=0; 

/*
// Insert a string into a UITextField at the cursor position
- (void)insertString:(NSString *)text intoTextField(UITextField *)functionText {
    UIPasteboard* generalPasteboard = [UIPasteboard generalPasteboard];
    NSArray* items = [generalPasteboard.items copy];
    generalPasteboard.string = text;
    [functionText paste:self];
    generalPasteboard.items = items;
    [items release];
}
*/
-(void) keyPressed: (id)sender{	
    if (soundFlag) {
        [theAudio play];
    }

    UIButton  *keyletters = (UIButton*)sender ;
    
    if ([keyletters.titleLabel.text isEqualToString:@"="] ) {
        if ([functionText.text length] < 1) {
            
            // Do nothing, user has pressed without any numbers
        }
        else {
            //Call the function to calculate Unit conversion 
            [self equalKey];
        }
    } 
    else if ([keyletters.titleLabel.text isEqualToString:@"C"] ) {
          functionText.text=@"";
          yTextfield.text=@"";
    }
    else if ([keyletters.titleLabel.text isEqualToString:@"v"] ) {
        
        [self keyboardHide];
    }
    //implement character rubout 
    else if ([keyletters.titleLabel.text isEqualToString:@"xx"] ) {
        if (whichTextField ==1 ) { 
                 if (functionText.text.length < 1) { }
                 else functionText.text = [functionText.text substringToIndex:functionText.text.length-1];
                    }
        else {
            if (yTextfield.text.length < 1) { }
            else  yTextfield.text = [yTextfield.text substringToIndex:yTextfield.text.length-1];
            }
    }
    else {
        //All other characters just add them to the string 
        if ( whichTextField == 2 ){
            yTextfield.text = [yTextfield.text stringByAppendingString:NSLocalizedString(keyletters.titleLabel.text, nil)];
                NSLog(@"ytext%@",yTextfield.text);
        } 
        else {functionText.text = [functionText.text  stringByAppendingString:NSLocalizedString(keyletters.titleLabel.text, nil)]; 
        NSLog(@"functionText%@",functionText.text);}
    }
} //keyPressed

-(void)equalKey{
    CalcLocalize *myCalcLocalized = [[CalcLocalize alloc] init];
    functionText.text=[myCalcLocalized convertLocalToEngNumbers:functionText.text];
    functionText.text=[myCalcLocalized convertEngToLocalNumbers:functionText.text];
    [myCalcLocalized release];
    
}//equalKey

-(void) keyboardShow {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    self.keyboardView.transform = CGAffineTransformIdentity;
    self.keyboardView.frame = CGRectMake(0,285 , 320, 140);
    [UIView commitAnimations];
}

-(void) keyboardHide {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    self.keyboardView.transform = CGAffineTransformIdentity;
    self.keyboardView.frame = CGRectMake(0,680 , 320, 140);
    [UIView commitAnimations];
}



-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == functionText) {
        functionText.inputView = self.keyboardView;
        [functionText resignFirstResponder];
        [self keyboardShow];
        whichTextField = 1;
    }
    else {
        yTextfield.inputView = self.keyboardView;
        [yTextfield resignFirstResponder];
        [self keyboardShow];
        whichTextField = 2;
    } 
    return NO;  // Hide both keyboard and blinking cursor.
}



- (BOOL) enableInputClicksWhenVisible {
    return YES;
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


- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    //Localize the numbers being displayed
    CalcLocalize *myCalcLocalize = [[CalcLocalize alloc] init];
    
    inputFormula.text = [equations objectAtIndex:row];
    //inputFormula.text=[myCalcLocalize convertLocalToEngNumbers:(NSString *) inputFormula.text] ;
        
    switch (row) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 10:
            {
             UILabel *xlabel = [[[UILabel alloc] initWithFrame:CGRectMake(4, 4, 26, 17)] autorelease];
             xlabel.text = @"X=";
             xlabel.backgroundColor =[UIColor blackColor];
             xlabel.textColor = [UIColor whiteColor];
             xlabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];           
             //NOw add it to the parent view 
             [self.view addSubview:xlabel];
             UITextField *xTextField = [[[UITextField alloc] initWithFrame:CGRectMake(20, 0, 40, 25)] autorelease];
             xTextField.text = @"0";
             xTextField.backgroundColor =[UIColor darkGrayColor];
             xTextField.textColor = [UIColor yellowColor];
             xTextField.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
             xTextField.inputView = self.keyboardView;
             //NOw add it to the parent view 
             [self.view addSubview:xTextField];
            }
            
            break;
            
        default:
            break;
    }
    
    
    
    [myCalcLocalize release];
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    return [equations count];
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    //return  [equations objectAtIndex:row];

//}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    //UIView *tempView = (UIView*)view;
    UILabel *textLabel = (UILabel*)view;
    if (!textLabel){
        //tView = [[UILabel alloc] init];
        //tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 265, 40)];
         textLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 1, 265, 38)]autorelease];
    }

    //setup label for each row wiht a formula name 
    textLabel.text = [equations objectAtIndex:row];
    textLabel.textAlignment = UITextAlignmentLeft;
    textLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textColor = [UIColor blueColor];


    return textLabel;
}


// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 257;
    
    return sectionWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    int sectionHight = 40;
    return sectionHight;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Create e UIPicker to hold common equations
    //myPickerView = [[UIPickerView alloc] init];
    //myPickerView.frame = CGRectMake(65,-10, 264,162);
    equations=[[NSArray alloc]initWithObjects:
               @" y=ax+b",
               @" y = sqr(x)",
               @" y = x**3",
               @" y = cos(x)",
               @" y = sin(x)",
               @" y = tan(x)",
               @" y = sec(x)",
               @" f(x)=| x |",
               @" f(x) = e**x",
               @" f(x) = e**-x",
               @" f(x) = ln(x)",
               @" f(x)=ax**2+bx+c",
               @" (x-h)**2+(y-k)**2=r**2",
               @" (x-h)**2/a**2+(y-k)**2/b**2=1",
               @" (x-h)**2/a**2-(y-k)**2/b**2=1",
               nil];
    
    myPickerView=[[UIPickerView alloc] initWithFrame:CGRectMake(60.0, -10.0, 268.0,120.0)];
    myPickerView.delegate = self;
    myPickerView.showsSelectionIndicator = YES;
    [self.view addSubview:myPickerView];
    //set each part of the UIPikcer background to Hiden to control the background.
    //[(UIView*)[[myPickerView subviews] objectAtIndex:0] setHidden:YES];
    //[(UIView*)[[myPickerView subviews] objectAtIndex:10] setHidden:YES];
    // Create the textfeild to fill the 
    inputFormula = [[UITextField alloc] initWithFrame:CGRectMake(60,136, 260,30)];
    inputFormula.borderStyle = UITextBorderStyleNone ;
    inputFormula.textColor = [UIColor yellowColor];
    inputFormula.backgroundColor = [UIColor grayColor];
    //inputFormula.layer.cornerRadius=8.0f;
    inputFormula.layer.masksToBounds=YES;
    inputFormula.layer.borderColor=[[UIColor yellowColor]CGColor];
    inputFormula.layer.borderWidth= 2.0f;

    
    inputFormula.clearButtonMode = UITextFieldViewModeWhileEditing;
    inputFormula.delegate = self;
    inputFormula.text = [equations objectAtIndex:0];
    [self.view addSubview:inputFormula];
    
   
    // Do any additional setup after loading the view from its nib.
    // graph = [[CPTXYGraph alloc] initWithFrame: self.view.bounds];
    graph = [[CPTXYGraph alloc] initWithFrame: CGRectMake(0, 0, 320, 294)];
    
    CPTGraphHostingView *hostingView = (CPTGraphHostingView *)[self.view viewWithTag:88];
    hostingView.hostedGraph = graph;
    
    hostingView.backgroundColor = [UIColor blackColor];
    graph.paddingLeft = 1.0;
    graph.paddingTop = 2.0;
    graph.paddingRight = 1.0;
    graph.paddingBottom = 2.0;
    graph.plotAreaFrame.paddingLeft = 5.0;
    graph.plotAreaFrame.paddingBottom = 5.0;

    [graph applyTheme:[CPTTheme themeNamed:kCPTDarkGradientTheme]];
   
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-6)
                                                    length:CPTDecimalFromFloat(12)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-5)
                                                    length:CPTDecimalFromFloat(20)];
    
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    plotSpace.allowsUserInteraction = YES;
    
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.lineColor = [CPTColor whiteColor];
    //lineStyle.lineColor = [CPTColor blackColor];
    graph.plotAreaFrame.borderLineStyle = lineStyle;
    lineStyle.lineWidth = 2.0f;
    // style the graph with white text and lines
    //CPTTextStyle *whiteText = [CPTTextStyle textStyle];
    //whiteText.color = [CPTColor whiteColor];   
    
    CPTMutableLineStyle *majorGridLineStyle = [CPTMutableLineStyle lineStyle];
    majorGridLineStyle.lineWidth = 0.75;
    majorGridLineStyle.lineColor = [CPTColor yellowColor];
    
    CPTMutableLineStyle *minorGridLineStyle = [CPTMutableLineStyle lineStyle];
    minorGridLineStyle.lineWidth = 0.25;
    minorGridLineStyle.lineColor = [CPTColor yellowColor];
	
    // Create a text style that we will use for the axis labels.
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.fontName = @"Helvetica";
    textStyle.fontSize = 14;
    textStyle.color = [CPTColor whiteColor];
    
    axisSet.xAxis.title = @"f(X)";
    axisSet.xAxis.titleOffset = 30.0f;
    axisSet.xAxis.majorIntervalLength = [[NSNumber numberWithInt:5] decimalValue];
    axisSet.xAxis.minorTicksPerInterval = 6;
    axisSet.xAxis.majorTickLineStyle = lineStyle;
    axisSet.xAxis.minorTickLineStyle = lineStyle;
    axisSet.xAxis.axisLineStyle = lineStyle;
    axisSet.xAxis.minorTickLength = 5.0f;
    axisSet.xAxis.majorTickLength = 7.0f;
    axisSet.xAxis.labelOffset = 3.0f;
    axisSet.xAxis.titleTextStyle = textStyle;
    axisSet.xAxis.labelTextStyle = textStyle;
    //axisSet.xAxis.majorGridLineStyle = majorGridLineStyle;
    axisSet.xAxis.minorGridLineStyle = minorGridLineStyle;
    
   // axisSet.xAxis.majorGridLineStyle =
   // axisSet.xAxis.minorGridLineStyle =

    axisSet.yAxis.title = @"f(Y)";
    axisSet.yAxis.titleOffset = 120.0f;
    axisSet.yAxis.majorIntervalLength = [[NSNumber numberWithInt:5] decimalValue];
    axisSet.yAxis.minorTicksPerInterval = 6;
    axisSet.yAxis.majorTickLineStyle = lineStyle;
    axisSet.yAxis.minorTickLineStyle = lineStyle;
    axisSet.yAxis.axisLineStyle = lineStyle;
    axisSet.yAxis.minorTickLength = 5.0f;
    axisSet.yAxis.majorTickLength = 7.0f;
    axisSet.yAxis.labelOffset = 3.0f;
    axisSet.yAxis.titleTextStyle = textStyle;
    axisSet.yAxis.labelTextStyle = textStyle;
  //  axisSet.yAxis.majorGridLineStyle = majorGridLineStyle;
    axisSet.yAxis.minorGridLineStyle = minorGridLineStyle;

    
    CPTScatterPlot *xSquaredPlot = [[[CPTScatterPlot alloc] initWithFrame:graph.defaultPlotSpace.accessibilityFrame] autorelease];
    xSquaredPlot.identifier = @"X Squared Plot";
    CPTMutableLineStyle *ls1 = [CPTMutableLineStyle lineStyle];
    ls1.lineWidth = 4.0f;
    ls1.lineColor = [CPTColor redColor];
    xSquaredPlot.dataLineStyle = ls1;
    xSquaredPlot.dataSource = self;
    [graph addPlot:xSquaredPlot];
    
    CPTPlotSymbol *greenCirclePlotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    greenCirclePlotSymbol.fill = [CPTFill fillWithColor:[CPTColor greenColor]];
    greenCirclePlotSymbol.size = CGSizeMake(2.0, 2.0);
    xSquaredPlot.plotSymbol = greenCirclePlotSymbol;  
    
    CPTScatterPlot *xInversePlot = [[[CPTScatterPlot alloc] initWithFrame:graph.defaultPlotSpace.accessibilityFrame] autorelease];
    
    xInversePlot.identifier = @"X Inverse Plot";
    CPTMutableLineStyle *ls2 = [CPTMutableLineStyle lineStyle];
    ls2.lineWidth = 4.0f;
    ls2.lineColor = [CPTColor blueColor];
    xInversePlot.dataLineStyle = ls2;
    xInversePlot.dataSource = self;
    [graph addPlot:xInversePlot];
    
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
    [myPickerView release];
    
} // viewDidLoad


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

-(IBAction) plotFormula{
    NSLog(@"plot the given formula");
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [functionText release];
    [yTextfield release];
    [keyboardView release];
    [equations release];
    [inputFormula release];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //Return YES for supported orientations
    return YES;
        
   // return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    //NSLog(@"What is the orientation: %i", toInterfaceOrientation);
    if ( (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) ||(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) )
    {
        NSLog(@"What is the orientation: %i", toInterfaceOrientation);
        
        PersianCalculatorLandscape *myOwnController = [[[[PersianCalculatorLandscape alloc] init]  initWithNibName:@"PersianCalculatorLandscape" bundle:nil whichTab:1]autorelease];
        NSMutableArray* newArray = [NSMutableArray arrayWithArray:self.tabBarController.viewControllers];
        [newArray replaceObjectAtIndex:1 withObject:myOwnController];
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


-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    return 51;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot
                     field:(NSUInteger)fieldEnum
               recordIndex:(NSUInteger)index
{
    double val = (index/5.0)-5;
    
    if(fieldEnum == CPTScatterPlotFieldX)
    { return [NSNumber numberWithDouble:val]; }
    else
    {
        if(plot.identifier == @"X Squared Plot")
        { return [NSNumber numberWithDouble:val*val]; }
        else
        { return [NSNumber numberWithDouble:1/val]; }
    }
}


@end
