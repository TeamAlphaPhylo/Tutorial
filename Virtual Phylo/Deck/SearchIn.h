//
//  PlayerLayerBot.h
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-14.
//  Copyright 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SelectableItem.h"
#import "ItemsScroller.h"

// Player Layer
// the layer that shows a players draw pile, discard pile, and hand
// can be hidden from the screen to prevent opposing player from peaking at user's cards



@interface SearchIn : CCLayer <ItemsScrollerDelegate>{
//     bool initialCheck;
//     bool a_dCheck;
   // NSMutableArray *cardArray;
    SelectableItem *page;
    CCMenuItemImage *image;
}

// adds player layer elements/images
-(void) setBackground;

// adds hand with cards inside
-(void) addCardScrollerwithboolean1:(BOOL)a andBool2:(BOOL)b andBool3:(BOOL)c;


// itemScroller for hand
-(void)itemsScroller:(ItemsScroller *)sender didSelectItemIndex:(int)index;

// adding card to hand
-(void)testAddingCard;

-(void)testCalling;


@property int selected_card_index;
//@property bool initialCheck;
//@property bool a_dCheck;
@end
