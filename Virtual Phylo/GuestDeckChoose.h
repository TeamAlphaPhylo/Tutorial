//
//  GuestDeckChoose.h
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-06.
//  Copyright 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MainMenuLayer.h"
#import "CCScrollLayer.h"
#import "GameTable.h"

// GuestDeckChoose Screen
// allows player 2 to pick their deck from their list of created decks

@interface GuestDeckChoose : CCLayer {
    CCSprite* background;
}

+(CCScene *) scene;

// set title elements/images
- (void) setTitle;

// jump to Main Menu Screen
- (void)jumpToMainMenu;

// allow player 2 to switch between decks to choose
- (void) deckChooser;

// allow player to to choose chosen deck
- (CCMenu*) AddChooseBtn: (NSString*) deckName;

// jump to GuestLogin Screen
- (void)jumpToGameTable: (id) sender;

@end
