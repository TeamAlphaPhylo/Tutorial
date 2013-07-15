//
//  PlayerLayerTop.m
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-15.
//  Copyright 2013 Group_12. All rights reserved.
//

#import "PlayerLayerTop.h"


@implementation PlayerLayerTop
@synthesize show_hide;
@synthesize selected_card_index;


-(id) init
{
    if( (self=[super init]) ) {
        
        NSLog(@"Player Layer Top");
        // (Roger) Add delegate
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        // (Roger) Add two menu items to let use hide/unhide their hand
        CCMenuItemImage *hide = [CCMenuItemImage itemWithNormalImage:@"arrowSwipeRev.png" selectedImage:@"arrowSwipeRev.png" target:self selector:@selector(hideImagePlayerTop)];
        CCMenuItemImage *unhide = [CCMenuItemImage itemWithNormalImage:@"unHideRev.png" selectedImage:@"unHideRev.png" target:self selector:@selector(hideImagePlayerTop)];
        CCMenu *HidePlayerTop = [CCMenu menuWithItems:hide, unhide, nil];
        // (Roger) Set Positions
        HidePlayerTop.position = ccp(145,695);
        // (Roger) Set Padding
        [HidePlayerTop alignItemsVerticallyWithPadding:30];
        // (Roger) Initialize the properties
        show_hide = false;
        selected_card_index = 0;
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

-(void) setBackground {
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CCSprite *upperPlayerRegion = [CCSprite spriteWithFile: @"playerRegion.png"];
    upperPlayerRegion.position = ccp(winSize.width / 2, 691);
    [self addChild:upperPlayerRegion];
    
    CCSprite *upperPlayerHand = [CCSprite spriteWithFile:@"hand.png"];
    upperPlayerHand.position = ccp(548, 698);
    [self addChild:upperPlayerHand];
    
    CCSprite *upperDeckDiscardPile = [CCSprite spriteWithFile:@"deckdiscardPile.png"];
    upperDeckDiscardPile.position = ccp(964, 698);
    [self addChild:upperDeckDiscardPile];
    
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
        CCSelectableItem *pageTop = [[CCSelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
        
        NSString *card_imageName = [NSString stringWithFormat:@"%d%@", i, @".png"];
       
        CCSprite *image = [CCSprite spriteWithFile:card_imageName];
        image.flipX = YES;
        image.flipY = YES;
        
//        CCMenuItemImage *image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
        
//        image.flipX = YES;
        
        image.position = ccp(pageTop.contentSize.width/2, pageTop.contentSize.height/2);
        // (Roger) The card dimensions are 264 * 407 (Width * Height)
        [image setScale: (float) 100 / 407];
        
        [pageTop addChild:image];
        
        [cardArray addObject:pageTop];
    }
    
    CCItemsScroller *upperHandScoller = [CCItemsScroller itemsScrollerWithItems:cardArray andOrientation:CCItemsScrollerHorizontal andRect:CGRectMake(186, 648, winSize.width - 300, 155)];
    //    upperHandScoller.delegate = self;
    [self addChild:upperHandScoller z:3];
}

- (void)hideImagePlayerTop
{
    if (!show_hide) {
        NSLog(@"Top Player Hide Hand ");
        [self runAction:[CCMoveTo actionWithDuration:0.5 position:ccp(0,110)]];
        show_hide = true;
    } else {
        NSLog(@"Top Player Show Hand ");
        [self runAction:[CCMoveTo actionWithDuration:0.5 position:ccp(0,0)]];
        show_hide = false;
    }
}

-(void)itemsScroller:(CCItemsScroller *)sender didSelectItemIndex:(int)index{
    NSLog(@"Select Top %d Card", index);
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