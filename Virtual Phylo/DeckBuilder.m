//
//  DeckBuilder.m
//  Virtual Phylo
//
//  Created by Petr Krarkora on 7/13/13.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import "DeckBuilder.h"

@implementation DeckBuilder

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// (Roger) Please be careful here, after the copy and paste, remember to change the object type of the layer
    // (Roger) Change the object type to this class (name). Otherwise it will take very long time to debug it.
    // (BUG)	MainMenuLayer *layer = [MainMenuLayer node];
	DeckBuilder *layer = [DeckBuilder node];
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
        [self listCards];
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

- (void) listCards {
    int lastPositionX = 80;
    int lastPositionY = 650;
    NSLog(@"Listing cards from user deck");
    for (int i = 0; i <= 50; i++) {
        NSString *fileName = [NSString stringWithFormat:@"%d.png", i];
        CCSprite *exampleCard = [CCSprite spriteWithFile:fileName];
        exampleCard.scale = .50;
        exampleCard.position =  ccp(lastPositionX, lastPositionY);
        lastPositionX += 50;
        if (lastPositionX >= 950)
        {
            lastPositionY -= 100;
            lastPositionX = 80;
        }
            
        exampleCard.tag = i;
        [self addChild:exampleCard];
    }
}

- (void)jumpToMainMenu {
    NSLog(@"Jump back to Main Menu scene");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.5 scene:[MainMenuLayer scene]]];
}

// (Roger) Jump to Guest Login Scene
- (void)jumpToGuestLogin {
    NSLog(@"Jump to Guest Login scene");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.5 scene:[GameGuestLogin scene] ]];
}

@end
