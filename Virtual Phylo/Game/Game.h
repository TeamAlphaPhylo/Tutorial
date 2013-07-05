//
//  Game.h
//  Virtual Phylo
//
//  Created by Suban K on 2013-07-03.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCLayer.h"
#import "cocos2d.h"
#import "MainMenuLayer.h"

// (Roger) Test on the CoreData function
#import "CoreData.h"

// (Roger) Commented out "import" argument below due to the redundency
// import HelloWorldLayer for jumping back
//#import "HelloWorldLayer.h"

@interface Game : CCLayer
{
    @private
        id game_PlayerA;
        id game_playerB;
        id game_playedCardsA; // the cards player A has played on the playing field
        id game_playedCardsB; // the cards player B has played on the playing field
        id game_PlayerBarA; // where Player A's hand, draw and discard piles reside
        id game_PlayerBarB; // where Player B's hand, draw and discard piles reside
        int game_turnCount;
}

+(CCScene *) scene;

@end
