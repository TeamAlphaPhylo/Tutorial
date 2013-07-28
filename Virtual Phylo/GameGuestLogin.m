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
  	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        // (Roger) Define the text box property
        CGRect usernamePosition = CGRectMake(450, 310, 200, 40);
        CGRect pwdPosition = CGRectMake(450, 385, 200, 40);
        //CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>);
        
        // (Roger) Create a username field
        usernameField = [[UITextField alloc] initWithFrame:usernamePosition];
        usernameField.text = @"username";
        // (Roger) Regular text field with rounded corners
        usernameField.borderStyle = UITextBorderStyleRoundedRect;
        usernameField.delegate = self;
        
        // (Roger) Create a password field
        pwdField = [[UITextField alloc] initWithFrame:pwdPosition];
        pwdField.text = @"pass";
        pwdField.borderStyle = UITextBorderStyleRoundedRect;
        pwdField.delegate = self;
        
        // (Roger) Setup a background
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        CCSprite *background = [CCSprite spriteWithFile:@"background_main.png"];
        background.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:background];
        
        CCSprite *loginbox = [CCSprite spriteWithFile:@"login_box.png"];
        loginbox.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:loginbox];
        
        // (Roger) Add Buttons
        // CCSprite *loginBtn = [CCSprite spriteWithFile: @"Login.png"];
        CCMenuItemImage *loginBtn = [CCMenuItemImage itemWithNormalImage:@"user_signin.png"selectedImage:@"user_signin.png" target:self selector:@selector(verifyIdentity)];
        // (Roger) The external link has not been implemented
        CCMenuItemImage *othersBtn = [CCMenuItemImage itemWithNormalImage:@"user_register.png" selectedImage:@"user_register.png" target:self selector:@selector(registerAccount)];
        CCMenu *menu = [CCMenu menuWithItems:loginBtn, othersBtn, nil];
        [menu alignItemsHorizontallyWithPadding: 40];
        menu.position = CGPointMake(510, 260);
        
        [self addChild: menu];
        // This is where our first scene happens, where we should code stuff.
        
        // (Roger) Add login boxes
        [self addLoginFields];
        // (Roger) Enable the touch function
        self.touchEnabled = YES;
    }
	return self;
}

#pragma mark Login Function

// (Roger) Adding a method that allowing user to enter their username and password
-(void) addLoginFields
{
	NSLog(@"Creating Login Field View...");
	
	// (Roger) add the text fields to the view
	UIView *glView = [CCDirector sharedDirector].view;
	[glView addSubview:usernameField];
	[glView addSubview:pwdField];
}

#pragma mark Verification Function
// (Petr) Simple verfictional and Registeration (offline)
- (void) verifyIdentity {
    //checks if internet acess
    bool connected = [self connectedToInternet];
    if (connected)
        [self verifyIdentityOnline];
    
    //get the documents directory:
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/textfile.txt",
                          documentsDirectory];
    
    if ([self checkExistance:@"textfile.txt"]) {
        NSLog(@"Doesn't exist");
        NSString *data = @"";
        [data writeToFile: fileName
               atomically:NO
                 encoding:NSStringEncodingConversionAllowLossy
                    error:nil];
        NSLog(@"Made data file when none existed");
    }
    
    NSString *content = [[NSString alloc] initWithContentsOfFile:fileName
                                                    usedEncoding:nil
                                                           error:nil];
    NSArray *usernames = [content componentsSeparatedByString:@","];
    
    bool *fail = true;
    
    NSLog(@"size is: %lu", (unsigned long)([usernames count] - 1));
    NSLog(@"Contents are: %@", content);
    
    // (Roger) Added the username duplication verification
    CoreData *core = [CoreData sharedCore];
    if(!([usernameField.text isEqualToString: core.userName])) {
        NSLog(@"Verifying Identity");
        for (int i = 0; i < (([usernames count] - 1)); i +=2) {
            NSLog(@"Testing username: %@ and password: %@", usernames[i], usernames[i+1]);
            if([usernameField.text isEqualToString: usernames[i]] && [pwdField.text isEqualToString: usernames[i+1]]) {
                NSLog(@"Identity Verified");
                fail = false;
                // (Roger) Temporarily setting up that one pad can load multiple account
                //User data persistent storage
                CoreData *core = [CoreData sharedCore];
                // (Roger) Load the user name
                core.GuestUserName = [[NSString alloc] initWithString:usernames[i]];
                [core parseGuestStat:[Player getStats:core.guestUserName]];
            
                [self jumpToGuestDeckChoose];
                break;
            } else {
                fail = true;
            }
        }
        if (fail)
            [self showAlertView];
        NSLog(@"Finishing Verifying");
    } else {
        [self showDuplicationAlertView];
    }
}

//(Petr) Checks and registers new account
- (void) registerAccount {
    //Create user data file (it already checks if users exists)
    [Player createPlayer:usernameField.text];
    
    //get the documents directory:
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/textfile.txt",
                          documentsDirectory];
    
    if ([self checkExistance:@"textfile.txt"]) {
        NSLog(@"Doesn't exist");
        NSString *data = @"";
        [data writeToFile: fileName
               atomically:NO
                 encoding:NSStringEncodingConversionAllowLossy
                    error:nil];
        NSLog(@"Made data file when none existed");
    }
    
    
    NSString *contents = [[NSString alloc] initWithContentsOfFile:fileName encoding:nil error:nil];
    //Testing, displays content of file
    //NSLog(contents);
    
    NSArray *usernames = [contents componentsSeparatedByString:@","];
    
    bool *pass = true;
    NSString *message;
    
    //Check if username exists already
    for (int i = 0; i <= (([usernames count] - 1)); i +=2) {
        if([usernameField.text isEqualToString: usernames[i]]) {
            pass = false;
            break;
        } else {
            pass = true;
        }
    }
    
    if (pass) {
        //Alert infromation and formating
        //NSLog(@"Writting to data file");
        NSString *first = [NSString stringWithFormat:@"Username is: %@\n", usernameField.text];
        NSString *second = [NSString stringWithFormat:@"Password is: %@\n", pwdField.text];
        NSString *third = [NSString stringWithFormat:@"Is the infromation correct?\n"];
        message = [NSString stringWithFormat:@"%@%@%@", first, second, third];
        
        UIAlertView* newaccount = [[UIAlertView alloc] initWithTitle:@"Created account"
                                                             message:message
                                                            delegate:self
                                                   cancelButtonTitle:nil
                                                   otherButtonTitles:@"Yes", nil];
        [newaccount show];
        
        //save and write data to the documents directory
        NSString *data;
        if ([contents isEqualToString:@""]) {
            data = [NSString stringWithFormat:@"%@,%@", usernameField.text, pwdField.text];
            NSLog(@"%@", data);
        }
        else
            data = [NSString stringWithFormat:@"%@,%@,%@", contents, usernameField.text, pwdField.text];
        
        //Empty data
        //data = @"";
        
        //Save data to fileName
        [data writeToFile:fileName
               atomically:NO
                 encoding:NSStringEncodingConversionAllowLossy
                    error:nil];
        NSLog(@"New account made");
        
    } else {
        message = [NSString stringWithFormat:@"Account already exists with username %@", usernameField.text];
        UIAlertView* newerror = [[UIAlertView alloc] initWithTitle:@"Registration error"
                                                           message:message
                                                          delegate:self
                                                 cancelButtonTitle: nil
                                                 otherButtonTitles:@"Yes", nil];
        
        [newerror show];
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

// (Roger) Create a simple alert view to show there is no duplication of the username account of the host player
-(void) showDuplicationAlertView
{
	NSLog(@"Creating alert view ...");
	
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Login Error"
														message:@"Duplication User Name with Host Player"
													   delegate:self
											  cancelButtonTitle:@"Back"
											  otherButtonTitles:@"Problem?", nil];
	[alertView show];
}

#pragma mark Switching Scene
// (Roger) Switch the layer if the username and password are valid
- (void)jumpToMainMenu {
    NSLog(@"Dismissing/Releasing text fields");
    [usernameField removeFromSuperview];
    [pwdField removeFromSuperview];
    NSLog(@"Jump to Main Menu scene");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MainMenuLayer scene] ]];
}

//(Petr) Checks if online
- (BOOL) connectedToInternet {
    BOOL connected = ([NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.co.in/"] encoding:NSASCIIStringEncoding error:nil]!=NULL)?YES:NO;
    return connected;
}

- (void) verifyIdentityOnline {
    
}

- (BOOL) checkExistance:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *location = [NSString stringWithFormat:@"%@/textfile.txt",
                          documentsDirectory];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:location])
        return true;
    else
        return false;
}

- (void)jumpToGuestDeckChoose {
    NSLog(@"Dismissing/Releasing text fields");
    [usernameField removeFromSuperview];
    [pwdField removeFromSuperview];
    
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