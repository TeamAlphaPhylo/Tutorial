//
//  GuestDeckChoose.m
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-06.
//  Copyright 2013 Group_12. All rights reserved.
//

#import "GuestDeckChoose.h"


@implementation GuestDeckChoose

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// (Roger) Please be careful here, after the copy and paste, remember to change the object type of the layer
    // (Roger) Change the object type to this class (name). Otherwise it will take very long time to debug it.
    // (BUG)	MainMenuLayer *layer = [MainMenuLayer node];
	GuestDeckChoose *layer = [GuestDeckChoose node];
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
        [self deckChooser];
        
    }
    return self;
}

- (void) setBackgroundColour {
    NSLog(@"Setting up Background Colour");
    CCLayerColor *bgColour = [CCLayerColor layerWithColor:ccc4(0, 0, 102, 255)];
    [self addChild:bgColour];
}

- (void) setTitle {
    NSLog(@"Setting up the Title at the top");
    
    // (Roger) Testing on the CoreData function
    //    CoreData *core = [CoreData sharedCore];
    // (Roger) (Updated) The preliminary CoreData function test: Passed
    
    
    // (Roger)create and initialize a Label
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Game: Host Player Deck Choosing" fontName:@"Verdana" fontSize:36];
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

//- (void) setExampleCard {
//    // (Brandon) eventually, I wanna test out initalizing a CardSprite algorithmically
//    // CardSprite *exCard;
//}

// (Roger) some of this function components need to be extracted for fetching the deck info and meet encapsulation purpose
- (void) deckChooser {
    // (Roger) get screen size
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    // (Roger) create a blank layer for deck 1
    CCLayer *deckOne = [[CCLayer alloc] init];
    
    // (Roger) create a label for deck 1
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Dummy Deck 1" fontName:@"Arial Rounded MT Bold" fontSize:44];
    label.position =  ccp( screenSize.width /2 , 600);
    CCSprite *exampleCard = [CCSprite spriteWithFile:@"1.png"];
    exampleCard.position =  ccp( screenSize.width /2 , 300 );
    
    // (Roger) add components to deck 1 layer
    [deckOne addChild:exampleCard];
    [deckOne addChild:label];
    [deckOne addChild:[self AddChooseBtn]];
    
    
    // (Roger) create deck 2 layer
    CCLayer *deckTwo = [[CCLayer alloc] init];
    
    CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"Dummy Deck 2" fontName:@"Arial Rounded MT Bold" fontSize:44];
    label2.position =  ccp( screenSize.width /2 , 600);
    CCSprite *exampleCard2 = [CCSprite spriteWithFile:@"2.png"];
    exampleCard2.position =  ccp( screenSize.width /2 , 300 );
    
    
    [deckTwo addChild:exampleCard2];
    [deckTwo addChild:label2];
    [deckTwo addChild:[self AddChooseBtn]];
    
    // (Roger) Now create the scroller and pass-in the pages (set widthOffset to 0 for fullscreen pages)
    CCScrollLayerVerticalHorizontal *scroller = [[CCScrollLayerVerticalHorizontal alloc] initWithLayers:[NSArray arrayWithObjects: deckOne, deckTwo, nil] widthOffset: 100];
    
    // (Roger) Finally add the scroller to the scene
    [self addChild:scroller];
}

- (CCMenu*) AddChooseBtn {
    CCMenuItemImage *chooseBtn = [CCMenuItemImage itemWithNormalImage:@"DeckChoose.png" selectedImage:@"DeckChoose.png" target:self selector:@selector(jumpToGuestLogin)];
    CCMenu *menu = [CCMenu menuWithItems: chooseBtn, nil];
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    menu.position = ccp(screenSize.width/2, 50);
    
    return menu;
}

// (Roger) Jump to Guest Login Scene
- (void)jumpToGuestLogin {
    NSLog(@"Jump to Guest Login scene");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.5 scene:[GameTable scene] ]];
}

- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
