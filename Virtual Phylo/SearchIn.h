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

@interface SearchIn : CCLayer <ItemsScrollerDelegate>{
    CCMenuItemImage *image;
    CCMenuItemImage *picture;
    UITapGestureRecognizer *_doubleTapRecognizer;
    CGPoint tapLocation;
    UITextField* alphabeticMenuField;
    NSMutableArray *movableSprites;
    CCSprite *selSprite;

}

// adds player layer elements/images
-(void) setBackground;

// adds hand with cards inside
- (void) addCardScrollerwithstring:(NSString*)a;

// itemScroller for hand
-(void)itemsScroller:(ItemsScroller *)sender didSelectItemIndex:(int)index;



-(void)testCalling;

-(void) addCardToTablewithstring:(NSString*)a;

@property int selected_card_index;
@property (retain) UITapGestureRecognizer* doubleTapRecognizer;
//@property CGPoint touchLoc;
@property (nonatomic, retain) NSMutableArray* cardsOnTable;
@property (nonatomic, retain) NSMutableArray* cardsOnHand;//@property bool a_dCheck;
@end
