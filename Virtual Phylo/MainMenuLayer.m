//
//  MainMenuLayer.m
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-06-29.
//  Copyright 2013 Group_12. All rights reserved.
//

#import "MainMenuLayer.h"
#import "Game.h"

// (Roger) BUG: Missing 226.png, 385.png

@implementation MainMenuLayer

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
    
        NSLog(@"Main Menu Layer Initialization");
        
        // (Roger) Test on the MasterCard initialization
        CoreData *core = [CoreData sharedCore];
        
        
        // add components created as children to this Layer (Notice there are added in a specific sequence)
        [self setBackgroundColour];
        [self setTitle];
        [self setLeftMenu];
        [self setExampleCard];
        [self setUserInfo];
        
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

// (Roger) Set up the background colour
- (void) setBackgroundColour {
    NSLog(@"Setting up Background Colour");
    CCLayerColor *bgColour = [CCLayerColor layerWithColor:ccc4(0, 0, 102, 255)];
    [self addChild:bgColour];
}

// (Roger) Set up the title at the top and miscellaneous
- (void) setTitle {
    NSLog(@"Setting up the Title at the top");
    
    // (Roger)create and initialize a Label
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Main Menu" fontName:@"Verdana" fontSize:36];
    // ask director for the window size
    CGSize size = [[CCDirector sharedDirector] winSize];
    // (Roger)position the label on the top of the screen
    label.position =  ccp( size.width /2 , 730);
    
    // (Roger) Add black background to the title
    CCSprite *titleBackground = [CCSprite spriteWithFile:@"TopTitleBackGround.png"];
    titleBackground.position = ccp(size.width / 2, 738);
    
    // (Roger) Create a menu to handle the 'switch account' request
    CCMenuItemImage *switchAccountBtn = [CCMenuItemImage itemWithNormalImage:@"switchAccount.png" selectedImage:@"switchAccount.png" target:self selector:@selector(jumpToLogin)];
    CCMenu *switchAccount = [CCMenu menuWithItems:switchAccountBtn, nil];
    switchAccount.position = ccp(950, 728);
    
    [self addChild:titleBackground];
    [self addChild:switchAccount];
    [self addChild:label];
}

// (Roger) Set up the menu at the left side (contains 'Game', 'Deck', and 'Settings')
-(void) setLeftMenu {
    NSLog(@"Setting up the main menu at the left side");
    CCMenuItemImage *gameBtn = [CCMenuItemImage itemWithNormalImage:@"gameBtn.png" selectedImage:@"gameBtn.png" target:self selector:@selector(jumpToGame)];
    CCMenuItemImage *deckBtn = [CCMenuItemImage itemWithNormalImage:@"deckBtn.png" selectedImage:@"deckBtn.png" target:self selector:@selector(jumpToDeck)];
    CCMenuItemImage *settingsBtn = [CCMenuItemImage itemWithNormalImage:@"settingsBtn.png" selectedImage:@"settingsBtn.png" target:self selector:@selector(jumpToSettings)];
    CCMenu *leftMenu = [CCMenu menuWithItems: gameBtn, deckBtn, settingsBtn, nil];
    // Setting up the layout and position
    [leftMenu alignItemsVerticallyWithPadding: 100];
    leftMenu.position = ccp(100, 280);
    
    [self addChild: leftMenu];
    
}

// (Roger) Set up the 'Today's Card' Section
-(void) setExampleCard {
    NSLog(@"Setting up the example card at the central area");
    
    // (Roger) Set up the general background
    CCSprite *centralBackground = [CCSprite spriteWithFile:@"cardBackground.png"];
    centralBackground.position = ccp(512, 250);
    
    // (Roger) Set up the label - "Today's Card"
    CCLabelTTF *areaTitle = [CCLabelTTF labelWithString:@"Today's Card" fontName:@"Verdana" fontSize:26];
    areaTitle.position = ccp(512, 480);
    
    // (Roger) Randomly pick up a card as today's card
    // (Roger) Set the max card count as 50, otherwise it will cause exceptions due to the lack of sime cards
    int cardIndex = 0;
    NSLog(@"Choose %d.png as Today's card", cardIndex);
    NSString *cardPath = [NSString stringWithFormat:@"%d%@", cardIndex, @".png"];
    
    CCSprite *exampleCard = [CCSprite spriteWithFile:cardPath];
    exampleCard.position = ccp(512, 230);

    
    [self addChild:centralBackground];
    [self addChild:areaTitle];
    [self addChild:exampleCard];
}

// (Roger) Set up user information field
// TO-DO: Need implementation
-(void)setUserInfo {
    NSLog(@"Setting up the user info bar below the top title");
    CCLabelTTF *tempTitle = [CCLabelTTF labelWithString:@"To-Do: User Info Fetching and Display" fontName:@"Verdana" fontSize:46];
    tempTitle.position = ccp(512, 600);
    [self addChild:tempTitle];
    NSLog(@"bar done");

}

// (Roger) Set up a button jumping back to log in screen (log out and/or relogging in)
// TO-DO: Log out function and Main function
- (void)jumpToLogin {
    NSLog(@"Jump back to Login scene");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.5 scene:[HelloWorldLayer scene] ]];
}

// (Roger) Set methods to jump to different scenes
- (void)jumpToGame {
    NSLog(@"Jump to Game scene");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.5 scene:[Game scene]]];
}
- (void)jumpToDeck {
    // TO-DO: To be implemented
}
- (void)jumpToSettings {
    // TO-DO: To be implemented
}
@end
