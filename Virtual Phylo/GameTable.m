//
//  GameTable.m
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-06.
//  Copyright 2013 Group_12. All rights reserved.
//

/*
   (Roger) For the tags of each individual sprite on the table, due to the natural properties of the tag in the CCSprite as well as the UIImageView class, i.e. the tag could only be integers, I suggest that the cards for the host player (a.k.a. the player at the bottom) are with the tag starting from 0 - 999, and for the guest player the card tag is from 1000 - 1999. 
    After the tag numbers have been partitioned, we can use those tags to identify which card belongs to whom, and with the implementation of the paradigm functions, we can easily identify or make any upgrade to the card capacity. (Current capacity is 1000 cards)
 */

// To-do: Movable sprites to be fixed

#import "GameTable.h"
#define DISCARD_ADD 2000
#define DUPLICATE_BASE 10000

@implementation GameTable

@synthesize cardAtDiscardArea;
@synthesize selectedCard;
@synthesize cardsOnTable;
@synthesize startPosition;

@synthesize discardPilePosBottomX;
@synthesize discardPilePosBottomY;

@synthesize discardPilePosTopX;
@synthesize discardPilePosTopY;

@synthesize origin;

@synthesize adjustedTapLoc;

@synthesize duplicateCounts;

@synthesize doubleTapRecognizer = _doubleTapRecognizer;

//// (Roger) Instead use the property, here we use the static variables
//static CardExchangeLayer *cardExchange = nil;
static PlayerLayerBot *pBot = nil;
static PlayerLayerTop *pTop = nil;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    // (Brandon) PlayerLayers act as layers or regions for the players
    PlayerLayerBot *_pBot = [PlayerLayerBot node];
    [scene addChild:_pBot z:1]; // z-index: 1, above the playing field
    _pBot.touchEnabled = YES;
    _pBot.tag = 9996;
    pBot = _pBot;
    
    PlayerLayerTop *_pTop = [PlayerLayerTop node];
    [scene addChild:_pTop z:1]; // z-index: 1
    _pTop.touchEnabled = YES;
    _pTop.tag = 9997;
    pTop = _pTop;
    
//    CardExchangeLayer *_cardExchange = [CardExchangeLayer node];
//    [scene addChild:_cardExchange z:1];
//    _cardExchange.touchEnabled = NO;
//    _cardExchange.tag = 9998;
//    cardExchange = _cardExchange;
    
    
	// 'layer' is an autorelease object.
	GameTable *layer = [GameTable node];
    layer.tag = 9999;
    
	// add layer as a child to scene
	[scene addChild: layer];
    	
	// return the scene
	return scene;
}

-(id) init
{
    if( (self=[super init]) ) {
        // (Roger) Initialize the starting touch point of the card
        startPosition = CGPointMake(0, 0);
        // (Roger) Initialize cardAtDiscardArea to be false
        cardAtDiscardArea = false;
        // (Roger) Initialize the selectedCard to be nil
        selectedCard = nil;
        // (Roger) Initialize the cardOnTable Mutable Array
        cardsOnTable = [[NSMutableArray alloc] init];
                
        discardPilePosBottomX = 5;
        discardPilePosBottomY = 5;
        
        discardPilePosTopX = 5;
        discardPilePosTopY = 614;
        
        adjustedTapLoc.x = 0;
        adjustedTapLoc.y = 0;
        
        origin = CGPointMake(0, 0);
        
        duplicateCounts = 1;
        
        NSLog(@"Game Table Layer Initialization");
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        
        // add components created as children to this Layer (Notice there are added in a specific sequence)
        [self setBackground];
        [self addSprites];
    }
    return self;
}

// (Brandon) add some card sprites to fool around with, use this same means of adding cards to hand?
- (void) addSprites {
//    NSLog(@"%@", [[CoreData sharedCore] tempTest]);
    CGSize winSize = [CCDirector sharedDirector].winSize;
    movableSprites = [[NSMutableArray alloc] init];
    for(int i = 0; i < [[CoreData sharedCore] cardsOnTable].count; i++) {
        int selected_card_index = [[[[CoreData sharedCore] cardsOnTable] objectAtIndex:i] integerValue];
        NSLog(@"%d", selected_card_index);
        NSString *card_imageName = [NSString stringWithFormat:@"%d%@", selected_card_index, @".png"];
        CCSprite *card = [CCSprite spriteWithFile:card_imageName];
        float offsetFraction = ((float)(i+1))/([[CoreData sharedCore] cardsOnTable].count+1);
        card.position = ccp(winSize.width*offsetFraction, winSize.height/2);
        card.scale = 0.4;
        [self addChild:card z:2 tag:i];
        [movableSprites addObject:card];
    }
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

// (Roger) Set up the background
- (void) setBackground {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    NSLog(@"Setting up Game Table Background Image");
    background = [CCSprite spriteWithFile: @"green.jpg"];
    background.rotation = 90.0;
    background.scale = 1.5;
    // (Roger) Set up the position as the center
    background.position = ccp(screenSize.width / 2, screenSize.height / 2);
    [self addChild:background z:-2];
}

// (Roger) Implement the interface requirements
-(void)itemsScroller:(CCItemsScroller *)sender didSelectItemIndex:(int)index{
    NSLog(@"Select Bottom %d Card", index);
}

// (Brandon) keeps track of which sprite is being touched
- (void)selectSpriteForTouch:(CGPoint)touchLocation {
// (Roger) The size of discard card image is 81*120
    CCSprite * newSprite = nil;
    for (CCSprite *sprite in movableSprites) {
        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) {
            NSLog(@"The card has been chosed");
            startPosition = touchLocation;
            selectedCard = sprite;
            newSprite = sprite;
//            [newSprite runAction:[CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:1 scaleX:1.0 scaleY:1.0] rate:10.0]];
            break;
        }
    }
    
    // (Roger) Set other cards at the back of the newly chosen card
    for (CCSprite *sprite in movableSprites) {
        [sprite setZOrder: 2];
    }
    
    [selectedCard setZOrder:3];
    
    if (newSprite != selSprite) {
//        [selSprite stopAllActions];
        selSprite = newSprite;
    }
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    // (Roger) Make sure the touch location is on the game table no in the hand scroller, otherwise it will give exceptions
    bool tapTopPlayerHand = CGRectContainsPoint(CGRectMake(0, 0, 1024, 154), touchLocation);
    bool tapBottomPlayerHand = CGRectContainsPoint(CGRectMake(0, 614, 1024, 768), touchLocation);
    
    bool gameTableCondition = (!tapBottomPlayerHand && !tapTopPlayerHand) || ([pBot hidden] && tapBottomPlayerHand) || ([pTop hidden] && tapTopPlayerHand);
    if(gameTableCondition) {
        NSLog(@"%f, %f", touchLocation.x, touchLocation.y);
        [self selectSpriteForTouch:touchLocation];
        
    }
    return TRUE;
}

- (CGPoint)boundLayerPos:(CGPoint)newPos {
    CGPoint retval = newPos;
    // (Roger) (BUG) Fixed!
    if (retval.x < -277) {
        retval.x = -277;
    }
    if (retval.x > 268) {
        retval.x = 268;
    }
    if (retval.y > 868) {
        retval.y = 868;
    }
    if (retval.y < -880) {
        retval.y = -880;
    }
//    retval.y = MIN(retval.y, background.contentSize.width-winSize.width+300);
//    // (Roger) Modified to match the bound
//    retval.y = MAX(retval.y, -background.contentSize.width+winSize.width-280);
//    retval.x = MIN(retval.x, background.contentSize.height-winSize.height-100);
//    retval.x = MAX(retval.x, -background.contentSize.height+winSize.height+100);
    return retval;
}

- (void)panForTranslation:(CGPoint)translation {
    // (Brandon) if a sprite is touched, move the sprite
    if (selSprite) {
        CGPoint newPos = ccpAdd(selSprite.position, translation);
        selSprite.position = newPos;
        
        // (Brandon) if the background is touched, move the sprite
        // note, this still works if you're touching the hand, because the background is beneath it, needs fixing
    } else if (background) {
        CGPoint newPos = ccpAdd(self.position, translation);
        discardPilePosBottomX = discardPilePosBottomX - translation.x;
        discardPilePosBottomY = discardPilePosBottomY - translation.y;
        discardPilePosTopX = discardPilePosTopX = translation.x;
        discardPilePosTopY = discardPilePosTopY - translation.y;
        origin.x = origin.x - translation.x;
        origin.y = origin.y - translation.y;
        NSLog(@"%f, %f", origin.x, origin.y);
        if (origin.x < -277) {
            origin.x = -277;
        }
        if (origin.x > 268) {
            origin.x = 268;
        }
        if (origin.y > 868) {
            origin.y = 868;
        }
        if (origin.y < -880) {
            origin.y = -880;
        }
        
        if (discardPilePosBottomX < -277) {
            discardPilePosBottomX = -277;
        }
        if (discardPilePosBottomX > 268) {
            discardPilePosBottomX = 268;
        }
        if (discardPilePosBottomY > 868) {
            discardPilePosBottomY = 868;
        }
        if (discardPilePosBottomY < -880) {
            discardPilePosBottomY = -880;
        }
        
        if (discardPilePosTopX < -277 + 1024) {
            discardPilePosTopX = -277 + 1024;
        }
        if (discardPilePosTopX > 268 + 1024) {
            discardPilePosTopX = 268 + 1024;
        }
        if (discardPilePosTopY > 868 + 768) {
            discardPilePosTopY = 868 + 768;
        }
        if (discardPilePosTopY < -880 + 768) {
            discardPilePosTopY = -880 + 768;
        }

        self.position = [self boundLayerPos:newPos];
    }
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    CCSprite *selectedSprite;
    for (CCSprite *sprite in movableSprites) {
        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) {
            selectedSprite = sprite;
            break;
        }
    }

    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);
    [self panForTranslation:translation];
    
    /*
     Example:
     CGRectMake(10,10,8,3);
     
     x - - - - - - - - x (18,13)
     |                 |
     |                 |
     |                 |
     x - - - - - - - - x
     (10,10)
     */
    
    
    
    // (Roger) (BUG) (Exceptions)
    // (Roger) To scale down the card if the card is intended to move further
//    int diffX = startPosition.x - touchLocation.x;
//    int diffY = startPosition.y - touchLocation.y;
//    if (diffX > 20 || diffX < -20 || diffY > 20 || diffY < -20) {
//        [selectedSprite runAction:[CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:1 scaleX:0.4 scaleY:0.4] rate:10.0]];
//    }
    
    if (CGRectContainsPoint(CGRectMake(discardPilePosBottomX, discardPilePosBottomY, 81, 120), touchLocation)) {
        NSLog(@"The card is moving to the discarding area...");
        NSLog(@"%f, %f", touchLocation.x, touchLocation.y);
        cardAtDiscardArea = true;
    } else {
        cardAtDiscardArea = false;
    }
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    // (Roger) Pseudo-code
    /*
        if (the card is moved to the discard pile area) {
            if (the bottom hand is visible) {
                if (cardIndex belongs to the player at the bottom) {
                    Add the card to the discard pile;
                } else {
                    Bounce it back to the origin area;
                }
            } else {
                Keep it here
            }
     */
    
    // (Roger) (BUG) If we move the screen really slow, the discard pile will work, otherwise it won't.
    // (Roger) Maybe there is somthing wrong with the selection of the hand scroller
    if (CGRectContainsPoint(CGRectMake(discardPilePosBottomX, discardPilePosBottomY, 81, 120), touchLocation) && cardAtDiscardArea) {
        int selectedCardIndex = selectedCard.tag;
        NSLog(@"%f, %f", touchLocation.x, touchLocation.y);
        if(![pBot hidden]){
            if(selectedCardIndex < 1000 || selectedCardIndex >= 10000) {
                NSLog(@"The transfer discard card to the discard pile");
                [self removeChild:selectedCard cleanup:YES];
                // (Roger) (Bug) Memory Access Bug
//                [movableSprites removeObject:selectedCard];
                // (Roger) Notify the playerLayerBot to add the card to the discard pile
                PlayerLayerBot* pBot = (PlayerLayerBot*)[self.parent getChildByTag:9996];
                if (selectedCardIndex >= 10000) {
                    while (selectedCardIndex >= 10000) {
                        selectedCardIndex = selectedCardIndex - 10000;
                    }
                    [pBot addCardtoDiscardPile:(selectedCardIndex)];
                } else {
                    [pBot addCardtoDiscardPile:(selectedCardIndex)];
                }
            } else {
                id moveAction = [CCMoveBy actionWithDuration:0.5 position:ccp(startPosition.x - touchLocation.x, startPosition.y - touchLocation.y)];
                [selectedCard runAction: [CCSequence actions: moveAction, nil]];
            }
        }
    }
    NSLog(@"Touch Ended:%@", touch);
}

//- (void)putCardBack: (int)cardIndex {
//    NSLog(@"Making a card");
//    NSString *card_imageName = [NSString stringWithFormat:@"%d%@", cardIndex, @".png"];
//    CCSprite *card = [CCSprite spriteWithFile:card_imageName];
//    card.position = CGPointMake(41, 384);
//    card.tag = cardIndex;
//    [card setScale: 0.4];
//    [self addChild:card];
//    id moveAction = [CCMoveBy actionWithDuration:0.5 position:ccp(startPosition.x - 41, startPosition.y - 384)];
//    [card runAction: [CCSequence actions: moveAction, nil]];
//    [movableSprites addObject:card];
//}

// (Roger) Overriding the onEnter method
-(void)onEnter {
    [super onEnter];
    self.doubleTapRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)] autorelease];
    
    // (Roger) If the user double tap the card, the card will be sent to the card exchange area
    _doubleTapRecognizer.numberOfTapsRequired = 2;
    
    [[[CCDirector sharedDirector] view] addGestureRecognizer:_doubleTapRecognizer];
}

// (Roger) Possibly fail to achieve loose coupling in this kind of stuff
-(void)handleDoubleTap:(UITapGestureRecognizer *)doubleTapRecognizer {
    
    CCLOG(@"Double Tap!");
    CGPoint tapLocation = [doubleTapRecognizer locationInView:doubleTapRecognizer.view];
    // (Roger) Pseudo code
    // The player region for the top and bottom is 1024*154
    /*
        if(the tap location is in the bottom) {
            if(the bottom is not hidden) {
     
            } else {
                tap at the game table area
            }
        } else if (the tap location is at the top) {
            if(the top is not hidden) {
            } else {
                tap at the game table area
            }
        } else (tap at the game table area) {
            
        }
     */
    /*
     (0,0) -------------
        |
        |
     */
    
    
    bool tapTopPlayerHand = CGRectContainsPoint(CGRectMake(0, 0, 1024, 154), tapLocation);
    bool tapBottomPlayerHand = CGRectContainsPoint(CGRectMake(0, 614, 1024, 768), tapLocation);
    
    // (Roger) Maybe it should not use the adjusted coordinate
    adjustedTapLoc.x = tapLocation.x + origin.x;
    adjustedTapLoc.y = 768 - tapLocation.y + origin.y;
    
    
    
    if(tapBottomPlayerHand && ![pBot hidden]) {
        CCLOG(@"Tapped at the bottom!");
            NSLog(@"Adj. Tap Loc X = %f, Adj. Tap Loc Y = %f", adjustedTapLoc.x, adjustedTapLoc.y);
            NSLog(@"Tap Loc X = %f, Adj. Tap Loc Y = %f", tapLocation.x, tapLocation.y);
            int selectedCardIndex = [pBot.lowerHandScroller doubleTap:tapLocation];
            if(selectedCardIndex != -1) {
                CCSelectableItem* itemToBeRemoved = nil;
                NSMutableArray *cardsOnHand = pBot.cardsOnHand;
                itemToBeRemoved = [cardsOnHand objectAtIndex:selectedCardIndex];
                if(itemToBeRemoved != nil) {
                    // (Roger) trap the image tag so it can be added to the game table
//                    CCMenuItemImage* itemImage = nil;
                    int cardIndex = -1;
                    for(int i = 0; i < 1000; i++) {
                        if([itemToBeRemoved getChildByTag:i] != nil) {
                            cardIndex = i;
                            break;
                        }
                    }
                    if(cardIndex != -1) {
                        NSString *card_imageName = [NSString stringWithFormat:@"%d%@", cardIndex, @".png"];
                        CCSprite *card = [CCSprite spriteWithFile:card_imageName];
                        CGSize winSize = [CCDirector sharedDirector].winSize;
                        card.position = ccp(winSize.width / 2, winSize.height/2);
                        card.scale = 0.4;
                        // (Roger) Notice here the duplicate base is added
                        [self addChild:card z:2 tag:cardIndex + duplicateCounts*DUPLICATE_BASE];
                        duplicateCounts++;
                        [movableSprites addObject:card];
                    }
                    [pBot.cardsOnHand removeObject:itemToBeRemoved];
                    [pBot.lowerHandScroller updateItems:cardsOnHand];
                }
            }
    } else if(tapTopPlayerHand && ![pTop hidden]) {
        CCLOG(@"Tapped at the Top!");
        // (Roger) To be implemented
    } else {
        CCLOG(@"Tapped at the game table");
        int spriteTag = -1;
        CCSprite *selectedSprite;
        for (CCSprite *sprite in movableSprites) {
            if (CGRectContainsPoint(sprite.boundingBox, tapLocation)) {
                selectedSprite = sprite;
                spriteTag = selectedSprite.tag;
                break;
            }
        }
        if(spriteTag != -1 && (spriteTag < 1000 || spriteTag >= 10000)) {
            while (spriteTag >= 10000){
                spriteTag = spriteTag - 10000;
            }
            CCSelectableItem *page = [[CCSelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
            
            NSString *card_imageName = [NSString stringWithFormat:@"%d%@", spriteTag, @".png"];
            
            CCMenuItemImage *image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:nil];
            
            image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
            // The card dimensions are 264 * 407 (Width * Height)
            [image setScale: (float) 100 / 407];
            // (Roger) Set up the image tag (Notice the tag here only applies to the bottom player tag)
            image.tag = selectedSprite.tag;
            
            // (Roger) Eliminate the duplicated items
            for (int i = 0; i < 1000; i++) {
                if ([[pBot.cardsOnHand objectAtIndex:i] tag] == image.tag) {
                    image.tag += duplicateCounts * DUPLICATE_BASE;
                    duplicateCounts++;
                    break;
                }
            }
            page.tag = image.tag;
            [page addChild:image];
            
            [pBot.cardsOnHand addObject:page];
            [pBot.lowerHandScroller updateItems:pBot.cardsOnHand];
            [self removeChild:selectedSprite cleanup:YES];
            [movableSprites removeObject:selectedSprite];
            
        } else if(spriteTag != -1 && (selectedSprite.tag >= 1000 && selectedSprite.tag < 2000)) {
            NSLog(@"To Be implemented, top player hand");
        } else {
            
        }
        // (Roger) Don't forget to release the sprite
        
    }
    
    
    
    
    
    //    // (Roger) First the user select one card, and then double tap the card, and the card will be send to the card exchange area
    //    id lastSelectedChild = [self getChildByTag:_lastSelectedIndex];
    //    int childTag = -1;
    //    for (int i = 0; i < 1000; i++) {
    //        id child = [lastSelectedChild getChildByTag:i];
    //        if(child != nil) {
    //            childTag = i;
    //            break;
    //        }
    //    }
    //    // (Roger) The tag we have now is the image tag actually
    //    [self.parent sendToCardExchange: childTag: _lastSelectedIndex];
    
}

@end
