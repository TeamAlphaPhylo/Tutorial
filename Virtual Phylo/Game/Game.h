//
//  Game.h
//  Virtual Phylo
//
//  Created by Brandon Wong on 2013-07-03.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MainMenuLayer.h"
#import "CCScrollLayer.h"
#import "GameGuestLogin.h"

// (Roger) Test on the CoreData function
#import "CoreData.h"

// Game Screen
// first screen seen following main_menu --> game
// manages deck choosing for player 1

@interface Game : CCLayer
{
//    @private
//        id game_PlayerA;
//        id game_playerB;
//        id game_playedCardsA; // the cards player A has played on the playing field
//        id game_playedCardsB; // the cards player B has played on the playing field
//        id game_PlayerBarA; // where Player A's hand, draw and discard piles reside
//        id game_PlayerBarB; // where Player B's hand, draw and discard piles reside
//        int game_turnCount;
}

+(CCScene *) scene;

// set title images
- (void) setTitle;

// allow user to switch between decks to choose that were created in deck builder
- (void) deckChooser;

// allow user to choose chosen deck
- (CCMenu*) AddChooseBtn;

// jump to Main Menu Screen
- (void)jumpToMainMenu;

// jump to Guest Login Screen, to allow player 2 to pick his/her deck
- (void)jumpToGuestLogin;

@end
