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
        
        NSLog(@"Host player Game Deck Choosing Layer Initialization");
        
        // add components created as children to this Layer (Notice there are added in a specific sequence)
        [self setBackground];
        [self setTitle];
        [self setUserInfo];
        [self setStat];
        [self deckChooser];
        
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

- (void) setBackground {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    NSLog(@"(Settings) Setting up Game Table Background Image");
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
    NSLog(@"(Settings) Setting up the Title at the top");
    
    // (Roger)create and initialize a Label
    CCSprite *label = [CCSprite spriteWithFile:@"setting_text.png"];
    // ask director for the window size
    CGSize size = [[CCDirector sharedDirector] winSize];
    // (Roger)position the label on the top of the screen
    label.position =  ccp( size.width /2 , 690);
    
    // (Roger) Create a menu to handle the 'switch account' request
    CCMenuItemImage *switchAccountBtn = [CCMenuItemImage itemWithNormalImage:@"setting_backMenu.png" selectedImage:@"setting_backMenu.png" target:self selector:@selector(jumpToMainMenu)];
    
    CCMenu *switchAccount = [CCMenu menuWithItems:switchAccountBtn, nil];
    switchAccount.position = ccp(122, 725);
    
    [self addChild:switchAccount];
    [self addChild:label];
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
    CCLabelTTF *winStr = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Wins: %d", core.userWin] fontName:@"Verdana" fontSize:16];
    CCLabelTTF *lossStr = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Losses: %d", core.userLoss]  fontName:@"Verdana" fontSize:16];
    winStr.position = wins.position;
    lossStr.position = losses.position;
    [self addChild:winStr];
    [self addChild:lossStr];
}

-(void)setUserInfo {
    CCSprite *titleFrame = [CCSprite spriteWithFile:@"topCorner.png"];
    titleFrame.position = ccp(900, 725);
    
    CoreData *core = [CoreData sharedCore];
    CCLabelTTF *username = [CCLabelTTF labelWithString:core.userName fontName:@"Verdana" fontSize:26];
    username.position = titleFrame.position;
    
    [self addChild:titleFrame];
    [self addChild:username];
}


- (void)jumpToMainMenu {
    NSLog(@"Jump back to Main Menu scene");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.5 scene:[MainMenuLayer scene]]];
}

//- (void) setExampleCard {
//    // (Brandon) eventually, I wanna test out initalizing a CardSprite algorithmically 
//    // CardSprite *exCard;
//}

// (Roger) some of this function components need to be extracted for fetching the deck info and meet encapsulation purpose
- (void) deckChooser {
    // (Roger) get screen size
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    CoreData *core = [CoreData sharedCore];
    NSMutableArray *deckList = [core getHostPlayerDeckList];
    if ([deckList count] % 2 == 1) {
        NSLog(@"Deck List Parsing Error!!! Return.");
        return;
    }
    
    NSMutableArray *overall = [[NSMutableArray alloc] init];

    // (Roger) Fetching the data from the deck list
    int deckListCount = [deckList count] / 2;
    for (int i = 0; i < deckListCount; i++) {
        CCLayer *deck = [[CCLayer alloc] init];
        CCSprite *labelBkg = [CCSprite spriteWithFile:@"deck_name_bkg.png"];
        // (Roger) That will make sure that the deck name will be fetched
        NSString *deckName = [deckList objectAtIndex:2*i];
        CCLabelTTF *label = [CCLabelTTF labelWithString:deckName fontName:@"Arial Rounded MT Bold" fontSize:30];
        label.position =  ccp( screenSize.width /2 , 580);
        labelBkg.position = label.position;
        // (Roger) Add the first card of the deck as the example / coverpage card of the deck
        int firstCardIndex = [[[deckList objectAtIndex: (2*i + 1)] objectAtIndex:0] integerValue];
        NSLog(@"First Card Index = %d", firstCardIndex);
        NSString *coverCardName = [[NSString alloc] initWithFormat:@"%d%@", firstCardIndex, @".png"];
        CCSprite *exampleCard = [CCSprite spriteWithFile:coverCardName];
        exampleCard.position =  ccp( screenSize.width /2 , 325 );
        
        [deck addChild:exampleCard];
        [deck addChild:labelBkg];
        [deck addChild:label];
        [deck addChild:[self AddChooseBtn: deckName]];
        [overall addObject:deck];
    }
    
    // (Roger) Now create the scroller and pass-in the pages (set widthOffset to 0 for fullscreen pages)
    CCScrollLayerVerticalHorizontal *scroller = [[CCScrollLayerVerticalHorizontal alloc] initWithLayers:overall widthOffset: 100];
    
    // (Roger) Finally add the scroller to the scene
    [self addChild:scroller];
}

- (CCMenu*) AddChooseBtn:(NSString *) deckName{
    CCMenuItemImage *chooseBtn = [CCMenuItemImage itemWithNormalImage:@"DeckChoose.png" selectedImage:@"DeckChoose.png" target:self selector:@selector(jumpToGuestLogin:)];
    chooseBtn.userData = [[NSString alloc] initWithString: deckName];
    CCMenu *menu = [CCMenu menuWithItems: chooseBtn, nil];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    menu.position = ccp(screenSize.width/2, 80);
    return menu;
}

// (Roger) Jump to Guest Login Scene
- (void)jumpToGuestLogin: (id) sender {
    NSLog(@"Set up the host player chosen deck");
    CoreData *core = [CoreData sharedCore];
    NSString *deckName = [sender userData];
    core.hostPlayerDeck = [[NSString alloc] initWithString:deckName];
    NSLog(@"Jump to Guest Login scene");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.5 scene:[GameGuestLogin scene] ]];
}


@end
