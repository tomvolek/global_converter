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
            graph,
            currentPlot,
            yTextfield,
            inputFormula,
            keyboardView,
            x1label,
            x2label,
            x3label,
            x4label,
            x5label,
            x6label,
            y1TextField,
            y2TextField,
            y3TextField,
            y4TextField,
            y5TextField,
            y6TextField,
            myPickerView;


bool soundFlag;
// flag to test which UITextField is receiving input
int whichTextField=0;
int rowSelected =0;

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
       
            //Test which fucntion is selected and then calculate teh result  
            if (rowSelected ==0 )  // y=ax+b
            {
                double myresult ;
                myresult = [y1TextField.text doubleValue]  * [y2TextField.text doubleValue] + [y3TextField.text doubleValue];
                inputFormula.text =  [NSString stringWithFormat:@"%f",myresult ] ; 
            }
            else if(rowSelected ==1) 
            {
                double myresult ;
                myresult = sqrt([y1TextField.text doubleValue]) ;
                NSLog(@"y1%@",y1TextField.text);
                //inputFormula.text =  [NSString stringWithFormat:@"%d",(int)myresult ] ; 
                inputFormula.text =  [NSString stringWithFormat:@"%f",myresult ] ;
            }
            else if(rowSelected ==2) 
            {
                double myresult ;
                myresult = pow([y1TextField.text doubleValue],3) ;
                inputFormula.text =  [NSString stringWithFormat:@"%f",myresult ] ; 
            }
            else if(rowSelected ==3) 
            {
                double myresult ;
                myresult = cos([y1TextField.text doubleValue]) ;
                inputFormula.text =  [NSString stringWithFormat:@"%f",myresult ] ; 
            }
            else if(rowSelected ==4) 
            {
                double myresult ;
                myresult = sin([y1TextField.text doubleValue]) ;
                inputFormula.text =  [NSString stringWithFormat:@"%f",myresult ] ; 
            }
            else if(rowSelected ==5) 
            {
                double myresult ;
                myresult = tan([y1TextField.text doubleValue]) ;
                inputFormula.text =  [NSString stringWithFormat:@"%f",myresult ] ; 
            }
            else if(rowSelected ==6) 
            {
                double myresult ;
                myresult =  1/cos([y1TextField.text doubleValue]) ;
                inputFormula.text =  [NSString stringWithFormat:@"%f",myresult ] ; 
            }
            else if(rowSelected ==7) 
            {
                double myresult ;
                myresult = abs([y1TextField.text doubleValue]) ;
                inputFormula.text =  [NSString stringWithFormat:@"%f",myresult ] ; 
            }
            else if(rowSelected ==7) 
            {
                double myresult ;
                myresult = pow(2.71828182845904523536028747135266250,[y1TextField.text doubleValue]) ;
                inputFormula.text =  [NSString stringWithFormat:@"%f",myresult ] ; 
            }
            else if(rowSelected ==8) 
            {
                double myresult ;
                myresult = 1/ pow(2.71828182845904523536028747135266250,[y1TextField.text doubleValue]) ;
                inputFormula.text =  [NSString stringWithFormat:@"%f",myresult ] ; 
            }
            else if(rowSelected ==9) 
            {
                double myresult ;
                myresult = log ([y1TextField.text doubleValue]) ;
                inputFormula.text =  [NSString stringWithFormat:@"%f",myresult ] ; 
            }
            else if(rowSelected ==10) 
            {
                double myresult ;
                myresult = [y2TextField.text doubleValue] * pow([y1TextField.text doubleValue],2) + ([y3TextField.text doubleValue] * [y2TextField.text doubleValue]) + [y4TextField.text doubleValue] ;
                inputFormula.text =  [NSString stringWithFormat:@"%f",myresult ] ; 
            }
            else if(rowSelected ==11) 
            {
                double myresult ;
                myresult = pow(([y1TextField.text doubleValue]-[y2TextField.text doubleValue] ),2) + pow(([y3TextField.text doubleValue]-[y4TextField.text doubleValue] ),2) ;
                inputFormula.text =  [NSString stringWithFormat:@"%f",myresult ] ; 
            }
            
            
            [self equalKey];
        
    } 
    else if ([keyletters.titleLabel.text isEqualToString:@"C"] ) {
        if ( whichTextField == 1 ){ y1TextField.text =@"" ;}
        else if ( whichTextField == 2 ){ y2TextField.text =@"" ;}
        else if ( whichTextField == 3 ){ y3TextField.text =@"" ;}
        else if ( whichTextField == 4 ){ y4TextField.text =@"" ;}
        else if ( whichTextField == 5 ){ y5TextField.text =@"" ;}
        else if ( whichTextField == 6 ){ y6TextField.text =@"" ;}
    }
    else if ([keyletters.titleLabel.text isEqualToString:@"v"] ) {
        
        [self keyboardHide];
    }
    //implement character rubout 
    else if ([keyletters.titleLabel.text isEqualToString:@"xx"] ) {
        if (whichTextField ==1 ) { 
                 if (y1TextField.text.length < 1) { }
                 else y1TextField.text = [y1TextField.text substringToIndex:y1TextField.text.length-1];
                }
        else if (whichTextField ==2 ) { 
            if (y2TextField.text.length < 1) { }
            else y2TextField.text = [y2TextField.text substringToIndex:y2TextField.text.length-1];
        }
        else if (whichTextField ==3 ) { 
            if (y3TextField.text.length < 1) { }
            else y3TextField.text = [y3TextField.text substringToIndex:y3TextField.text.length-1];
        }
        else if (whichTextField ==4 ) { 
            if (y4TextField.text.length < 1) { }
            else y4TextField.text = [y4TextField.text substringToIndex:y4TextField.text.length-1];
        }
        else if (whichTextField ==5 ) { 
            if (y5TextField.text.length < 1) { }
            else y5TextField.text = [y5TextField.text substringToIndex:y5TextField.text.length-1];
        }
        else if (whichTextField ==6 ) { 
            if (y6TextField.text.length < 1) { }
            else y6TextField.text = [y6TextField.text substringToIndex:y6TextField.text.length-1];
        }
    }
    else {
        //All other characters just add them to the string 
        if ( whichTextField == 1 ){
            y1TextField.text = [y1TextField.text stringByAppendingString:NSLocalizedString(keyletters.titleLabel.text, nil)];
              
        } 
        else if ( whichTextField == 2 ){
            y2TextField.text = [y2TextField.text stringByAppendingString:NSLocalizedString(keyletters.titleLabel.text, nil)];
            
        }
        else if ( whichTextField == 3 ){
            y3TextField.text = [y3TextField.text stringByAppendingString:NSLocalizedString(keyletters.titleLabel.text, nil)];
            
            
        }
        else if ( whichTextField == 4 ){
            y4TextField.text = [y4TextField.text stringByAppendingString:NSLocalizedString(keyletters.titleLabel.text, nil)];
            
        }
        else if ( whichTextField == 5 ){
            y5TextField.text = [y5TextField.text stringByAppendingString:NSLocalizedString(keyletters.titleLabel.text, nil)];
            
        }
        else if ( whichTextField == 6 ){
            y6TextField.text = [y6TextField.text stringByAppendingString:NSLocalizedString(keyletters.titleLabel.text, nil)];
            
        }
       
    }
} //keyPressed

-(void)equalKey{
    NSString *graphName;
    if (rowSelected == 0){ 
        graphName = @"X ax+b Plot";
        if (currentPlot) {
            [graph removePlot:currentPlot];
            currentPlot = nil;
        }
        else {}
    }
    
    if (rowSelected == 1){ 
        graphName = @"X Sqr Plot";
        if (currentPlot) {
            [graph removePlot:currentPlot];
            currentPlot = nil;
        }
        else {}
    }
    if (rowSelected == 2){ 
        graphName = @"X Cube Plot";
        if (currentPlot) {
            [graph removePlot:currentPlot];
            currentPlot = nil;
        }
        else {}
    } 
    if (rowSelected == 3){ 
        graphName = @"X Cos Plot";
        if (currentPlot) {
            [graph removePlot:currentPlot];
            currentPlot = nil;
        }
        else {}
    }
    if (rowSelected == 4){ 
        graphName = @"X Sin Plot";
        if (currentPlot) {
            [graph removePlot:currentPlot];
            currentPlot = nil;
        }
        else {}
    }
    if (rowSelected == 5){ 
        graphName = @"X Tan Plot";
        if (currentPlot) {
            [graph removePlot:currentPlot];
            currentPlot = nil;
        }
        else {}
    }
    if (rowSelected == 6){ 
        graphName = @"X Sec Plot";
        if (currentPlot) {
            [graph removePlot:currentPlot];
            currentPlot = nil;
        }
        else {}
    }
    if (rowSelected == 7){ 
        graphName = @"X Abs Plot";
        if (currentPlot) {
            [graph removePlot:currentPlot];
            currentPlot = nil;
        }
        else {}
    } 
    if (rowSelected == 8){ 
        graphName = @"X E**x Plot";
        if (currentPlot) {
            [graph removePlot:currentPlot];
            currentPlot = nil;
        }
        else {}
    }
    if (rowSelected == 9){ 
        graphName = @"X E**-x Plot";
        if (currentPlot) {
            [graph removePlot:currentPlot];
            currentPlot = nil;
        }
        else {}
    }
    if (rowSelected == 10){ 
        graphName = @"X Ln(x) Plot";
        if (currentPlot) {
            [graph removePlot:currentPlot];
            currentPlot = nil;
        }
        else {}
    }
    
    
    CPTScatterPlot *squarePlot = [[[CPTScatterPlot alloc] initWithFrame:graph.defaultPlotSpace.accessibilityFrame] autorelease];
    self.currentPlot = squarePlot ;
    currentPlot.identifier = graphName;
    CPTMutableLineStyle *ls2 = [CPTMutableLineStyle lineStyle];
    ls2.lineWidth = 4.0f;
    ls2.lineColor = [CPTColor blueColor];
    currentPlot.dataLineStyle = ls2;
    currentPlot.dataSource = self;
    [graph addPlot:currentPlot];
    
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
        whichTextField = 0;
    }
    else {
        if (textField ==  y1TextField) { 
            whichTextField = 1; 
            y1TextField.inputView = self.keyboardView;
            [y1TextField resignFirstResponder];
            } 
        else if (textField ==  y2TextField) {
            whichTextField = 2; 
            y2TextField.inputView = self.keyboardView;
            [y2TextField resignFirstResponder];
            }
        else if (textField ==  y3TextField) { 
            whichTextField = 3; 
            y3TextField.inputView = self.keyboardView; 
            [y3TextField resignFirstResponder];
             }
        else if (textField ==  y4TextField) { 
            whichTextField = 4;
            y4TextField.inputView = self.keyboardView;
            [y4TextField resignFirstResponder];
             }
        else if (textField ==  y5TextField) { 
            whichTextField = 5; 
            y5TextField.inputView = self.keyboardView;
            [y5TextField resignFirstResponder];
            }
        else if (textField ==  y6TextField) { whichTextField = 6;
            y6TextField.inputView = self.keyboardView;
            [y6TextField resignFirstResponder];
            }
        [self keyboardShow];
    
    } 
    return NO;  // Hide both defalt keyboard and blinking cursor.
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
    
    [x1label     setHidden:TRUE];
    [x2label     setHidden:TRUE];
    [x3label     setHidden:TRUE];
    [x4label     setHidden:TRUE];
    [x5label     setHidden:TRUE];
    [x6label     setHidden:TRUE];
    [y1TextField setHidden:TRUE ];
    [y2TextField setHidden:TRUE ];
    [y3TextField setHidden:TRUE ];
    [y4TextField setHidden:TRUE ];
    [y5TextField setHidden:TRUE ];
    [y6TextField setHidden:TRUE ];
    
    inputFormula.text = [equations objectAtIndex:row];
    //inputFormula.text=[myCalcLocalize convertLocalToEngNumbers:(NSString *) inputFormula.text] ;
    
    rowSelected = row;  // which picker is selected, to be used in formula calcualtion. 
        
    switch (row) {
        case 0: {// y=ax+b
            //x1label.text = @"X=";
            x2label.text = @"a=";
            x3label.text = @"b=";
            
            //[x1label     setHidden:FALSE];
            [x2label     setHidden:FALSE];
            [x3label     setHidden:FALSE];
            //[y1TextField setHidden:FALSE ];
            [y2TextField setHidden:FALSE ];
            [y3TextField setHidden:FALSE ];
            [self equalKey];
            
        }    
            break;
        case 1: { // sqr(x)
            // x1label.text = @"X=";
            //[x1label     setHidden:FALSE];
            //[y1TextField setHidden:FALSE ];
            [self equalKey];
            
            }
            break;
        case 2: { // X**3
            //x1label.text = @"X=";
            //[x1label     setHidden:FALSE];
            //[y1TextField setHidden:FALSE ];
             [self equalKey];
            
        }
            break;
        case 3: { // cos(x)
             //x1label.text = @"X=";
            //[x1label     setHidden:FALSE];
            //[y1TextField setHidden:FALSE ];
            [self equalKey];
        }
            break;
        case 4: { // sin(x)
            //x1label.text = @"X=";
            //[x1label     setHidden:FALSE];
            //[y1TextField setHidden:FALSE ];
            [self equalKey];
        }
            break;
        case 5: { // tan(x)
            //x1label.text = @"X=";
            //[x1label     setHidden:FALSE];
            //[y1TextField setHidden:FALSE ];
            [self equalKey];
        }
            break;
        case 6: { // sec(x)
            //x1label.text = @"X=";
            //[x1label     setHidden:FALSE];
            //[y1TextField setHidden:FALSE ];
            [self equalKey];
        }
            break;
        case 7: { // |x|
            //x1label.text = @"X=";
            //[x1label     setHidden:FALSE];
            //[y1TextField setHidden:FALSE ];
            [self equalKey];
        }
            break;
        case 8: { // e**x
            //x1label.text = @"X=";
           // [x1label     setHidden:FALSE];
            //[y1TextField setHidden:FALSE ];
            [self equalKey];
        } 
            break;
        case 9: { // e**-x
            //x1label.text = @"X=";
            //[x1label     setHidden:FALSE];
            //[y1TextField setHidden:FALSE ];
            [self equalKey];
        }
            break;
        case 10: { // ln(x)
            //x1label.text = @"X=";
            //[x1label     setHidden:FALSE];
           // [y1TextField setHidden:FALSE ];
            [self equalKey];
        }
            break;
        case 11: { // ax**2+bx+c
            x1label.text = @"X=";
            [x1label     setHidden:FALSE];
            [y1TextField setHidden:FALSE ];
            
            x2label.text = @"a=";
            [x2label     setHidden:FALSE];
            [y2TextField setHidden:FALSE ];
            
            x3label.text = @"b=";
            [x3label     setHidden:FALSE];
            [y3TextField setHidden:FALSE ];
            
            x4label.text = @"c=";
            [x4label     setHidden:FALSE];
            [y4TextField setHidden:FALSE ];
            
        }
            break;
        case 12: { // (x-h)**2+(y-k)**2=r**2
            x1label.text = @"x=";
            [x1label     setHidden:FALSE];
            [y1TextField setHidden:FALSE ];
            
            x2label.text = @"h=";
            [x2label     setHidden:FALSE];
            [y2TextField setHidden:FALSE ];
            
            x3label.text = @"y=";
            [x3label     setHidden:FALSE];
            [y3TextField setHidden:FALSE ];
            
            x4label.text = @"k=";
            [x4label     setHidden:FALSE];
            [y4TextField setHidden:FALSE ];
            
            x5label.text = @"r=";
            [x5label     setHidden:FALSE];
            [y5TextField setHidden:FALSE ];
            
        }
            break;    
            
            
        case 13: { // (x-h)**2/a**2+(y-k)**2/b**2=1
            
            x1label.text = @"x=";
            [x1label     setHidden:FALSE];
            [y1TextField setHidden:FALSE ];
            
            x2label.text = @"h=";
            [x2label     setHidden:FALSE];
            [y2TextField setHidden:FALSE ];
            
            x3label.text = @"a=";
            [x3label     setHidden:FALSE];
            [y3TextField setHidden:FALSE ];
            
            x4label.text = @"y=";
            [x4label     setHidden:FALSE];
            [y4TextField setHidden:FALSE ];
            
            x5label.text = @"k=";
            [x5label     setHidden:FALSE];
            [y5TextField setHidden:FALSE ];
            
            x6label.text = @"b=";
            [x6label     setHidden:FALSE];
            [y6TextField setHidden:FALSE ];
    
        }
            break;
            
        case 14: { // (x-h)**2/a**2 - (y-k)**2/b**2=1
                        
            x1label.text = @"x=";
            [x1label     setHidden:FALSE];
            [y1TextField setHidden:FALSE ];
            
            x2label.text = @"h=";
            [x2label     setHidden:FALSE];
            [y2TextField setHidden:FALSE ];
            
            x3label.text = @"a=";
            [x3label     setHidden:FALSE];
            [y3TextField setHidden:FALSE ];
            
            x4label.text = @"y=";
            [x4label     setHidden:FALSE];
            [y4TextField setHidden:FALSE ];
            
            x5label.text = @"k=";
            [x5label     setHidden:FALSE];
            [y5TextField setHidden:FALSE ];
            
            x6label.text = @"b=";
            [x6label     setHidden:FALSE];
            [y6TextField setHidden:FALSE ];
            
            
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
   // graph = [[CPTXYGraph alloc] initWithFrame: CGRectMake(0, 0, 320, 294)];
    [self setGraph: [[CPTXYGraph alloc] initWithFrame: CGRectMake(0, 0, 320, 294)]];
    
    CPTGraphHostingView *hostingView = (CPTGraphHostingView *)[self.view viewWithTag:88];
    hostingView.hostedGraph = graph;
    
    hostingView.backgroundColor = [UIColor blackColor];
    [graph setPaddingLeft:1.0];
    [graph setPaddingTop:2.0];
    [graph setPaddingRight: 1.0];
    [graph setPaddingBottom:2.0];
    [[graph plotAreaFrame] setPaddingLeft:5.0];
    [[graph plotAreaFrame] setPaddingBottom:5.0];
    //graph.paddingLeft = 1.0;
    //graph.paddingTop = 2.0;
    //graph.paddingRight = 1.0;
    //graph.paddingBottom = 2.0;
    //graph.plotAreaFrame.paddingLeft = 5.0;
    //graph.plotAreaFrame.paddingBottom = 5.0;

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
   //axisSet.yAxis.majorGridLineStyle = majorGridLineStyle;
    axisSet.yAxis.minorGridLineStyle = minorGridLineStyle;

   /* 
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
    
    */
    
    
    
    
    
    
    
    
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
    
    // create Lable and text field for equation vairables
    x1label = [[[UILabel alloc] initWithFrame:CGRectMake(1, 4, 26, 17)] autorelease];
    x1label.text = @"X=";
    x1label.backgroundColor =[UIColor blackColor];
    x1label.textColor = [UIColor whiteColor];
    x1label.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];           
    //Now add it to the parent view 
    [self.view addSubview:x1label];
    
    
    y1TextField = [[[UITextField alloc] initWithFrame:CGRectMake(20, 0, 38, 24)] autorelease];
    y1TextField.text = @"";
    y1TextField.backgroundColor =[UIColor darkGrayColor];
    y1TextField.textColor = [UIColor yellowColor];
    y1TextField.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    y1TextField.inputView = self.keyboardView;
    y1TextField.delegate = self ;
    //NOw add it to the parent view 
    [self.view addSubview:y1TextField];
    [y1TextField setHidden:FALSE ];
    
    // create Lable and text field for equation vairables
    x2label = [[[UILabel alloc] initWithFrame:CGRectMake(1, 23, 26, 17)] autorelease];
    x2label.text = @"a=";
    x2label.backgroundColor =[UIColor blackColor];
    x2label.textColor = [UIColor whiteColor];
    x2label.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];           
    //Now add it to the parent view 
    [self.view addSubview:x2label];
    
    
    y2TextField = [[[UITextField alloc] initWithFrame:CGRectMake(20, 25, 38, 24)] autorelease];
    y2TextField.text = @"";
    y2TextField.backgroundColor =[UIColor darkGrayColor];
    y2TextField.textColor = [UIColor yellowColor];
    y2TextField.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    y2TextField.inputView = self.keyboardView;
    y2TextField.delegate = self ;
    //NOw add it to the parent view 
    [self.view addSubview:y2TextField];
    [y2TextField setHidden:FALSE ];
    
    
    // create Lable and text field for equation vairables
    x3label = [[[UILabel alloc] initWithFrame:CGRectMake(1, 49, 26, 17)] autorelease];
    x3label.text = @"b=";
    x3label.backgroundColor =[UIColor blackColor];
    x3label.textColor = [UIColor whiteColor];
    x3label.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];           
    //Now add it to the parent view 
    [self.view addSubview:x3label];
    
    
    y3TextField = [[[UITextField alloc] initWithFrame:CGRectMake(20, 50, 38, 24)] autorelease];
    y3TextField.text = @"";
    y3TextField.backgroundColor =[UIColor darkGrayColor];
    y3TextField.textColor = [UIColor yellowColor];
    y3TextField.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    y3TextField.inputView = self.keyboardView;
    y3TextField.delegate = self ;
    //NOw add it to the parent view 
    [self.view addSubview:y3TextField];
    [y3TextField setHidden:FALSE ];
    
    
    // create Lable and text field for equation vairables
    x4label = [[[UILabel alloc] initWithFrame:CGRectMake(1, 72, 17, 23)] autorelease];
    x4label.text = @"b=";
    x4label.backgroundColor =[UIColor blackColor];
    x4label.textColor = [UIColor whiteColor];
    x4label.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];           
    //Now add it to the parent view 
    [self.view addSubview:x4label];
    [x4label setHidden:TRUE ];
    
    
    y4TextField = [[[UITextField alloc] initWithFrame:CGRectMake(20, 75, 38, 24)] autorelease];
    y4TextField.text = @"";
    y4TextField.backgroundColor =[UIColor darkGrayColor];
    y4TextField.textColor = [UIColor yellowColor];
    y4TextField.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    y4TextField.inputView = self.keyboardView;
    y4TextField.delegate = self ;
    //NOw add it to the parent view 
    [self.view addSubview:y4TextField];
    [y4TextField setHidden:TRUE ];
    
    
    // create Lable and text field for equation vairables
    x5label = [[[UILabel alloc] initWithFrame:CGRectMake(1, 96, 17, 23)] autorelease];
    x5label.text = @"c=";
    x5label.backgroundColor =[UIColor blackColor];
    x5label.textColor = [UIColor whiteColor];
    x5label.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];           
    //Now add it to the parent view 
    [self.view addSubview:x5label];
    [x5label setHidden:TRUE ];
    
    
    y5TextField = [[[UITextField alloc] initWithFrame:CGRectMake(20, 100, 38, 24)] autorelease];
    y5TextField.text = @"";
    y5TextField.backgroundColor =[UIColor darkGrayColor];
    y5TextField.textColor = [UIColor yellowColor];
    y5TextField.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    y5TextField.inputView = self.keyboardView;
    y5TextField.delegate = self ;
    //NOw add it to the parent view 
    [self.view addSubview:y5TextField];
    [y5TextField setHidden:TRUE ];
    
    // create Lable and text field for equation vairables
    x6label = [[[UILabel alloc] initWithFrame:CGRectMake(1, 120, 17, 23)] autorelease];
    x6label.text = @"d=";
    x6label.backgroundColor =[UIColor blackColor];
    x6label.textColor = [UIColor whiteColor];
    x6label.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];           
    //Now add it to the parent view 
    [self.view addSubview:x6label];
    [x6label setHidden:TRUE ];
    
    y6TextField = [[[UITextField alloc] initWithFrame:CGRectMake(20, 125, 38, 24)] autorelease];
    y6TextField.text = @"";
    y6TextField.backgroundColor =[UIColor darkGrayColor];
    y6TextField.textColor = [UIColor yellowColor];
    y6TextField.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    y6TextField.inputView = self.keyboardView;
    y6TextField.delegate = self ;
    //NOw add it to the parent view 
    [self.view addSubview:y6TextField];
    [y6TextField setHidden:TRUE ];

    
    //Localize any strings on the views
    [LocalizationHelper localizeView:self.view];
    
} // viewDidLoad

-(IBAction) plotFormula{
    NSLog(@"plot the given formula");
}

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    return 61;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot
                     field:(NSUInteger)fieldEnum
               recordIndex:(NSUInteger)index
{
    double val = (index/5.0)-5;
    
    if(fieldEnum == CPTScatterPlotFieldX)
    { 
        if(plot.identifier == @"X ax+b Plot")
        {  return [NSNumber numberWithDouble:val+val]; }
        
        else {return [NSNumber numberWithDouble:val]; }
    
    }
    else
    {
        if(plot.identifier == @"X Squared Plot")
        { return [NSNumber numberWithDouble:val*val]; } //
        else if(plot.identifier == @"X ax+b Plot")
        {  return [NSNumber numberWithDouble:val * [y2TextField.text doubleValue]+[y3TextField.text doubleValue]]; 
         //return [NSNumber numberWithDouble:val + [y3TextField.text doubleValue]];
        }
        else if(plot.identifier == @"X Sqr Plot")
        {  return [NSNumber numberWithDouble:sqrt(val)]; }
        else if(plot.identifier == @"X Cube Plot")
        {  return [NSNumber numberWithDouble:val*val*val]; }
        else if(plot.identifier == @"X Cos Plot")
        {  return [NSNumber numberWithDouble:cos(val)]; }
        else if(plot.identifier == @"X Sin Plot")
        {  return [NSNumber numberWithDouble:sin(val)]; }
        else if(plot.identifier == @"X Tan Plot")
        {  return [NSNumber numberWithDouble:tan(val)]; }
        else if(plot.identifier == @"X Sec Plot")
        {  return [NSNumber numberWithDouble:1/cos(val)]; }
        else if(plot.identifier == @"X Abs Plot")
        {  return [NSNumber numberWithDouble:abs(val)]; }
        else if(plot.identifier == @"X E**x Plot")
        {  return [NSNumber numberWithDouble:pow(2.71828182845904523536028747135266250,val)]; }
        else if(plot.identifier == @"X E**-x Plot")
        {  return [NSNumber numberWithDouble:1/pow(2.71828182845904523536028747135266250,val)]; }
        else if(plot.identifier == @"X Ln(x) Plot")
        {  return [NSNumber numberWithDouble:log(val)]; }
        else
        { return [NSNumber numberWithDouble:1/val]; }
    }
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
    [functionText release];
    [yTextfield release];
    [keyboardView release];
    [equations release];
    [inputFormula release];
    
    
}

- (void) dealloc
{
    [myPickerView release];
    [super dealloc];
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




@end
