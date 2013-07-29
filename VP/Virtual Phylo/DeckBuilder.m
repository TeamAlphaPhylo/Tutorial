//
//  DeckBuilder.m
//  Virtual Phylo
//
//  Created by Petr Krarkora on 7/13/13.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import "DeckBuilder.h"

@implementation DeckBuilder

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// (Roger) Please be careful here, after the copy and paste, remember to change the object type of the layer
    // (Roger) Change the object type to this class (name). Otherwise it will take very long time to debug it.
    // (BUG)	MainMenuLayer *layer = [MainMenuLayer node];
	DeckBuilder *layer = [DeckBuilder node];
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
        [self saveDeck];
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

- (void) setBackgroundColour {
    NSLog(@"Setting up Background Colour");
    CCLayerColor *bgColour = [CCLayerColor layerWithColor:ccc4(0, 0, 102, 255)];
    [self addChild:bgColour];
}

- (void) saveDeck {
    NSString *username = @"group12isthebest!";
    NSString *deckName = @"deleted2";
    //NSString *deckName1 = @"Ivy is the best";
    //NSString *deckName2 = @"Roger is the greatest";
    //NSString *deckName3 = @"Alex is amazing";
    //NSString *deckName4 = @"Brandon is stellar";
    //NSString *deckName5 = @"Petr is adequate";
    NSMutableArray *testArray = [[NSMutableArray alloc] init];
    [testArray addObject:@"3"];
    [Player getDecks:username];
    [Player createDeck:username deckName:deckName cardArray:testArray];
    //[Player createDeck:username deckName:deckName1 cardArray:testArray];
    //[Player createDeck:username deckName:deckName2 cardArray:testArray];
    //[Player createDeck:username deckName:deckName3 cardArray:testArray];
    //[Player createDeck:username deckName:deckName4 cardArray:testArray];
    //[Player createDeck:username deckName:deckName5 cardArray:testArray];
    NSLog([[Player getDecks:username] description]);
    NSLog(@"Sync is : %@" ,[Player getSync:username]);
}

// (Alex) this is where data from file is gotten
- (void) getData {
    NSString *file = [[NSBundle mainBundle] pathForResource:@"AnimalData" ofType:@"txt"];
    NSString *content = [[NSString alloc] initWithContentsOfFile:file
                                                usedEncoding:nil
                                                error:nil];
    NSArray *data = [content componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"]];
    
    NSLog(@"size is: %lu", (unsigned long)([data count] - 1));
    NSLog(@"Card data:");
    //Gets a single line of data
    NSLog(@"%@", data[0]);
    
    //Data now in split into it's componenets
    //NSArray *split = [data[0] componentsSeparatedByString:@";"];
    //NSLog(split);
    
    //Gets names, change array index to get diffrent information
    //NSLog(@"%@" , split[0]);
}

- (void) listCards {
    [self getData];
    int lastPositionX = 80;
    int lastPositionY = 650;
    NSLog(@"Listing cards from user deck");
    for (int i = 0; i <= 50; i++) {
        NSString *fileName = [NSString stringWithFormat:@"%d.png", i];
        CCSprite *exampleCard = [CCSprite spriteWithFile:fileName];
        exampleCard.scale = .50;
        exampleCard.position =  ccp(lastPositionX, lastPositionY);
        lastPositionX += 50;
        if (lastPositionX >= 950)
        {
            lastPositionY -= 100;
            lastPositionX = 80;
        }
            
        exampleCard.tag = i;
        [self addChild:exampleCard];
    }
}

- (void)jumpToMainMenu {
    NSLog(@"Jump back to Main Menu scene");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.5 scene:[MainMenuLayer scene]]];
}

// (Roger) Jump to Guest Login Scene
- (void)jumpToGuestLogin {
    NSLog(@"Jump to Guest Login scene");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.5 scene:[GameGuestLogin scene] ]];
}

@end
