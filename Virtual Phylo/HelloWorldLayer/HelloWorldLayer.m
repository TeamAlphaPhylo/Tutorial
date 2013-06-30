//
//  HelloWorldLayer.m
//  Virtual Phylo
//
//  Created by Darkroot on 6/21/13.
//  Copyright Group_12 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
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
		
		// add labels as children to this Layer
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

#pragma mark Login Function

// (Roger) Adding a method that allowing user to enter their username and password
-(void) addLoginFields
{
	CCLOG(@"Creating Login Field View...");
	
	// (Roger) add the text fields to the view
	UIView *glView = [CCDirector sharedDirector].view;
	[glView addSubview:usernameField];
	[glView addSubview:pwdField];
}

#pragma mark Verification Function
// (Roger) Very simple verification
- (void)verifyIdentity {
    if([usernameField.text isEqualToString: @"Herbert Tsang"] && [pwdField.text isEqualToString: @"sucks"]) {
        [self jumpToMainMenu];
    } else {
        [self showAlertView];
    }
}

// (Roger) Create a simple alert to show the username/password is wrong
-(void) showAlertView
{
	CCLOG(@"Creating alert view ...");
	
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Login Error"
														message:@"Invalid Username / Password"
													   delegate:self
											  cancelButtonTitle:@"Back"
											  otherButtonTitles:@"Problem?", nil];
	[alertView show];
}

#pragma mark Switching Scene
// (Roger) Switch the layer if the username and password are valid
- (void)jumpToMainMenu {
    NSLog(@"Jump to Main Menu scene");
    [usernameField removeFromSuperview];
    [pwdField removeFromSuperview];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainMenuLayer scene] ]];
}


@end
