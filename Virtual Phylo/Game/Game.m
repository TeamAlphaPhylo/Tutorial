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
	
	// (Roger) Please be careful here, after the copy and paste, remember to change the object type of the layer
    // (Roger) Change the object type to this class (name). Otherwise it will take very long time to debug it.
    // (BUG)	MainMenuLayer *layer = [MainMenuLayer node];
	Game *layer = [Game node];
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
        [self setTitle];
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

- (void) setTitle {
    NSLog(@"Setting up the Title at the top");
    
    // (Roger) Testing on the CoreData function
    CoreData *core = [CoreData sharedCore];
    
    
    // (Roger)create and initialize a Label
    CCLabelTTF *label = [CCLabelTTF labelWithString:core.tempTest fontName:@"Verdana" fontSize:36];
    // ask director for the window size
    CGSize size = [[CCDirector sharedDirector] winSize];
    // (Roger)position the label on the top of the screen
    label.position =  ccp( size.width /2 , 730);
    
    // (Roger) Add black background to the title
    CCSprite *titleBackground = [CCSprite spriteWithFile:@"TopTitleBackGround.png"];
    titleBackground.position = ccp(size.width / 2, 738);
    
    // (Roger) Create a menu to handle the 'Main Menu' request
    CCMenuItemImage *mainMenuBtn = [CCMenuItemImage itemWithNormalImage:@"mainMenu.png" selectedImage:@"mainMenu.png" target:self selector:@selector(jumpToMainMenu)];
    CCMenu *mainMenu = [CCMenu menuWithItems:mainMenuBtn, nil];
    mainMenu.position = ccp(75, 728);
    
    [self addChild:titleBackground];
    [self addChild:mainMenu];
    [self addChild:label];
}

- (void)jumpToMainMenu {
    NSLog(@"Jump back to Main Menu scene");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.5 scene:[MainMenuLayer scene]]];
}

@end
