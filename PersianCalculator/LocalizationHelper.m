//
//  LocalizationHelper.m
//  PersianCalculatorPro
//
//  Created by volek on 12/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LocalizationHelper.h"
//#import "LocalizationSystem.h"

@implementation LocalizationHelper{}

+ (void) localizeView:(UIView*) view
{
    
    for (UIView* subView in view.subviews)
    {
        if ([subView isKindOfClass:[UIButton class]])
        {
            UIButton* castButton = (UIButton*) subView;
            [castButton setTitle:NSLocalizedString([castButton titleForState:UIControlStateNormal], [castButton titleForState:UIControlStateNormal]) forState:UIControlStateNormal];
            
        }
        else if ([subView isKindOfClass:[UITextField class]])
        {
            UITextField* castField = (UITextField*) subView;
            [castField setPlaceholder:NSLocalizedString(castField.placeholder, castField.placeholder)];
            
        }
        else if ([subView isKindOfClass:[UILabel class]])
        {
            UILabel* castLabel = (UILabel*) subView;
            [castLabel setText:NSLocalizedString(castLabel.text, castLabel.text)];
        }
        else if ([subView isKindOfClass:[UISegmentedControl class]])
        {
            UISegmentedControl* castSC = (UISegmentedControl*) subView;
            for (int index = 0; index < castSC.numberOfSegments; index++)
            {
                NSString* title = [castSC titleForSegmentAtIndex:index];
                [castSC setTitle:NSLocalizedString(title, title) forSegmentAtIndex:index];
            }
        }
        else if ([subView isKindOfClass:[UITabBarController class]])
        {
            NSLog(@"Tabbar controller found!");
        }
        else if ([subView isKindOfClass:[UITabBar class]])
        {
            UITabBar* tabBar = (UITabBar*) subView;
            NSLog(@"Tabbar");
            NSArray* tabBarItems = tabBar.items;
            for (UITabBarItem* item in tabBarItems)
            {
                NSString* title = item.title;
                [item setTitle:NSLocalizedString(title, title)];
                NSLog(@"Tabbar");
            }
            
            continue;
        }
        [self localizeView:subView];
        
    }
    
}

@end
