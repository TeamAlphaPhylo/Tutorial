//
//  PlayerLayerBot.m
//  Virtual Phylo
//
//  Created by Suban K on 2013-07-13.
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

-(void) setBackground {
    
     CGSize winSize = [CCDirector sharedDirector].winSize;
     CCSprite *lowerPlayerRegion = [CCSprite spriteWithFile: @"playerRegion.png"];
     lowerPlayerRegion.position = ccp(winSize.width / 2, 77);
    [self addChild:lowerPlayerRegion];
    
     CCSprite *lowerPlayerHand = [CCSprite spriteWithFile:@"hand.png"];
     lowerPlayerHand.position = ccp(winSize.width / 2, 70);
     [self addChild:lowerPlayerHand];
     
     CCSprite *lowerDeckDiscardPile = [CCSprite spriteWithFile:@"deckdiscardPile.png"];
     lowerDeckDiscardPile.position = ccp(50, 70);
     [self addChild:lowerDeckDiscardPile];
     
}

@end

