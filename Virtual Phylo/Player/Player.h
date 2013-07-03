//
//  Player.h
//  Virtual Phylo
//
//  Created by Brandon Wong on 2013-06-26.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject{
    @private
    id player_DrawPile; // a deck object
    id player_DiscardPile; // a deck object
    id player_Hand; // a deck object
    
}

@end
