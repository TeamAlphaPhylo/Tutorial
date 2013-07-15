//
//  PlayerLayerBot.m
//  Virtual Phylo
//
//  Created by Brandon Wong on 2013-07-13.
//  Copyright 2013 Group_12. All rights reserved.
//

#import "PlayerLayerBot.h"


@implementation PlayerLayerBot

-(id) init
{
    if( (self=[super init]) ) {
        
        NSLog(@"Player Layer Bot");
        [self setBackground];

        
    }
    return self;
}

// (Brandon) add main background images
-(void) setBackground {
    
    // add brown player region background
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CCSprite *lowerPlayerRegion = [CCSprite spriteWithFile: @"playerRegion.png"];
    lowerPlayerRegion.position = ccp(winSize.width / 2, 75);
    [self addChild:lowerPlayerRegion];
    
    // add hand box rect
    CCSprite *lowerPlayerHand = [CCSprite spriteWithFile:@"hand.png"];
    lowerPlayerHand.position = ccp(winSize.width / 2 - 50, 70);
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
    CCSprite *lowerDeckSprite = [CCSprite spriteWithFile:@"card_back.png"];
    lowerDeckSprite.position = ccp(975, 70);
    lowerDeckSprite.scale = .25;
    [self addChild:lowerDeckSprite];
    
}

@end

