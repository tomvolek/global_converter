//
//  PersianParserDelegate.m
//  PersianCalculatorPro
//
//  Created by volek on 10/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PersianParserDelegate.h"

#import "CPNumberToken.h"

@implementation PersianParserDelegate

- (id)parser:(CPParser *)parser didProduceSyntaxTree:(CPSyntaxTree *)syntaxTree
{
    CPRule *r = [syntaxTree rule];
    NSArray *c = [syntaxTree children];
    
    switch ([r tag])
    {
        case 0:
        case 2:
            return [c objectAtIndex:0];
        case 1:
            return [NSNumber numberWithInt:[[c objectAtIndex:0] intValue] + [[c objectAtIndex:2] intValue]];
        case 3:
            return [NSNumber numberWithInt:[[c objectAtIndex:0] intValue] * [[c objectAtIndex:2] intValue]];
        case 4:
            return [(CPNumberToken *)[c objectAtIndex:0] number];
        case 5:
            return [c objectAtIndex:1];
        default:
            return syntaxTree;
    }
}

@end
