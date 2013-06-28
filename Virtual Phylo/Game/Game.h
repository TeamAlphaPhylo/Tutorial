//
//  Game.h
//  Virtual Phylo
//
//  Created by Suban K on 2013-06-28.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import "CCScene.h"

@interface Game : CCScene
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
@end
