//
//  PlayerLayerTop.m
//  Virtual Phylo
//
//  Created by Brandon Wong on 2013-07-13.
//  Copyright 2013 Group_12. All rights reserved.
//

#import "PlayerLayerTop.h"


@implementation PlayerLayerTop

-(id) init
{
    if( (self=[super init]) ) {
        
        NSLog(@"PlayerLayerTop");
        [self setBackground];
        
    }
    return self;
}

// (Brandon) add main background images
-(void) setBackground
{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    // add brown player region background
    CCSprite *upperPlayerRegion = [CCSprite spriteWithFile: @"playerRegion.png"];
    upperPlayerRegion.position = ccp(winSize.width / 2, 693);
    [self addChild:upperPlayerRegion];
    
    // add hand box rect
    CCSprite *upperPlayerHand = [CCSprite spriteWithFile:@"hand.png"];
    upperPlayerHand.position = ccp(winSize.width / 2 + 50, 698);
    [self addChild:upperPlayerHand];
    
    // add discard pile rect
    CCSprite *upperDeckDiscardPile = [CCSprite spriteWithFile:@"deckdiscardPile.png"];
    upperDeckDiscardPile.position = ccp(975, 698);
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

@end
