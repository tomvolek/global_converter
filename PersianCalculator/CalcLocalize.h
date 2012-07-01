//
//  CalLocalize.h
//  PersianCalculatorPro
//
//  Created by volek on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CalcLocalize : NSObject

-(NSString*) convertLocalToEngNumbers:(NSString *)  localSymbol;
-(NSString*) convertEngToLocalNumbers:(NSString *)  engSymbol;
 
@end
