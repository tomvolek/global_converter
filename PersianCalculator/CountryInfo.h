//
//  CountryInfo.h
//  PersianCalculatorPro
//
//  Created by volek on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountryInfo : NSObject{
    
    NSString *name;
    NSString *languageCode;
    UIImage *flag;
    NSString *currancySymbol;
    float currentExchangeRate;
    
}


@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *languageCode;
@property (nonatomic,retain) UIImage  *flag;
@property (nonatomic,retain) NSString *currancySymbol;

-(void)initCountryList;
-(IBAction)updateCurrentRate;

@end
