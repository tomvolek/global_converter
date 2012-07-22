//
//  Currency.h
//  PersianCalculatorPro
//
//  Created by volek on 7/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDCurrencyUnitConverter.h"

@interface Currency : NSObject
{
    UIImage  *imageFlag;
    NSString *countryName;
    NSString *countryABR;
    DDCurrencyUnit positionRelatedToTheClass;
}

@property (nonatomic, retain) UIImage *imageFlag;
@property (nonatomic, retain) NSString *countryName;
@property (nonatomic, retain) NSString *countryABR;
@property (nonatomic) DDCurrencyUnit positionRelatedToTheClass;
@end
