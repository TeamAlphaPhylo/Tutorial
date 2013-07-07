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

@interface Game : CCLayer
{
    // (Roger) I don't think those private variables are going to be implemented here.
    // (Roger) because there will be several scenes in the Game part
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
@end
