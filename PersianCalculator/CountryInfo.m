//
//  CountryInfo.m
//  PersianCalculatorPro
//
//  Created by volek on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CountryInfo.h"

@implementation CountryInfo

@synthesize name,languageCode,currancySymbol,flag;



/*NSString *name;
NSString *languageCode;
UIImage *flag;
NSString *currancySymbol;
float currentExchangeRate;
*/

-(void)initCountryList{
   NSString *filePath = [[NSBundle mainBundle] pathForResource:@"country_data" ofType:@"txt"]; 
    NSString* content = [NSString stringWithContentsOfFile:filePath
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    if (content) {  
        
        //create an arry of object type of a countryInfo
        NSMutableArray *countriesInfoArray = [[[NSMutableArray alloc] init]autorelease];
        CountryInfo *oneCountryInfo = [[CountryInfo alloc] init]; 
        
        // read country names, and their symbol from file 
        NSArray *fileLines = [content componentsSeparatedByString:@"\n"];  
        
        //parse the country file names and extract country symbols and names,adding them to array
        int counter = [fileLines count];
        for (int i=0; i < counter; i++ ){
            oneCountryInfo.currancySymbol = [[fileLines objectAtIndex:i ] substringToIndex:3];
            oneCountryInfo.languageCode = [[fileLines objectAtIndex:i] substringWithRange:NSMakeRange(0,2)];
            oneCountryInfo.name = [[fileLines objectAtIndex:i] substringFromIndex:11];
            [countriesInfoArray addObject:oneCountryInfo];
            
            //NSLog(@"array leemen %@,%@,%@",oneCountryInfo.currancySymbol,oneCountryInfo.languageCode,oneCountryInfo.name);
        }
        
        [oneCountryInfo release];
    }
    
}

-(IBAction)updateCurrentRate{

}

@end
