//
//  SettingsLayer.h
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-26.
//  Copyright 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MainMenuLayer.h"
#import "CCMenuAdvancedTest.h"

@interface SettingsLayer : CCLayer {
    CCSprite *background;
}

+(CCScene *) scene;
// adds title image with other necessary images
-(void) setTitle;

// adds User Info to Top of Page
-(void)setUserInfo;

// adds the background screen
- (void) setBackground;

// jump to Deck Screen
-(void)jumpToMainMenu;

@end
