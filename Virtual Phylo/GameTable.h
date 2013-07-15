//
//  GameTable.h
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-06.
//  Copyright 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCItemsScroller.h"
#import "CCSelectableItem.h"
#import "PlayerLayerBot.h"
#import "PlayerLayerTop.h"

// GamePlaying Screen
// The interface where two players use their decks to play the Phylo Trading Card Game

// GameTable is the Layer that consists of the cards in play, or the Playing Field
@interface GameTable : CCLayer<CCItemsScrollerDelegate>{
    
    // Player 1's hand/discard/draw pile space
    PlayerLayerBot *pBot;
    
    // Player 2's hand/discard/draw pile space
    PlayerLayerTop *pTop;
    
    CCSprite *background;
    
    // keeps track of which sprite is selected by touch, so that it can be moved
    CCSprite *selSprite;
    
    // an array of all movable sprites
    NSMutableArray *movableSprites;
}

@property (nonatomic, retain) PlayerLayerBot *pBot;
@property (nonatomic, retain) PlayerLayerTop *pTop;
//  <CCItemsScrollerDelegate>
+(CCScene *) scene;

// adds card elements to layer
- (void) addSprites;

// adds background to layer
- (void) setBackground;

// adds hand, a scrollable set of cards to each player's layer
- (void)itemsScroller:(CCItemsScroller *)sender didSelectItemIndex:(int)index;

// keeps track of which sprite is being touched
- (void)selectSpriteForTouch:(CGPoint)touchLocation;

// allows the interface to detect touch, and send coordinates where the touch is happening
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event;

// send coordinates for translation of GameTable layer/playing field
- (CGPoint)boundLayerPos:(CGPoint)newPos;

// translate the playing field
- (void)panForTranslation:(CGPoint)translation;

// tells the interface what to do once object is touched
    // if playing field is touched, move the whole GameTable layer
    // if sprite is touched, only move sprite
- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event;



@end
