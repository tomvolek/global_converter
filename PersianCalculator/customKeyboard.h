//
//  customKeyboard.h
//  PersianCalculatorPro
//
//  Created by volek on 12/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface CustomKeyboard : UIView <AVAudioPlayerDelegate> {

    
    AVAudioPlayer       *theAudio;
}

-(IBAction) keyboardPressed: (id)sender;


@end
