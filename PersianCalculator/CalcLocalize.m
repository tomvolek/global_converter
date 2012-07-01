//
//  CalLocalize.m
//  PersianCalculatorPro
//
//  Created by volek on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CalcLocalize.h"

@implementation CalcLocalize



-(NSString*) convertEngToLocalNumbers:(NSString*)result{ 
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


-(NSString*) convertLocalToEngNumbers:(NSString*)result{ 
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



@end
