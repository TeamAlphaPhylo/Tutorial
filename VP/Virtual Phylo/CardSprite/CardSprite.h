//
//  CardSprite.h
//  Virtual Phylo
//
//  Created by Brandon Wong on 2013-06-26.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import "CCSprite.h"
#import "Card.h"
// (Brandon) CardSprite inherits CCSprite, need to figure out how this works
@interface CardSprite : CCSprite {
    @private
    // Keeps track of which card the sprite is showing, and is a pointer to the card's data
    id *cardSprite_Card;
    
}

// (Roger) To be implemented.
// I want a method that initalizes the CardSprite with the image it should be representing, the (x,y) coordinate it should spawn at, and the width/height it should have, and whether it's vertically flipped or not.

+ (id) spriteWithCard:(int)cardNo atLocation:(int)x andAt:(int)y withWidth:(int)width flip:(BOOL)flip;

// (Brandon) need a method for movement of cards

@end
