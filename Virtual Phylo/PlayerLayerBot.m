//
//  PlayerLayerTop.m
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-15.
//  Copyright 2013 Group_12. All rights reserved.
//

#import "PlayerLayerBot.h"


@implementation PlayerLayerBot
@synthesize show_hide;
@synthesize selected_card_index;


-(id) init
{
    if( (self=[super init]) ) {
        
        NSLog(@"Player Layer Bot");
        // (Roger) Add delegate
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        // (Roger) Add two menu items to let use hide/unhide their hand
        CCMenuItemImage *hide = [CCMenuItemImage itemWithNormalImage:@"arrowSwipe.png" selectedImage:@"arrowSwipe.png" target:self selector:@selector(hideImagePlayerBot)];
        CCMenuItemImage *unhide = [CCMenuItemImage itemWithNormalImage:@"unHide.png" selectedImage:@"unHide.png" target:self selector:@selector(hideImagePlayerBot)];
        CCMenu *HidePlayerBot = [CCMenu menuWithItems:unhide, hide, nil];
        // (Roger) Set Positions
        HidePlayerBot.position = ccp(875,75);
        // (Roger) Set Padding
        [HidePlayerBot alignItemsVerticallyWithPadding:30];
        // (Roger) Initialize the properties
        show_hide = false;
        selected_card_index = 0;
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

-(void) setBackground {
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CCSprite *lowerPlayerRegion = [CCSprite spriteWithFile: @"playerRegion.png"];
    lowerPlayerRegion.position = ccp(winSize.width / 2, 77);
    [self addChild:lowerPlayerRegion];
    
    CCSprite *lowerPlayerHand = [CCSprite spriteWithFile:@"hand.png"];
    lowerPlayerHand.position = ccp(470, 70);
    [self addChild:lowerPlayerHand];
    
    CCSprite *lowerDeckDiscardPile = [CCSprite spriteWithFile:@"deckdiscardPile.png"];
    lowerDeckDiscardPile.position = ccp(50, 70);
    [self addChild:lowerDeckDiscardPile];
    
}

- (void) addCardScroller {
    NSLog(@"Trying to add CCScroll View.");
    
    // (Roger) First set up a window size holder
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    // (Roger) Setting up an NSMutableArray (To be corporated with CoreData function)
    // (Roger) Storing the Sprite instances
    NSMutableArray *cardArray = [NSMutableArray array];
    
    // Horizontal scroller
    for (int i = 0; i < 50; i++) {
        CCSelectableItem *page = [[CCSelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
        
        NSString *card_imageName = [NSString stringWithFormat:@"%d%@", i, @".png"];        
        
        CCMenuItemImage *image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
        
        image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
        // The card dimensions are 264 * 407 (Width * Height)
        [image setScale: (float) 100 / 407];
        
        [page addChild:image];
        
        [cardArray addObject:page];
    }
    
    CCItemsScroller *lowerHandScoller = [CCItemsScroller itemsScrollerWithItems:cardArray andOrientation:CCItemsScrollerHorizontal andRect:CGRectMake(106, 20, winSize.width - 300, 155)];
    //    lowerHandScoller.delegate = self;
    [self addChild:lowerHandScoller z:3];
}

- (void)hideImagePlayerBot
{
    if (!show_hide) {
        NSLog(@"Hide Hand ");
        [self runAction:[CCMoveTo actionWithDuration:0.5 position:ccp(0,-110)]];
        show_hide = true;
    } else {
        NSLog(@"Show Hand ");
        [self runAction:[CCMoveTo actionWithDuration:0.5 position:ccp(0,0)]];
        show_hide = false;
    }
}

-(void)itemsScroller:(CCItemsScroller *)sender didSelectItemIndex:(int)index{
    NSLog(@"Select Bottom %d Card", index);
    selected_card_index = index;
}

-(void)testAddingCard
{
    NSString *card_imageName = [NSString stringWithFormat:@"%d%@", selected_card_index, @".png"];
    CCSprite *card = [CCSprite spriteWithFile:card_imageName];
    card.scale = 0.4;
    card.position = CGPointMake(500, 500);
    [self addChild:card];
}

@end