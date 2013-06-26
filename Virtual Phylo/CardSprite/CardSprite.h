//
//  CardSprite.h
//  Virtual Phylo
//
//  Created by Brandon Wong on 2013-06-26.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import "CCSprite.h"

@interface CardSprite : CCSprite{
    @private
    // Keeps track of which card the sprite is showing, and is a pointer to the card's data
    int cardSprite_CardNo;
    
}

// I want a method that initalizes the CardSprite with the image it should be representing, the (x,y) coordinate it should spawn at, and the width/height it should have.
// - (void)spriteInit;


@end
