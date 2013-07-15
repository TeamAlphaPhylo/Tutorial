//
//  PlayerLayerBot.h
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-14.
//  Copyright 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCSelectableItem.h"
#import "CCItemsScroller.h"

// Player Layer
// the layer that shows a players draw pile, discard pile, and hand
// can be hidden from the screen to prevent opposing player from peaking at user's cards



@interface PlayerLayerBot : CCLayer <CCItemsScrollerDelegate>{
    
}

// adds player layer elements/images
-(void) setBackground;

// adds hand with cards inside
-(void) addCardScroller;

// hand hiding functionality, to hide hand from opposing player
-(void)hideImagePlayerBot;

// itemScroller for hand
-(void)itemsScroller:(CCItemsScroller *)sender didSelectItemIndex:(int)index;

// adding card to hand
-(void)testAddingCard;


@property bool show_hide;
@property int selected_card_index;
@end
