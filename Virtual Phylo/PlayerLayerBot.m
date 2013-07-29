//
//  PlayerLayerTop.m
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-15.
//  Copyright 2013 Group_12. All rights reserved.
//

#import "PlayerLayerBot.h"
#define DEFAULT_DISCARD_INDEX -1
#define BOTTOM_PLAYER_INDEX_TAG_BASE 0


@implementation PlayerLayerBot
@synthesize hidden;
@synthesize selected_card_index;
@synthesize discard_card_index;
@synthesize cardsOnHand;
@synthesize lowerHandScroller;
@synthesize BottomHand;

-(id) init
{
    if( (self=[super init]) ) {
        
        NSLog(@"Player Layer Bot");
        // (Roger) Add two menu items to let use hide/unhide their hand
        CCMenuItemImage *hide = [CCMenuItemImage itemWithNormalImage:@"arrowSwipe.png" selectedImage:@"arrowSwipe.png" target:self selector:@selector(hideImagePlayerBot)];
        CCMenuItemImage *unhide = [CCMenuItemImage itemWithNormalImage:@"unHide.png" selectedImage:@"unHide.png" target:self selector:@selector(hideImagePlayerBot)];
        CCMenu *HidePlayerBot = [CCMenu menuWithItems:unhide, hide, nil];
        // (Roger) Set Positions
        HidePlayerBot.position = ccp(875,75);
        // (Roger) Set Padding
        [HidePlayerBot alignItemsVerticallyWithPadding:30];
        // (Roger) Initialize the properties
        hidden = false;
        selected_card_index = 0;
        discard_card_index = DEFAULT_DISCARD_INDEX;
        cardsOnHand = [[NSMutableArray alloc] init];
        lowerHandScroller = nil;
        BottomHand = TRUE;
        // (Roger) Add them into the layer
        // (Roger) The library has been slightly modified to meet the requirement
        [self addChild:HidePlayerBot z:2];
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
    CCSprite *lowerPlayerRegion = [CCSprite spriteWithFile: @"playerRegion.png"];
    lowerPlayerRegion.position = ccp(winSize.width / 2, 74);
    [self addChild:lowerPlayerRegion];
    
    // add hand box rect
    CCSprite *lowerPlayerHand = [CCSprite spriteWithFile:@"hand.png"];
    lowerPlayerHand.position = ccp(470, 70);
    [self addChild:lowerPlayerHand];
    
    // add discard pile rect
    CCSprite *lowerDeckDiscardPile = [CCSprite spriteWithFile:@"deckdiscardPile.png"];
    lowerDeckDiscardPile.position = ccp(50, 70);
    [self addChild:lowerDeckDiscardPile];
    
    // add deck pile rect
    CCSprite *lowerDeckDrawPile = [CCSprite spriteWithFile:@"deckdiscardPile.png"];
    lowerDeckDrawPile.position = ccp(975, 70);
    [self addChild:lowerDeckDrawPile];
    
    // add card_back image to deck pile rect
    CCMenuItemImage *lowerDeckButton = [CCMenuItemImage itemWithNormalImage:@"small_card_back.png" selectedImage:@"small_card_back.png" target:self selector:@selector(addRandomCard)];
    CCMenu *lowerDeck = [CCMenu menuWithItems:lowerDeckButton, nil];
    lowerDeck.position = ccp(975, 70);
    [self addChild:lowerDeck];
}

- (void) addCardScroller {
    NSLog(@"Trying to add CCScroll View.");
    
    // (Roger) First set up a window size holder
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    // (Roger) Setting up an NSMutableArray (To be corporated with CoreData function)
    // (Roger) Storing the Sprite instances
//    NSMutableArray *cardArray = [NSMutableArray array];
    
    // Horizontal scroller
    // (Roger) Notice the card index with 0 has been eliminated for debugging purpose (nil)
    CoreData *core = [CoreData sharedCore];
    NSMutableArray *deckList = [core getHostPlayerDeckList];
    
    // (Roger) Setting up the bottom player deck
    for (int i = 0; i < deckList.count; i++) {
        NSString *deckName = [deckList objectAtIndex:2*i];
        if ([deckName isEqualToString:core.hostPlayerDeck]) {
            NSArray *deckCardsArray = [deckList objectAtIndex: (2*i + 1)];
            for (int j = 0; j < deckCardsArray.count; j++) {
                int cardIndex = [[[deckList objectAtIndex: (2*i + 1)] objectAtIndex:j] integerValue];
                NSLog(@"Load Card Index = %d", cardIndex);
                NSString *cardFileName = [[NSString alloc] initWithFormat:@"%d%@", cardIndex, @".png"];
                CCSelectableItem *page = [[CCSelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                CCSprite *image = [CCSprite spriteWithFile: cardFileName];
                
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                // The card dimensions are 264 * 407 (Width * Height)
                [image setScale: (float) 100 / 407];
                // (Roger) Set up the image tag (Notice the tag here only applies to the bottom player tag)
                image.tag = cardIndex;
                [page addChild:image];
                
                [cardsOnHand addObject:page];
            }
            // (Roger) Jump out of the for loop
            break;
        }
    }
    lowerHandScroller = [CCItemsScroller itemsScrollerWithItems:cardsOnHand andOrientation:CCItemsScrollerHorizontal andRect:CGRectMake(106, 20, winSize.width - 300, 155)];
    [self addChild:lowerHandScroller z:2];
}

- (void)hideImagePlayerBot
{
    if (!hidden) {
        NSLog(@"Hide Hand ");
        [self runAction:[CCMoveTo actionWithDuration:0.5 position:ccp(0,-110)]];
        hidden = true;
    } else {
        NSLog(@"Show Hand ");
        [self runAction:[CCMoveTo actionWithDuration:0.5 position:ccp(0,0)]];
        hidden = false;
    }
}

-(void)itemsScroller:(CCItemsScroller *)sender didSelectItemIndex:(int)index{
    NSLog(@"Select Bottom %d Card", index);
    selected_card_index = index;
}


-(void)addCardtoDiscardPile: (int) cardIndex {
    if(cardIndex < 1000) {
        // (Roger) First to release the previous discard card sprite to save some system resource
        [self releasePreviousDiscardCard];
        
        // (Roger) Create a new card with the specific card index
        NSLog(@"Adding Card to discard pile, card index: %d", cardIndex);
        NSString *card_imageName = [NSString stringWithFormat:@"%d%@", cardIndex, @".png"];
        CCSprite *card = [CCSprite spriteWithFile:card_imageName];
        
        // (Roger) Set the discard card index
        discard_card_index = cardIndex;
        
        // (Roger) Set up the attribute of the card
        card.position = CGPointMake(50, 71);
        card.tag = BOTTOM_PLAYER_INDEX_TAG_BASE + cardIndex;
        [card setScale: (float) 100 / 407];
        
        // (Roger) Add it into the discard part
        [self addChild:card z:2];
    } else {
        NSLog(@"Data Error");
    }
}

- (void)releasePreviousDiscardCard {
    if(discard_card_index != -1) {
        CCSprite *tempCard = (CCSprite*)[self getChildByTag:discard_card_index];
        [self removeChild:tempCard cleanup:YES];
        discard_card_index = DEFAULT_DISCARD_INDEX;
    }
}

- (void) addRandomCard {
    CCSelectableItem *page = [[CCSelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
    
    int randomIndex = arc4random() % 300;
    NSString *card_imageName = [NSString stringWithFormat:@"%d%@", randomIndex, @".png"];
    
    CCSprite *image = [CCSprite spriteWithFile:card_imageName];
    
    image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
    // The card dimensions are 264 * 407 (Width * Height)
    [image setScale: (float) 100 / 407];
    // (Roger) Set up the image tag (Notice the tag here only applies to the bottom player tag)
    image.tag = randomIndex;
    
    [page addChild:image];
    
    [cardsOnHand addObject:page];
    
    [lowerHandScroller updateItems:cardsOnHand];
}

@end