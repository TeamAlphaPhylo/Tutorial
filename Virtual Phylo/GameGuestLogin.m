//
//  GameGuestLogin.m
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-06.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import "GameGuestLogin.h"

@implementation GameGuestLogin

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// (Roger) Please be careful here, after the copy and paste, remember to change the object type of the layer
    // (Roger) Change the object type to this class (name). Otherwise it will take very long time to debug it.
    // (BUG)	MainMenuLayer *layer = [MainMenuLayer node];
	GameGuestLogin *layer = [GameGuestLogin node];
    // add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
    if( (self=[super init]) ) {
        
        NSLog(@"Game Guest Login Layer Initialization");
        
        // add components created as children to this Layer (Notice there are added in a specific sequence)
        [self setBackgroundColour];
        [self setTitle];
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(addLoginBlock) userInfo:nil repeats:NO];

//        [self addLoginBlock];
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
    
    // (Roger)create and initialize a Label
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Game: Guest Player Login" fontName:@"Verdana" fontSize:36];
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
    NSLog(@"Dismissing/Releasing text fields");
    [usernameField removeFromSuperview];
    [pwdField removeFromSuperview];

    NSLog(@"Jump back to Main Menu scene");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.5 scene:[MainMenuLayer scene]]];
}

- (void)addLoginBlock {    
    // (Roger) Define the text box property
    CGRect usernamePosition = CGRectMake(500, 360, 200, 40);
    CGRect pwdPosition = CGRectMake(500, 440, 200, 40);
    //CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>);
    
    // (Roger) Create a username field
    usernameField = [[UITextField alloc] initWithFrame:usernamePosition];
    usernameField.text = @"Herbert Tsang";
    // (Roger) Regular text field with rounded corners
    usernameField.borderStyle = UITextBorderStyleRoundedRect;
    usernameField.delegate = self;
    
    // (Roger) Create a password field
    pwdField = [[UITextField alloc] initWithFrame:pwdPosition];
    pwdField.text = @"sucks";
    pwdField.borderStyle = UITextBorderStyleRoundedRect;
    pwdField.delegate = self;
    
    // create and initialize a Label
    CCLabelTTF *title = [CCLabelTTF labelWithString:@"VirtualPhylo Login" fontName:@"Marker Felt" fontSize:62];
    CCLabelTTF *username = [CCLabelTTF labelWithString:@"Username" fontName:@"Marker Felt" fontSize:36];
    CCLabelTTF *password = [CCLabelTTF labelWithString:@"Password" fontName:@"Marker Felt" fontSize:36];
    
    // ask director for the window size
    CGSize size = [[CCDirector sharedDirector] winSize];
	
    // position the label on the center of the screen
    // (Roger) Estimating the position of the Title of the login form
    // (Roger) Notice that Cocos2D origin coordinate is different from the UIView Class
    // (Roger) Cocos2D Origin is at the lower left hand corner, whereas the UIView class origin is at upper left hand corner
    title.position =  ccp(size.width /2 , 500);
    username.position = ccp(390, 390);
    password.position = ccp(390, 310);
    
    // (Roger) Setup a background
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite *background = [CCSprite spriteWithFile:@"LoginBox.png"];
    background.position = ccp(winSize.width/2, winSize.height/2);
    [self addChild:background];
    
    // (Roger) Add labels as children to this Layer
    [self addChild: title];
    [self addChild: username];
    [self addChild: password];
    
    // (Roger) Add Buttons
    //        CCSprite *loginBtn = [CCSprite spriteWithFile: @"Login.png"];
    CCMenuItemImage *loginBtn = [CCMenuItemImage itemWithNormalImage:@"login.png"selectedImage:@"login.png" target:self selector:@selector(verifyIdentity)];
    // (Roger) The external link has not been implemented
    CCMenuItemImage *othersBtn = [CCMenuItemImage itemWithNormalImage:@"Others.png" selectedImage:@"Others.png" target:nil selector:nil];
    CCMenu *menu = [CCMenu menuWithItems:loginBtn, othersBtn, nil];
    [menu alignItemsHorizontallyWithPadding: 50];
    menu.position = CGPointMake(550, 230);
    
    [self addChild: menu];
    // This is where our first scene happens, where we should code stuff.
    
    // (Roger) Add login boxes
    [self addLoginFields];
    // (Roger) Enable the touch function
    self.touchEnabled = YES;

}

// (Roger) Adding a method that allowing user to enter their username and password
-(void) addLoginFields
{
	NSLog(@"Creating Login Field View...");
	
	// (Roger) add the text fields to the view
	UIView *glView = [CCDirector sharedDirector].view;
	[glView addSubview:usernameField];
	[glView addSubview:pwdField];
}

// (Roger) Very simple verification
- (void)verifyIdentity {
    NSLog(@"Verifying Identity");
    if([usernameField.text isEqualToString: @"Herbert Tsang"] && [pwdField.text isEqualToString: @"sucks"]) {
        NSLog(@"Identity Verified");
        // TO-DO: Loading the user data into the main function
        [self jumpToGuestDeckChoose];
    } else {
        CCLOG(@"Verification Failed. Popping up Error Message");
        [self showAlertView];
    }
}

// (Roger) Create a simple alert to show the username/password is wrong
-(void) showAlertView
{
	NSLog(@"Creating alert view ...");
	
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Login Error"
														message:@"Invalid Username / Password"
													   delegate:self
											  cancelButtonTitle:@"Back"
											  otherButtonTitles:@"Problem?", nil];
	[alertView show];
}

- (void)jumpToGuestDeckChoose {
    NSLog(@"Dismissing/Releasing text fields");
    [usernameField removeFromSuperview];
    [pwdField removeFromSuperview];
    
    NSLog(@"Jump Guest Deck Choose to Main Menu scene");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.5 scene:[GuestDeckChoose scene]]];
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