//
//  GameMenu.m
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-28.
//  Copyright 2013 Group_12. All rights reserved.
//

#import "GameMenu.h"


@implementation GameMenu
@synthesize hidden;

-(id) init
{
    if( (self=[super init]) ) {
        
        NSLog(@"Player Layer Bot");
        
        // (Roger) Initialize the properties
        hidden = true;
        
        // (Roger) Set up background
        [self setBackground];
    }
    return self;
}

- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

- (void) setBackground {
    CCSprite *background = [CCSprite spriteWithFile:@"handBarrier.png"];
    background.position = ccp(-65, 380);
    [self addChild:background];
    // (Roger) Add two menu items to let use hide/unhide their hand
    CCMenuItemImage *hide = [CCMenuItemImage itemWithNormalImage:@"arrowSwipeCardExchange.png" selectedImage:@"arrowCardSwipeExchange.png" target:self selector:@selector(hideMenu)];
    CCMenuItemImage *unhide = [CCMenuItemImage itemWithNormalImage:@"arrowHand.png" selectedImage:@"arrowHand.png" target:self selector:@selector(hideMenu)];
    CCMenu *HideMenu = [CCMenu menuWithItems:hide, unhide, nil];
    
    CCMenuItemImage *hostWin = [CCMenuItemImage itemWithNormalImage:@"hostWin.png" selectedImage:@"hostWin.png" target: self selector:@selector(hostWin)];
    CCMenuItemImage *guestWin = [CCMenuItemImage itemWithNormalImage:@"guestWin.png" selectedImage:@"guestWin.png" target: self selector:@selector(guestWin)];
    CCMenuItemImage *mainMenu = [CCMenuItemImage itemWithNormalImage:@"menuMain.png" selectedImage:@"menuMain.png" target: self selector:@selector(jumpToMainMenu)];
    CCMenu *options = [CCMenu menuWithItems:hostWin, guestWin, mainMenu, nil];
    
    // (Roger) Set Positions
    HideMenu.position = ccp(-20,327);
    options.position = ccp(-40,395);
    // (Roger) Set Padding
    [HideMenu alignItemsHorizontallyWithPadding:30];
    [options alignItemsVerticallyWithPadding:5];
    [self addChild:HideMenu z:2];
    [self addChild:options z:2];
}

- (void)jumpToMainMenu {
    NSLog(@"Jump back to Main Menu scene");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.5 scene:[MainMenuLayer scene]]];
}

- (void)hideMenu {
    if (!hidden) {
        NSLog(@"Hide Menu");
        [self runAction:[CCMoveTo actionWithDuration:0.5 position:ccp(0,0)]];
        hidden = true;
    } else {
        NSLog(@"Show Menu");
        [self runAction:[CCMoveTo actionWithDuration:0.5 position:ccp(90,0)]];
        hidden = false;
    }
}

- (void)guestWin {
    CoreData *core = [CoreData sharedCore];
    [Player playerWin:YES withusername: core.guestUserName];
    [Player playerWin:NO withusername:core.userName];
    [core parseStat:[Player getStats:core.userName]];
    NSLog(@"Creating alert view ...");
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Congratulations!"
														message:@"Guest Player Won the Game"
													   delegate:self
											  cancelButtonTitle:@"Back to Main Menu"
											  otherButtonTitles:nil];
	[alertView show];
    [self jumpToMainMenu];
}

- (void)hostWin {
    CoreData *core = [CoreData sharedCore];
    [Player playerWin:NO withusername: core.guestUserName];
    [Player playerWin:YES withusername:core.userName];
    [core parseStat:[Player getStats:core.userName]];
    NSLog(@"Creating alert view ...");
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Congratulations!"
														message:@"Host Player Won the Game"
													   delegate:self
											  cancelButtonTitle:@"Back to Main Menu"
											  otherButtonTitles:nil];
	[alertView show];
    [self jumpToMainMenu];
}


@end
