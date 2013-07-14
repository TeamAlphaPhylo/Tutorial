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
        // (Roger) Running smoothly, huh? @Petr
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(addLoginBlock) userInfo:nil repeats:NO];

//        [self addLoginBlock];
    }
    return self;
}
- (void) setBackgroundColour {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    // (Roger) Use Petr's Background image
    NSLog(@"Setting up Background Image");
    CCSprite *background = [CCSprite spriteWithFile:@"background_main.png"];
    background.position = ccp(winSize.width/2, winSize.height/2);
    [self addChild:background];
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
    // (Roger) Get the window size
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    // (Roger) Define the text box property
    CGRect usernamePosition = CGRectMake(450, 310, 200, 40);
    CGRect pwdPosition = CGRectMake(450, 385, 200, 40);
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
    

	
    // position the label on the center of the screen
    // (Roger) Estimating the position of the Title of the login form
    // (Roger) Notice that Cocos2D origin coordinate is different from the UIView Class
    // (Roger) Cocos2D Origin is at the lower left hand corner, whereas the UIView class origin is at upper left hand corner
    
    // (Roger) Set up the background of textfield
    CCSprite *loginBG = [CCSprite spriteWithFile:@"login_box.png"];
    loginBG.position = ccp(winSize.width/2, winSize.height/2);
    [self addChild: loginBG];
    
    // (Roger) Add Buttons
    //        CCSprite *loginBtn = [CCSprite spriteWithFile: @"Login.png"];
    CCMenuItemImage *loginBtn = [CCMenuItemImage itemWithNormalImage:@"user_signin.png"selectedImage:@"user_signin.png" target:self selector:@selector(verifyIdentity)];
    // (Roger) The external link has not been implemented
    CCMenuItemImage *othersBtn = [CCMenuItemImage itemWithNormalImage:@"user_register.png" selectedImage:@"user_register.png" target:nil selector:nil];
    CCMenu *menu = [CCMenu menuWithItems:loginBtn, othersBtn, nil];
    [menu alignItemsHorizontallyWithPadding: 40];
    menu.position = CGPointMake(510, 260);
    
    [self addChild: menu];
    // This is where our first scene happens, where we should code stuff.
    
    // (Roger) Notice the sequence is really important, otherwise it will cause exceptions
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
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@/textfile.txt",
                          documentsDirectory];
    NSString *content = [[NSString alloc] initWithContentsOfFile:fileName
                                                    usedEncoding:nil
                                                           error:nil];
    NSArray *usernames = [content componentsSeparatedByString:@","];
    bool *fail = false;
    
    NSLog(@"Verifying Identity");
    for (int i = 0; i < ((sizeof(usernames) - 2)); i +=2) {
        if([usernameField.text isEqualToString: usernames[i]] && [pwdField.text isEqualToString: usernames[i+1]]) {
            NSLog(@"Identity Verified");
            // TO-DO: Loading the user data into the main function
            [self jumpToGuestDeckChoose];
            break;
        } else {
            fail = true;
        }
    }
    if (fail)
        [self showAlertView];
    NSLog(@"Finishing Verifying");
}

//Method writes a string to a text file
- (void)writeToTextFile {
    //get the documents directory:
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/textfile.txt",
                          documentsDirectory];
    
    //Alert infromation and formating
    NSString *first = [NSString stringWithFormat:@"Username is: %@\n", usernameField.text];
    NSString *second = [NSString stringWithFormat:@"Password is: %@\n", pwdField.text];
    NSString *third = [NSString stringWithFormat:@"Is the infromation correct?\n"];
    
    NSString *content = [NSString stringWithFormat:@"%@,%@", usernameField.text, pwdField.text];
    
    //save content to the documents directory
    [content writeToFile:fileName
              atomically:NO
                encoding:NSStringEncodingConversionAllowLossy
                   error:nil];
    
    NSString *message = [NSString stringWithFormat:@"%@%@%@", first, second, third];
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Created account"
														message:message
													   delegate:self
											  cancelButtonTitle:@"No"
											  otherButtonTitles:@"Yes", nil];
	[alertView show];
    
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