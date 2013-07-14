//
//  PlayerLayerTop.m
//  Virtual Phylo
//
//  Created by Suban K on 2013-07-13.
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

-(void) setBackground
{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    CCSprite *upperPlayerRegion = [CCSprite spriteWithFile: @"playerRegion.png"];
    upperPlayerRegion.position = ccp(winSize.width / 2, 691);
    [self addChild:upperPlayerRegion];
    

    CCSprite *upperPlayerHand = [CCSprite spriteWithFile:@"hand.png"];
    upperPlayerHand.position = ccp(winSize.width / 2, 698);
    [self addChild:upperPlayerHand];
    
    
    CCSprite *upperDeckDiscardPile = [CCSprite spriteWithFile:@"deckdiscardPile.png"];
    upperDeckDiscardPile.position = ccp(964, 698);
    [self addChild:upperDeckDiscardPile];
}

@end
