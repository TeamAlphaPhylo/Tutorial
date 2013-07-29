//
//  HelloWorldLayer.m
//  Virtual Phylo
//
//  Created by Petr Krakora on 6/21/13.
//  Copyright Group_12 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

#import <AWSRuntime/AWSRuntime.h>

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
        
        //AWS instantiation
        NSString *acesskey = @"AKIAJHPBKEETHIOUBAPQ";
        NSString *secretkey = @"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";
        sdbClient = [[AmazonSimpleDBClient alloc] initWithAccessKey:acesskey withSecretKey:secretkey];
        sdbClient.endpoint = [AmazonEndpoints sdbEndpoint:US_WEST_2];
        
        //instantiation of domain not need already instantiated
        
//        SimpleDBCreateDomainRequest *createDomain = [[[SimpleDBCreateDomainRequest alloc] initWithDomainName:@"AccountData"]  autorelease];
//        SimpleDBCreateDomainResponse *createDomainResponse = [sdbClient createDomain:createDomain];
//        if(createDomainResponse.error != nil)
//        {
//            NSLog(@"Error: %@", createDomainResponse.error);
//        }
//        NSLog(@"Created a Domain");
        
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
	NSLog(@"Creating Login Field View...");
	
	// (Roger) add the text fields to the view
	UIView *glView = [CCDirector sharedDirector].view;
	[glView addSubview:usernameField];
	[glView addSubview:pwdField];
}

#pragma mark Verification Function
// (Petr) Simple verfictional and Registeration (offline)
- (void) verifyIdentity {
    //get the documents directory:
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    BOOL *fail = true;
    BOOL *alreadyVerified = false;
    BOOL connected = [self connectedToInternet];
    if (connected) {
        BOOL verified = [self verifyIdentityOnline];
        if (verified) {
            NSLog(@"Online verification passed");
            NSString *sync = [Player getSync:usernameField.text];
            NSLog(sync);
            alreadyVerified = true;
            if ([Player checkExistance:usernameField.text]) {
                NSLog(@"It exists");
                if (sync != NULL) {
                    NSLog(@"Sync is null");
                    [self updateData];
                }
                else
                    NSLog(@"It actually doesn't");
                    [self loadData];
            }
            else {
                NSLog(@"It doesn't");
                [self updateData];
            }
            fail = false;
            [self jumpToMainMenu];
        }
    }
    
    
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
    
    if (!alreadyVerified) {
        NSString *content = [[NSString alloc] initWithContentsOfFile:fileName
                                                    usedEncoding:nil
                                                           error:nil];
        NSArray *usernames = [content componentsSeparatedByString:@","];
    
        NSLog(@"size is: %lu", (unsigned long)([usernames count] - 1));
        NSLog(@"Contents are: %@", content);
    
        NSLog(@"Verifying Identity");
        for (int i = 0; i < (([usernames count] - 1)); i +=2) {
            NSLog(@"Testing username: %@ and password: %@", usernames[i], usernames[i+1]);
            if([usernameField.text isEqualToString: usernames[i]] && [pwdField.text isEqualToString:            usernames[i+1]]) {
                NSLog(@"Identity Verified");
                fail = false;
            
                [self jumpToMainMenu];
                break;
            } else {
                fail = true;
            }
        }
        if (fail)
            [self showAlertView];
    }
    NSLog(@"Finishing Verifying");
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
                                                   cancelButtonTitle:@"No"
                                                   otherButtonTitles:@"Yes", nil];
        [newaccount show];
        
        //save and write data to the documents directory
        NSString *data;
        if ([contents isEqualToString:@""]) {
            data = [NSString stringWithFormat:@"%@,%@", usernameField.text, pwdField.text];
            NSLog(data);
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
        BOOL connected = [self connectedToInternet];
        if (connected) {
            NSLog(@"Also adding account online");
            BOOL success = [self addAccountOnline];
            if (success)
                NSLog(@"Created online account successfully");
            else
                NSLog(@"Failed to create account online");
        }
        else
            NSLog(@"Offline so not adding online");
        
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
    BOOL connected = ([NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"] encoding:NSASCIIStringEncoding error:nil]!=NULL)?YES:NO;
    return connected;
}

- (BOOL) verifyIdentityOnline {
    
    SimpleDBGetAttributesRequest *gar = [[SimpleDBGetAttributesRequest alloc] initWithDomainName:@"AccountData" andItemName:usernameField.text];
    SimpleDBGetAttributesResponse *response = [sdbClient getAttributes:gar];
    
    //NSString *nameget = [self getStringValueForAttribute:@"username" fromList:response.attributes];
    NSString *passwordget = [self getStringValueForAttribute:@"password" fromList:response.attributes];
    
    if ([pwdField.text isEqualToString:passwordget])
        return true;
    else
        return false;
}

-(BOOL)addAccountOnline {
    SimpleDBReplaceableAttribute *usernameAttribute = [[[SimpleDBReplaceableAttribute alloc] initWithName:@"username" andValue:usernameField.text andReplace:YES] autorelease];
    SimpleDBReplaceableAttribute *passwordAttribute  = [[[SimpleDBReplaceableAttribute alloc] initWithName:@"password" andValue:pwdField.text andReplace:YES] autorelease];
    SimpleDBReplaceableAttribute *cardsAttribute  = [[[SimpleDBReplaceableAttribute alloc] initWithName:@"cards" andValue: @"0:0\nTrue\nDeckname;0!1!2!3!4!5!10!20!30" andReplace:YES] autorelease];
    
    NSMutableArray *attributes = [[[NSMutableArray alloc] initWithCapacity:1] autorelease];
    [attributes addObject:usernameAttribute];
    [attributes addObject:passwordAttribute];
    [attributes addObject:cardsAttribute];
    
    SimpleDBPutAttributesRequest *putAttributesRequest = [[[SimpleDBPutAttributesRequest alloc] initWithDomainName:@"AccountData" andItemName:usernameField.text andAttributes:attributes] autorelease];
    
    SimpleDBPutAttributesResponse *putAttributesResponse = [sdbClient putAttributes:putAttributesRequest];
    if(putAttributesResponse.error != nil)
    {
        NSLog(@"Error: %@", putAttributesResponse.error);
        return false;
    }
    NSLog(@"Added data to database");
    return true;
}

-(NSString *)getStringValueForAttribute:(NSString *)theAttribute fromList:(NSArray *)attributeList
{
    for (SimpleDBAttribute *attribute in attributeList) {
        if ( [attribute.name isEqualToString:theAttribute]) {
            return attribute.value;
        }
    }
    return @"";
}

- (void)updateData {
    NSString *sync = [Player getSync:usernameField.text];
    if ([sync isEqualToString:@"True"]) {
        NSLog(@"Data is already synced");
        NSMutableArray *test = [Player getDecks:usernameField.text];
        NSLog([test description]);
    }
    else {
        NSLog(@"Updating data");
        [self updateAccountOnline];
    }
}

- (void)loadData {
    SimpleDBGetAttributesRequest *gar = [[SimpleDBGetAttributesRequest alloc] initWithDomainName:@"AccountData" andItemName:usernameField.text];
    SimpleDBGetAttributesResponse *response = [sdbClient getAttributes:gar];
    
    //NSString *nameget = [self getStringValueForAttribute:@"username" fromList:response.attributes];
    NSString *cardGet = [self getStringValueForAttribute:@"cards" fromList:response.attributes];
    NSLog(cardGet);
    NSLog(usernameField.text);
    [Player buildFile:usernameField.text data:cardGet];
    
}

- (void)updateAccountOnline {
    //get the documents directory:
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@/%@.txt",
                          documentsDirectory, usernameField.text];
    NSString *contents = [[NSString alloc] initWithContentsOfFile:fileName encoding:nil error:nil];

    NSLog(@"Data to be updated is : %@", contents);
    SimpleDBReplaceableAttribute *usernameAttribute = [[[SimpleDBReplaceableAttribute alloc] initWithName:@"username" andValue:usernameField.text andReplace:YES] autorelease];
    SimpleDBReplaceableAttribute *passwordAttribute  = [[[SimpleDBReplaceableAttribute alloc] initWithName:@"password" andValue:pwdField.text andReplace:YES] autorelease];
    SimpleDBReplaceableAttribute *cardsAttribute  = [[[SimpleDBReplaceableAttribute alloc] initWithName:@"cards" andValue:contents andReplace:YES] autorelease];
    
    NSMutableArray *attributes = [[[NSMutableArray alloc] initWithCapacity:1] autorelease];
    [attributes addObject:usernameAttribute];
    [attributes addObject:passwordAttribute];
    [attributes addObject:cardsAttribute];
    
    SimpleDBPutAttributesRequest *putAttributesRequest = [[[SimpleDBPutAttributesRequest alloc] initWithDomainName:@"AccountData" andItemName:usernameField.text andAttributes:attributes] autorelease];
    
    SimpleDBPutAttributesResponse *putAttributesResponse = [sdbClient putAttributes:putAttributesRequest];
    if(putAttributesResponse.error != nil)
    {
        NSLog(@"Error: %@", putAttributesResponse.error);
    }
    NSLog(@"Updated the account for sure");
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

@end