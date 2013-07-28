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
//        CoreData *core = [CoreData sharedCore];
        
        
        // add components created as children to this Layer (Notice there are added in a specific sequence)
        [self setBackground];
        [self setTitle];
        [self setLeftMenu];
        [self setExampleCard];
        [self setUserInfo];
        [self setLinks];
        [self setStat];
        
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

//// (Roger) Set up the background colour
//- (void) setBackgroundColour {
//    NSLog(@"Setting up Background Colour");
//    CCLayerColor *bgColour = [CCLayerColor layerWithColor:ccc4(0, 0, 102, 255)];
//    [self addChild:bgColour];
//}
- (void) setBackground {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    NSLog(@"Setting up Game Table Background Image");
    background = [CCSprite spriteWithFile: @"green2.png"];
    background.scale = 1.1;
    // (Roger) Set up the position as the center
    background.position = ccp(screenSize.width / 2, screenSize.height / 2);
    CCSprite *topBar = [CCSprite spriteWithFile:@"topRect.png"];
    topBar.position = CGPointMake(screenSize.width/2 + 5, 730);
    CCSprite *botBar = [CCSprite spriteWithFile:@"botRect.png"];
    botBar.position = CGPointMake(screenSize.width/2 + 5, 13);
    CCSprite *teamMembers = [CCSprite spriteWithFile:@"text_teamAlpha.png"];
    teamMembers.position = CGPointMake(678, 13);
    [self addChild:topBar];
    [self addChild:botBar];
    [self addChild:teamMembers];
    [self addChild:background z:-2];
}

// (Roger) Set up the title at the top and miscellaneous
- (void) setTitle {
    NSLog(@"Setting up the Title at the top");
    
    // (Roger)create and initialize a Label
    CCSprite *label = [CCSprite spriteWithFile:@"text_mainMenu.png"];
    // ask director for the window size
    CGSize size = [[CCDirector sharedDirector] winSize];
    // (Roger)position the label on the top of the screen
    label.position =  ccp( size.width /2 , 690);
    
    // (Roger) Create a menu to handle the 'switch account' request
    CCMenuItemImage *switchAccountBtn = [CCMenuItemImage itemWithNormalImage:@"text_switchAccount.png" selectedImage:@"text_switchAccount.png" target:self selector:@selector(jumpToLogin)];
    
    CCMenu *switchAccount = [CCMenu menuWithItems:switchAccountBtn, nil];
    switchAccount.position = ccp(122, 725);

    [self addChild:switchAccount];
    [self addChild:label];
}

// (Roger) Set up the menu at the left side (contains 'Game', 'Deck', and 'Settings')
-(void) setLeftMenu {
    NSLog(@"Setting up the main menu at the left side");
    CCMenuItemImage *gameBtn = [CCMenuItemImage itemWithNormalImage:@"text_deckBuilder.png" selectedImage:@"text_deckBuilder.png" target:self selector:@selector(jumpToDeck)];
    CCMenuItemImage *deckBtn = [CCMenuItemImage itemWithNormalImage:@"text_playPhylo.png" selectedImage:@"text_playPhylo.png" target:self selector:@selector(jumpToGame)];
    CCMenuItemImage *settingsBtn = [CCMenuItemImage itemWithNormalImage:@"text_settings.png" selectedImage:@"text_settings.png" target:self selector:@selector(jumpToSettings)];
    CCMenu *leftMenu = [CCMenu menuWithItems: gameBtn, deckBtn, settingsBtn, nil];
    // Setting up the layout and position
    [leftMenu alignItemsVerticallyWithPadding: 100];
    leftMenu.position = ccp(150, 340);
    
    [self addChild: leftMenu];
    
}

// (Roger) Set up the 'Today's Card' Section
-(void) setExampleCard {
    NSLog(@"Setting up the example card at the central area");

    // (Roger) Set up the label - "Today's Card"
    CCSprite *areaTitle = [CCSprite spriteWithFile:@"text_cardOfTheDay.png"];
    areaTitle.position = ccp(512, 580);
    areaTitle.scale = 1.1;
    
    // (Roger) Randomly pick up a card as today's card
    // (Roger) Set the max card count as 50, otherwise it will cause exceptions due to the lack of sime cards
    int cardIndex = arc4random() % 50;
    NSLog(@"Choose %d.png as Today's card", cardIndex);
    NSString *cardPath = [NSString stringWithFormat:@"%d%@", cardIndex, @".png"];
    
    CCSprite *exampleCard = [CCSprite spriteWithFile:cardPath];
    exampleCard.position = ccp(512, 340);
    exampleCard.scale = 1.05;

    [self addChild:areaTitle];
    [self addChild:exampleCard];
}

// (Roger) Set up user information field
// TO-DO: Need implementation
-(void)setUserInfo {
    CCSprite *titleFrame = [CCSprite spriteWithFile:@"topCorner.png"];
    titleFrame.position = ccp(900, 725);
    
    CoreData *core = [CoreData sharedCore];
    CCLabelTTF *username = [CCLabelTTF labelWithString:core.userName fontName:@"Verdana" fontSize:26];
    username.position = titleFrame.position;
    
    [self addChild:titleFrame];
    [self addChild:username];
}

-(void)setLinks {
    CCMenuItemImage *wikiLink = [CCMenuItemImage itemWithNormalImage:@"text_wikipedia.png" selectedImage:@"text_wikipedia.png" target:self selector:nil];
    CCMenu *wikiLinkMenu = [CCMenu menuWithItems:wikiLink, nil];
    wikiLinkMenu.position = ccp(512, 103);
    [self addChild:wikiLinkMenu];
    
    CCMenuItemImage *virtualPhyloWebsite = [CCMenuItemImage itemWithNormalImage:@"text_virtualPhyloWebsite.png" selectedImage:@"text_virtualPhyloWebsite.png" target:self selector:nil];
    CCMenuItemImage *phyloWebsite = [CCMenuItemImage itemWithNormalImage:@"text_phyloWebsite.png" selectedImage:@"text_phyloWebsite.png" target:self selector:nil];
    CCMenu *linkMenu = [CCMenu menuWithItems:phyloWebsite, virtualPhyloWebsite, nil];
    [linkMenu alignItemsVerticallyWithPadding: -7];
    linkMenu.position = ccp(910, 80);
    [self addChild:linkMenu];
}

-(void)setStat {
    CCSprite *statTitle = [CCSprite spriteWithFile:@"text_stat.png"];
    CCSprite *wins = [CCSprite spriteWithFile:@"smallButton.png"];
    CCSprite *losses = [CCSprite spriteWithFile:@"smallButton.png"];
    statTitle.position = ccp(940, 670);
    wins.position = ccp(940, 630);
    losses.position = ccp(940, 590);
    [self addChild:statTitle];
    [self addChild:wins];
    [self addChild:losses];
    CoreData *core = [CoreData sharedCore];
    CCLabelTTF *winStr = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", core.userWin] fontName:@"Verdana" fontSize:16];
    CCLabelTTF *lossStr = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", core.userLoss]  fontName:@"Verdana" fontSize:16];
    winStr.position = wins.position;
    lossStr.position = losses.position;
    [self addChild:winStr];
    [self addChild:lossStr];
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
    NSLog(@"Jump to Settings scene");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.5 scene:[SettingsLayer scene]]];
}
@end
