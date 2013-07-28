//
//  SettingsLayer.m
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-26.
//  Copyright 2013 Group_12. All rights reserved.
//

#import "SettingsLayer.h"


@implementation SettingsLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	SettingsLayer *layer = [SettingsLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
    if( (self=[super init]) ) {
        
        NSLog(@"Settings Layer Initialization");
        
        // (Roger) Test on the MasterCard initialization
        //        CoreData *core = [CoreData sharedCore];
        
        
        // add components created as children to this Layer (Notice there are added in a specific sequence)
        [self setBackground];
        [self setTitle];
        [self setUserInfo];
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
    CCLabelTTF *winStr = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", core.userWin] fontName:@"Verdana" fontSize:16];
    CCLabelTTF *lossStr = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", core.userLoss]  fontName:@"Verdana" fontSize:16];
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
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.5 scene:[MainMenuLayer scene] ]];
}
@end
