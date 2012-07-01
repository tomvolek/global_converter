//
//  Addop.m
//  PersianCalculatorPro
//
//  Created by volek on 10/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Addop.h"
#import "Term.h"
#import "Expression.h"

@implementation Addop

@synthesize value;

- (id)initWithSyntaxTree:(CPSyntaxTree *)syntaxTree
{
    self = [self init];
    
    if (nil != self)
    {
        NSArray *components = [syntaxTree children];
        NSLog(@"Count of component is %i", [components count] );
            NSString *op = [components objectAtIndex:0];
        [self setValue:op];
    }
    
    return self;
}

- (id)parser:(CPParser *)parser didProduceSyntaxTree:(CPSyntaxTree *)syntaxTree
{
    return [(CPQuotedToken *)[[syntaxTree children] objectAtIndex:0] content];
}

@end
