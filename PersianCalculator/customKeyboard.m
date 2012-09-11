//
//  customKeyboard.m
//  PersianCalculatorPro
//
//  Created by volek on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "customKeyboard.h"
#import <QuartzCore/QuartzCore.h>

@implementation CustomKeyboard

bool soundFlag;

- (id)initWithFrame:(CGRect)frame
{
    //frame = CGRectMake(0,200, 320, 240);    
    //self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       NSArray *screens= [[NSBundle mainBundle]
                          loadNibNamed:@"customKeyboard"
                          owner:self 
                          options:nil] ;
        
        [self release];
        self = [screens objectAtIndex:0];
        self.layer.shadowColor = [[UIColor whiteColor] CGColor];
		self.layer.shadowOffset = CGSizeMake(1.0, 1.0);
		self.layer.shadowOpacity = 0.40;
    }
    // SetUp sound 
    NSString *path = [[NSBundle mainBundle] pathForResource:@"button5" ofType:@"wav"];
    theAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    // now initialize the player 
    theAudio.delegate=self;
    [theAudio prepareToPlay];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    soundFlag= [userDefaults boolForKey:@"audioSwitch"];
    
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"worldMapBackgroud.png"]];

    
    
    return self;
}

- (void)awakeFromNib
{
    // self.title = NSLocalizedString(@"Test", @"");
    //Localize any strings on the views
    [LocalizationHelper localizeView:self];
    
    
}



-(IBAction) keyboardPressed: (id)sender{	
    UIButton  *keyletters = (UIButton*)sender ;
    
    if (soundFlag) {
        [theAudio play];
    }
    
    if(keyletters.tag == 666 )
        keyletters.titleLabel.text= @"xx";
    
  
    // All instances of TestClass will be notified
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"TestNotification" object:self];
    
      [[NSNotificationCenter defaultCenter] postNotificationName:@"TestNotification" object:keyletters ];
    
}


- (void) dealloc
{

    [super dealloc];
}


@end
