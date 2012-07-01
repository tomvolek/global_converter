//
//  Factor.h
//  PersianCalculatorPro
//
//  Created by volek on 10/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreParse.h"

@interface Factor : NSObject <CPParseResult>

@property (readwrite,assign) float value;

@end