//
//  SettingsLayer.m
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-26.
//  Copyright 2013 Group_12. All rights reserved.
//

#import "SettingsLayer.h"

@implementation SettingsLayer
@synthesize showCase;
@synthesize gameBg;
@synthesize gameMusic;

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
        [self setChangeBG];
        [self setChangeMusic];
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
    // (Roger) The frame width is 265 pixel
    CCSprite *frame = [CCSprite spriteWithFile:@"frame.png"];
    frame.position = CGPointMake(screenSize.width / 2, screenSize.height/2);
    CCSprite *defaultBg = [CCSprite spriteWithFile:@"green.jpg"];
    defaultBg.scale = 265 / defaultBg.contentSize.width;
    defaultBg.position = frame.position;
    showCase = defaultBg;
    gameBg = @"green.jpg";
    
    CCMenuItemImage *saveBtn = [CCMenuItemImage itemWithNormalImage:@"setting_saveChanges.png" selectedImage:@"setting_saveChanges.png" target:self selector:@selector(saveChanges)];
    CCMenu *menu = [CCMenu menuWithItems:saveBtn, nil];
    menu.position = ccp(512, 130);
    [self addChild:menu];
    
    // (Roger) Adding Frames and Default Background
    [self addChild:frame];
    [self addChild:defaultBg];
    
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

-(void)setChangeBG {
    CCSprite *changeBG = [CCSprite spriteWithFile:@"setting_changeBG.png"];
    changeBG.position = ccp(175, 425);
    [self addChild:changeBG];
    
    // (Roger) Add menu
    CCMenuItemImage *item0 = [CCMenuItemImage itemWithNormalImage:@"green_btn.png" selectedImage:@"green_btn.png" target:self selector:@selector(setGameBkg:)];
    item0.userData = @"green.jpg";
    CCMenuItemImage *item1 = [CCMenuItemImage itemWithNormalImage:@"water_droplets.png" selectedImage:@"water_droplets.png" target:self selector:@selector(setGameBkg:)];
    item1.userData = @"waterDroplets.jpg";
    CCMenuItemImage *item2 = [CCMenuItemImage itemWithNormalImage:@"dave_btn.png" selectedImage:@"dave_btn.png" target:self selector:@selector(setGameBkg:)];
    item2.userData = @"dove.jpg";
    CCMenuItemImage *item3 = [CCMenuItemImage itemWithNormalImage:@"klug_fusion.png" selectedImage:@"klug_fusion.png" target:self selector:@selector(setGameBkg:)];
    item3.userData = @"klugFusion.jpg";
    
    CCMenu *menu = [CCMenu menuWithItems:item0, item1, item2, item3, nil];
    menu.position = ccp(207, 328);
    [menu alignItemsVerticallyWithPadding:5];
    [self addChild:menu];
}

-(void)setChangeMusic {
    CCSprite *changeMusic = [CCSprite spriteWithFile:@"setting_changeMusic.png"];
    changeMusic.position = ccp(850, 425);
    [self addChild:changeMusic];
    
    // (Roger) Add menu
    CCMenuItemImage *item0 = [CCMenuItemImage itemWithNormalImage:@"rylynn.png" selectedImage:@"rylynn.png" target:self selector:@selector(setGameBkg:)];
    item0.userData = @"Rylynn.mp3";
    CCMenuItemImage *item1 = [CCMenuItemImage itemWithNormalImage:@"blue_liquid.png" selectedImage:@"blue_liquid.png" target:self selector:@selector(setGameBkg:)];
    item1.userData = @"BlueLiquid.m4a";
    CCMenuItemImage *item2 = [CCMenuItemImage itemWithNormalImage:@"these_moments.png" selectedImage:@"these_moments.png" target:self selector:@selector(setGameBkg:)];
    item2.userData = @"TheseMoments.m4a";
    CCMenuItemImage *item3 = [CCMenuItemImage itemWithNormalImage:@"kokomo.png" selectedImage:@"kokomo.png" target:self selector:@selector(setGameBkg:)];
    item3.userData = @"Kokomo.m4a";
    CCMenuItemImage *item4 = [CCMenuItemImage itemWithNormalImage:@"remedios.png" selectedImage:@"remedios.png" target:self selector:@selector(setGameBkg:)];
    item4.userData = @"still.mp3";
    CCMenuItemImage *item5 = [CCMenuItemImage itemWithNormalImage:@"royal_treasure.png" selectedImage:@"royal_treasure.png" target:self selector:@selector(setGameBkg:)];
    item5.userData = @"RoyalTreasure.mp3";
    CCMenuItemImage *item6 = [CCMenuItemImage itemWithNormalImage:@"Maybe.png" selectedImage:@"Maybe.png" target:self selector:@selector(setGameBkg:)];
    item6.userData = @"MayBe.mp3";
    
    CCMenu *menu = [CCMenu menuWithItems:item0, item1, item2, item3, item4, item5, item6, nil];
    menu.position = ccp(834, 271);
    [menu alignItemsVerticallyWithPadding:5];
    [self addChild:menu];
}

- (void)jumpToMainMenu {
    NSLog(@"Jump back to Main Menu scene");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.5 scene:[MainMenuLayer scene] ]];
}

// (Roger) Update the current Game background
- (void)setGameBkg: (id)sender {
    NSString *fileName = [sender userData];
    gameBg = [[NSString alloc] initWithString:fileName];
    // (Roger) Remove the child first
    [self removeChild:showCase];
    showCase = [CCSprite spriteWithFile:gameBg];
    showCase.scale = 265 / showCase.contentSize.width;
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    showCase.position = CGPointMake(screenSize.width / 2, screenSize.height/2);
    [self addChild:showCase];
}

- (void)setGameBGM: (id)sender {
    NSString *fileName = [sender userData];
    gameMusic = [[NSString alloc] initWithString:fileName];
    
}

- (void)saveChanges {
    CoreData *core = [CoreData sharedCore];
    core.gameMusic = gameMusic;
    core.gameBG = gameBg;
    NSLog(@"Creating alert view ...");
	
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Save Changes"
														message:@"Successfully Saved Changes"
													   delegate:self
											  cancelButtonTitle:@"Back"
											  otherButtonTitles:nil];
	[alertView show];
}
@end
