//
//  MainMenuLayer.h
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-06-29.
//  Copyright 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
// (Roger) import HelloWorldLayer for jumping back
#import "HelloWorldLayer.h"
#import "CCMenuAdvancedTest.h"
#import "MasterCard.h"


// Main Menu Screen
// gives the option to switch between settings, login, and deck screens


@interface MainMenuLayer : CCLayer {
    
}

+(CCScene *) scene;
// adds title image with other necessary images
-(void) setTitle;

// adds left menu UI
-(void) setLeftMenu;

// adds Card of the Day
-(void) setExampleCard;

// adds User Info to Top of Page
-(void)setUserInfo;

// jump back to Login Screen
-(void)jumpToLogin;

// jump to Game Screen
-(void)jumpToGame;

// jump to Deck Screen
-(void)jumpToDeck;

// jump to Settings Screen
-(void)jumpToSettings;



@end
