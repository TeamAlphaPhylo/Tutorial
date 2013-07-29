//
//  GameTable.m
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-06.
//  Copyright 2013 Group_12. All rights reserved.
//

#import "GameTable.h"


@implementation GameTable

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameTable *layer = [GameTable node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
    if( (self=[super init]) ) {
        
        NSLog(@"Game Table Layer Initialization");
        
        // add components created as children to this Layer (Notice there are added in a specific sequence)
        [self setBackground];
    }
    return self;
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
//    menu.position = ccp(screenSize.width/2, 50);
    NSLog(@"Setting up Game Table Background Image");
    CCSprite *tableBackground = [CCSprite spriteWithFile: @"waterdroplets.png"];
    // (Roger) Set up the position as the center
    tableBackground.position = ccp(screenSize.width / 2, screenSize.height / 2);
    [self addChild:tableBackground];
    
    CCSprite *lowerPlayerRegion = [CCSprite spriteWithFile: @"playerRegion.png"];
    lowerPlayerRegion.position = ccp(screenSize.width / 2, 77);
    [self addChild:lowerPlayerRegion];
    
    CCSprite *upperPlayerRegion = [CCSprite spriteWithFile: @"playerRegion.png"];
    upperPlayerRegion.position = ccp(screenSize.width / 2, 691);
    [self addChild:upperPlayerRegion];
    
    CCSprite *lowerPlayerHand = [CCSprite spriteWithFile:@"hand.png"];
    lowerPlayerHand.position = ccp(screenSize.width / 2, 70);
    [self addChild:lowerPlayerHand];
    
    CCSprite *upperPlayerHand = [CCSprite spriteWithFile:@"hand.png"];
    upperPlayerHand.position = ccp(screenSize.width / 2, 698);
    [self addChild:upperPlayerHand];
    
    CCSprite *lowerDeckDiscardPile = [CCSprite spriteWithFile:@"deckdiscardPile.png"];
    lowerDeckDiscardPile.position = ccp(50, 70);
    [self addChild:lowerDeckDiscardPile];
    
    CCSprite *upperDeckDiscardPile = [CCSprite spriteWithFile:@"deckdiscardPile.png"];
    upperDeckDiscardPile.position = ccp(964, 698);
    [self addChild:upperDeckDiscardPile];
    
    // (Roger) Intend to implement the card deck on the right (to pick the card) as a menu or something
    // (Roger) Those arrows are also going to be done as the menu
    // (Roger) But I don't know how to implement hiding the hand area. (Use Layers ?)
}


@end
