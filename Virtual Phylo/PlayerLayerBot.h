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
@class CCItemsScroller;
#import "GameTable.h"
@class GameTable;
#import "ScrollerProtocols.h"

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

-(void)addCardtoDiscardPile: (int) cardIndex;

- (void)releasePreviousDiscardCard;



@property bool hidden;
@property int selected_card_index;
@property int discard_card_index;
@property (nonatomic, retain) NSMutableArray* cardsOnHand;
@property (nonatomic, retain) CCItemsScroller* lowerHandScroller;
@property bool BottomHand;

@end
