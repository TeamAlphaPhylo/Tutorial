//
//  PlayerLayerTop.m
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-15.
//  Copyright 2013 Group_12. All rights reserved.
//

#import "PlayerLayerTop.h"
#define DEFAULT_DISCARD_INDEX -1
#define TOP_PLAYER_INDEX_TAG_BASE 1000

@implementation PlayerLayerTop
@synthesize hidden;
@synthesize selected_card_index;
@synthesize discard_card_index;
@synthesize cardsOnHand;
@synthesize upperHandScroller;
@synthesize TopHand;


-(id) init
{
    if( (self=[super init]) ) {
        
        NSLog(@"Player Layer Top");
        // (Roger) Add two menu items to let use hide/unhide their hand
        CCMenuItemImage *hide = [CCMenuItemImage itemWithNormalImage:@"arrowSwipeRev.png" selectedImage:@"arrowSwipeRev.png" target:self selector:@selector(hideImagePlayerTop)];
        CCMenuItemImage *unhide = [CCMenuItemImage itemWithNormalImage:@"unHideRev.png" selectedImage:@"unHideRev.png" target:self selector:@selector(hideImagePlayerTop)];
        CCMenu *HidePlayerTop = [CCMenu menuWithItems:hide, unhide, nil];
        // (Roger) Set Positions
        HidePlayerTop.position = ccp(145,695);
        // (Roger) Set Padding
        [HidePlayerTop alignItemsVerticallyWithPadding:30];
        // (Roger) Initialize the properties
        hidden = false;
        selected_card_index = 0;
        discard_card_index = DEFAULT_DISCARD_INDEX;
        cardsOnHand = [[NSMutableArray alloc] init];
        upperHandScroller = nil;
        TopHand = TRUE;
        // (Roger) Add them into the layer
        // (Roger) The library has been slightly modified to meet the requirement
        [self addChild:HidePlayerTop z:2];
        // (Roger) Add hand scroller
        [self addCardScroller];
        // (Roger) Set up background
        [self setBackground];
    }
    return self;
}

- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

-(void) setBackground {
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    // add brown player region background
    CCSprite *upperPlayerRegion = [CCSprite spriteWithFile: @"playerRegion.png"];
    upperPlayerRegion.position = ccp(winSize.width / 2, 694);
    [self addChild:upperPlayerRegion];
    
    // add hand box rect
    CCSprite *upperPlayerHand = [CCSprite spriteWithFile:@"hand.png"];
    upperPlayerHand.position = ccp(548, 698);
    [self addChild:upperPlayerHand];
    
    // add discard pile rect
    CCSprite *upperDeckDiscardPile = [CCSprite spriteWithFile:@"deckdiscardPile.png"];
    upperDeckDiscardPile.position = ccp(970, 698);
    [self addChild:upperDeckDiscardPile];
    
    // add deck pile rect
    CCSprite *upperDeckDrawPile = [CCSprite spriteWithFile:@"deckdiscardPile.png"];
    upperDeckDrawPile.position = ccp(50, 698);
    [self addChild:upperDeckDrawPile];
    
    // add card_back image to deck pile rect
    CCSprite *upperDeckSprite = [CCSprite spriteWithFile:@"card_back.png"];
    upperDeckSprite.position = ccp(50, 698);
    upperDeckSprite.scale = .25;
    [self addChild:upperDeckSprite];
    
}

- (void) addCardScroller {
    NSLog(@"Trying to add CCScroll View.");
    
    // (Roger) First set up a window size holder
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    // (Roger) Setting up an NSMutableArray (To be corporated with CoreData function)
    // (Roger) Storing the Sprite instances
    
    // Horizontal scroller
    for (int i = 0; i < 10; i++) {
        CCSelectableItem *page = [[CCSelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
        
        NSString *card_imageName = [NSString stringWithFormat:@"%d%@", i, @".png"];
       
        CCSprite *image = [CCSprite spriteWithFile:card_imageName];
        // Reverse the image
        image.flipX = YES;
        image.flipY = YES;

        image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
        // (Roger) The card dimensions are 264 * 407 (Width * Height)
        [image setScale: (float) 100 / 407];
        
        image.tag = i + TOP_PLAYER_INDEX_TAG_BASE;
        [page addChild:image];
        
        [cardsOnHand addObject:page];
    }
    
    upperHandScroller = [CCItemsScroller itemsScrollerWithItems:cardsOnHand andOrientation:CCItemsScrollerHorizontal andRect:CGRectMake(186, 648, winSize.width - 300, 155)];
    //    upperHandScoller.delegate = self;
    [self addChild:upperHandScroller z:2];
}

- (void)hideImagePlayerTop
{
    if (!hidden) {
        NSLog(@"Top Player Hide Hand ");
        [self runAction:[CCMoveTo actionWithDuration:0.5 position:ccp(0,117)]];
        hidden = true;
    } else {
        NSLog(@"Top Player Show Hand ");
        [self runAction:[CCMoveTo actionWithDuration:0.5 position:ccp(0,0)]];
        hidden = false;
    }
}

-(void)itemsScroller:(CCItemsScroller *)sender didSelectItemIndex:(int)index{
    NSLog(@"Select Top %d Card", index);
    selected_card_index = index;
}

-(void)addCardtoDiscardPile: (int) cardIndex {
    if(cardIndex < 2000 && cardIndex >= 1000) {
        // (Roger) First to release the previous discard card sprite to save some system resource
        [self releasePreviousDiscardCard];
        
        // (Roger) Create a new card with the specific card index
        NSLog(@"Adding Card to discard pile, card index: %d", cardIndex);
        // (Roger) Get rid of the top player index tag base
        NSString *card_imageName = [NSString stringWithFormat:@"%d%@", cardIndex - TOP_PLAYER_INDEX_TAG_BASE, @".png"];
        CCSprite *card = [CCSprite spriteWithFile:card_imageName];
        
        // (Roger) Set the discard card index
        discard_card_index = cardIndex;
        
        // (Roger) Set up the attribute of the card
        card.flipX = YES;
        card.flipY = YES;
        card.position = CGPointMake(1024-55, 768-71);
        card.tag = TOP_PLAYER_INDEX_TAG_BASE + cardIndex;
        [card setScale: (float) 100 / 407];
        
        // (Roger) Add it into the discard part
        [self addChild:card z:2];
    } else {
        NSLog(@"Data Error: Card Index = %d", cardIndex);
    }
}

- (void)releasePreviousDiscardCard {
    if(discard_card_index != -1) {
        CCSprite *tempCard = (CCSprite*)[self getChildByTag:discard_card_index];
        [self removeChild:tempCard cleanup:YES];
        discard_card_index = DEFAULT_DISCARD_INDEX;
    }
}
@end