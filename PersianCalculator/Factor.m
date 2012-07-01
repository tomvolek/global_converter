//
//  Factor.m
//  PersianCalculatorPro
//
//  Created by volek on 10/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Factor.h"
#import "Expression.h"

#import "Term.h"
#import "Addop.h"

@implementation Factor

@synthesize value;

- (id)initWithSyntaxTree:(CPSyntaxTree *)syntaxTree
{
    self = [self init];
    
    if (nil != self)
    {
        NSArray *components = [syntaxTree children];
        if ([components count] == 1)
        {
            [self setValue:[(Term *)[components objectAtIndex:0] value]];
        }
        else
        {
            Addop *op = (Addop *)[components objectAtIndex:1];
            NSLog(@"What is the middle expression %@", op.value);
            CPKeywordToken *addToken = [CPKeywordToken tokenWithKeyword:@"+"];
            if ([op.value isEqual:addToken])
            {
                NSLog(@"Started executing plus");
                [self setValue:[(Expression *)[components objectAtIndex:0] value] + [(Term *)[components objectAtIndex:2] value]];
            }
            else
            {
                NSLog(@"Started executing minus");
                [self setValue:[(Expression *)[components objectAtIndex:0] value] - [(Term *)[components objectAtIndex:2] value]];
                NSLog(@"Finished executing minus");
            }
        }
    }
    
    return self;
}

- (id)parser:(CPParser *)parser didProduceSyntaxTree:(CPSyntaxTree *)syntaxTree
{
    return [(CPQuotedToken *)[[syntaxTree children] objectAtIndex:0] content];
}

@end