//
//  Game.m
//  Virtual Phylo
//
//  Created by Suban K on 2013-07-03.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import "Game.h"

@implementation Game

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainMenuLayer *layer = [MainMenuLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
    if( (self=[super init]) ) {
        
        NSLog(@"Game Layer Initialization");
        
        // add components created as children to this Layer (Notice there are added in a specific sequence)
        [self setBackgroundColour];
        //[self setTitle];
        //[self setLeftMenu];
        //[self setExampleCard];
        //[self setUserInfo];
        
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

- (void) setBackgroundColour {
    NSLog(@"Setting up Background Colour");
    CCLayerColor *bgColour = [CCLayerColor layerWithColor:ccc4(0, 0, 102, 255)];
    [self addChild:bgColour];
}

@end
