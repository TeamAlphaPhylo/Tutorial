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
    
}


@end
