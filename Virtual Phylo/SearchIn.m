//
//  PlayerLayerTop.m
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-15.
//  Copyright 2013 Group_12. All rights reserved.
//

#import "SearchIn.h"


@implementation SearchIn
@synthesize selected_card_index;
@synthesize doubleTapRecognizer = _doubleTapRecognizer;
@synthesize cardsOnHand;
@synthesize cardsOnTable;
float xWay1=0;
float xWay2=0;
float xWay3=0;
float xWay4=0;
int numberSelect=0;
bool checkPoints=false;
bool checkalephabetic=false;
bool diet=false;
bool foodChain=false;
bool scale=false;
bool climate=false;
bool terrain=false;
bool evolutionTree=false;

static ItemsScroller *scroller = nil;

-(id) init
{
    if( (self=[super init]) ) {
        
        NSLog(@"the initial cards for the searching");
        //  Add delegate
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        selected_card_index = 0;
        
        //  Initialized the cardOnHandArray
        cardsOnHand = [[NSMutableArray alloc] init];
        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        scroller = [ItemsScroller itemsScrollerWithItems:nil andOrientation:ItemsScrollerHorizontal andRect:CGRectMake(10, 20, winSize.width - 20, 155)];
        [self addChild:scroller];
        
        //  Add hand scroller
        //[self addCardScrollerwithboolean1:YES andBool2:NO andBool3:NO];
        [self addCardScrollerwithstring:@"All"];
        //  Set up background
        [self setBackground];
        [self SetBotMenu];
    }
    return self;
}

-(void) setBackground {
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    
    // add hand box rect
    CCSprite *lowerPlayerHand = [CCSprite spriteWithFile:@"deckHand.png"];
    lowerPlayerHand.position = ccp(winSize.width/2, 65);
    [self addChild:lowerPlayerHand];
    
    
}
- (void) addCardScrollerwithstring:(NSString*)a
{
    NSLog(@"Trying to add CCScroll View.");
    [cardsOnHand removeAllObjects];
    [scroller updateItems:cardsOnHand];    
    SelectableItem *page = nil;    
    if ([a isEqual: @"All"]) {
            for (int i = 0; i <500; i++) {
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", i, @".png"];                
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testCalling)];        
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                image.tag = i;
                
                [page addChild:image];
                [cardsOnHand addObject:page];
            }
    }
    else if ([a isEqual: @"a_d"])
    {
        NSLog(@"a_d check");
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count]-1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[0];
            NSString *firstL = [data2 substringWithRange: NSMakeRange (0,1)];
            if ([firstL isEqualToString:@"A" ]||[firstL isEqualToString:@"B"] ||[firstL isEqualToString:@"C"]||[firstL isEqualToString:@"D"]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0 ,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;            
                [page addChild:image z:1 tag: val];   
                [cardsOnHand addObject:page];
            }

        }

    }
    else if ([a isEqual: @"e_k"])
    {
        NSLog(@"e_k check");
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[0];
            NSString *firstL = [data2 substringWithRange: NSMakeRange (0,1)];
            if ([firstL isEqualToString:@"E" ]||[firstL isEqualToString:@"F"] ||[firstL isEqualToString:@"G"]||[firstL isEqualToString:@"H"]||[firstL isEqualToString:@"I"]||[firstL isEqualToString:@"J"]||[firstL isEqualToString:@"K"]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];               
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                
                [page addChild:image z:1 tag: val];         
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"l_q"])
    {
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[0];
            NSString *firstL = [data2 substringWithRange: NSMakeRange (0,1)];
            if ([firstL isEqualToString:@"L" ]||[firstL isEqualToString:@"M"] ||[firstL isEqualToString:@"N"]||[firstL isEqualToString:@"O"]||[firstL isEqualToString:@"P"]||[firstL isEqualToString:@"Q"]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];       
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"r_z"])
    {
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[0];
            NSString *firstL = [data2 substringWithRange: NSMakeRange (0,1)];
            NSLog (@"firstL = %@", firstL);
            if ([firstL isEqualToString:@"R" ]||[firstL isEqualToString:@"S"] ||[firstL isEqualToString:@"T"]||[firstL isEqualToString:@"U"]||[firstL isEqualToString:@"V"]||[firstL isEqualToString:@"W"]||[firstL isEqualToString:@"X"]||[firstL isEqualToString:@"Y"]||[firstL isEqualToString:@"Z"]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];            
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"photosynthetic"])
    {
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[1];
            NSString *data3= [data2 substringWithRange: NSMakeRange (0,1)];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"P" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testCalling)];         
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                   
                [page addChild:image z:1 tag: val];               
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"molecular"])
    {
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[1];
            NSString *data3= [data2 substringWithRange: NSMakeRange (0,1)];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"M" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];            
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                           
                [page addChild:image z:1 tag: val];          
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"herbivore"])
    {
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[1];
            NSString *data3= [data2 substringWithRange: NSMakeRange (0,1)];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"H" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];   
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                
                [page addChild:image z:1 tag: val];        
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"omnivore"])
    {
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[1];
            NSString *data3= [data2 substringWithRange: NSMakeRange (0,1)];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"O" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                  
                [page addChild:image z:1 tag: val];           
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"carnivore"])
    {
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[1];
            NSString *data3= [data2 substringWithRange: NSMakeRange (0,1)];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"C" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];      
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"foodC1"])
    {
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data3 = data1[2];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"1" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"foodC2"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data3 = data1[2];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"2" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"foodC3"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data3 = data1[2];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"3" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];  
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"scale1"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data3 = data1[3];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"1" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"scale2"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data3 = data1[3];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"2" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];   
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"scale3"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data3 = data1[3];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"3" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                
                [page addChild:image z:1 tag: val];      
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"scale4"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data3 = data1[3];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"4" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"scale5"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data3 = data1[3];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"5" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"scale6"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data3 = data1[3];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"6" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                
                [page addChild:image z:1 tag: val]; 
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"scale7"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data3 = data1[3];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"7" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"scale8"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data3 = data1[3];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"8" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"scale9"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data3 = data1[3];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"9" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"point1"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data3 = data1[4];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"1" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                    
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"point2"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data3 = data1[4];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"2" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"point3"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data3 = data1[4];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"3" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                  
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"point4"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data3 = data1[4];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"4" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"point5"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data3 = data1[4];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"5" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];  
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"point6"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data3 = data1[4];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"6" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"point7"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data3 = data1[4];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"7" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"point8"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data3 = data1[4];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"8" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"point9"])
    {
        
        NSMutableArray *data = [self getData];
        NSLog(@"Data count: %i", [data count]);
        for (int i = 0; i<= ([data count]-1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data3 = data1[4];
            NSLog (@"firstL = %@", data3);
            if ([data3 isEqualToString:@"9" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testCalling)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
        }
    }
    else if ([a isEqual: @"desert"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[5];
            NSString *data3= [data2 substringWithRange: NSMakeRange (0,1)];
            if ([data3 isEqualToString:@"D" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"freshwater"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[5];
            NSString *data3= [data2 substringWithRange: NSMakeRange (0,1)];
            if ([data3 isEqualToString:@"F" ]) {
                NSString *data4= [data2 substringWithRange:NSMakeRange(0, 2)];
                if ([data4 isEqualToString:@"Fr"]) {
                    NSLog(@"lastL = %@", data1[8]);
                    int val = [data1[8] intValue];
                    NSLog(@"Name of the picture = %d", val);
                    page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                    NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                    image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                    image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                    [image setScale: (float) 100 / 407]; image.tag = i;
                    [page addChild:image z:1 tag: val];   
                    [cardsOnHand addObject:page];
                }
            }
        }
    }
    else if ([a isEqual: @"forest"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[5];
            NSString *data3= [data2 substringWithRange: NSMakeRange (0,1)];
            if ([data3 isEqualToString:@"F" ]) {
                NSString *data4= [data2 substringWithRange:NSMakeRange(0, 2)];
                if ([data4 isEqualToString:@"Fo"]) {
                    NSLog(@"lastL = %@", data1[8]);
                    int val = [data1[8] intValue];
                    NSLog(@"Name of the picture = %d", val);
                    page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                    NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                    image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                    image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                    [image setScale: (float) 100 / 407]; image.tag = i;
                    [page addChild:image z:1 tag: val];
                    [cardsOnHand addObject:page];
                }
            }
        }
    }
    else if ([a isEqual: @"grassland"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[5];
            NSString *data3= [data2 substringWithRange: NSMakeRange (0,1)];
            if ([data3 isEqualToString:@"G" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"ocean"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[5];
            NSString *data3= [data2 substringWithRange: NSMakeRange (0,1)];
            if ([data3 isEqualToString:@"O" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];   
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"tundra"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[5];
            NSString *data3= [data2 substringWithRange: NSMakeRange (0,1)];
            if ([data3 isEqualToString:@"T" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"urban"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[5];
            NSString *data3= [data2 substringWithRange: NSMakeRange (0,1)];
            if ([data3 isEqualToString:@"U" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
            
        }
    }
    else if ([a isEqual: @"event"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[6];
            NSString *data3= [data2 substringWithRange: NSMakeRange (0,1)];
                if ([data3 isEqualToString:@"E" ]) {
                    NSLog(@"lastL = %@", data1[8]);
                    int val = [data1[8] intValue];
                    NSLog(@"Name of the picture = %d", val);
                    page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                    NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                    image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                    image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                    [image setScale: (float) 100 / 407]; image.tag = i;
                    [page addChild:image z:1 tag: val];
                    [cardsOnHand addObject:page];
                }
            
        }
    }
    else if ([a isEqual: @"mammal"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[6];
            NSString *data3= [data2 substringWithRange: NSMakeRange (0,1)];
                if ([data3 isEqualToString:@"M" ]) {
                    NSString *data4=[data2 substringWithRange:NSMakeRange(0, 2)];
                    if ([data4 isEqualToString:@"Ma"])
                    {
                        NSLog(@"lastL = %@", data1[8]);
                        int val = [data1[8] intValue];
                        NSLog(@"Name of the picture = %d", val);
                        page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                        NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                        image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                        image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                        [image setScale: (float) 100 / 407]; image.tag = i;
                        [page addChild:image z:1 tag: val];
                        [cardsOnHand addObject:page];
                    }
                }
            
        }
    }
    else if ([a isEqual: @"plant"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[6];
            NSString *data3= [data2 substringWithRange: NSMakeRange (0,1)];
                if ([data3 isEqualToString:@"P" ]) {
                    NSLog(@"lastL = %@", data1[8]);
                    int val = [data1[8] intValue];
                    NSLog(@"Name of the picture = %d", val);
                    page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                    NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                    image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                    image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                    [image setScale: (float) 100 / 407]; image.tag = i;
                    [page addChild:image z:1 tag: val];
                    [cardsOnHand addObject:page];
                }
            
        }
    }
    else if ([a isEqual: @"bird"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[6];
            NSString *data3= [data2 substringWithRange: NSMakeRange (0,1)];
                if ([data3 isEqualToString:@"B" ]) {
                    NSLog(@"lastL = %@", data1[8]);
                    int val = [data1[8] intValue];
                    NSLog(@"Name of the picture = %d", val);
                    page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                    NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                    image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                    image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                    [image setScale: (float) 100 / 407]; image.tag = i;
                    [page addChild:image z:1 tag: val];
                    [cardsOnHand addObject:page];
                }
            
        }
    }
    else if ([a isEqual: @"cephalopod"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[6];
            NSString *data3= [data2 substringWithRange: NSMakeRange (0,1)];
                if ([data3 isEqualToString:@"C" ]) {
                    NSLog(@"lastL = %@", data1[8]);
                    int val = [data1[8] intValue];
                    NSLog(@"Name of the picture = %d", val);
                    page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                    NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                    image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                    image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                    [image setScale: (float) 100 / 407]; image.tag = i;
                    [page addChild:image z:1 tag: val];
                    [cardsOnHand addObject:page];
                }
            
        }
    }
    else if ([a isEqual: @"reptile"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[6];
            NSString *data3= [data2 substringWithRange: NSMakeRange (0,1)];
                if ([data3 isEqualToString:@"R" ]) {
                    NSLog(@"lastL = %@", data1[8]);
                    int val = [data1[8] intValue];
                    NSLog(@"Name of the picture = %d", val);
                    page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                    NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                    image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                    image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                    // The card dimensions are 264 * 407 (Width * Height)
                    [image setScale: (float) 100 / 407]; image.tag = i;
                    [page addChild:image z:1 tag: val];
                    [cardsOnHand addObject:page];
                }
            
        }
    }
    else if ([a isEqual: @"fish"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[6];
            NSString *data3= [data2 substringWithRange: NSMakeRange (0,1)];
            if ([data3 isEqualToString:@"F" ]) {
                NSString *data4 = [data2 substringWithRange:NSMakeRange(0, 2)];
                if ([data4 isEqualToString:@"Fi"]) {
                    NSLog(@"lastL = %@", data1[8]);
                    int val = [data1[8] intValue];
                    NSLog(@"Name of the picture = %d", val);
                    page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                    NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                    image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                    image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                    [image setScale: (float) 100 / 407]; image.tag = i;
                    [page addChild:image z:1 tag: val];
                    [cardsOnHand addObject:page];
                }
                }
            
        }
    }
    else if ([a isEqual: @"insect"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[6];
            NSString *data3= [data2 substringWithRange: NSMakeRange (0,1)];
                if ([data3 isEqualToString:@"I" ]) {
                    NSLog(@"lastL = %@", data1[8]);
                    int val = [data1[8] intValue];
                    NSLog(@"Name of the picture = %d", val);
                    page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                    NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                    image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                    image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                    [image setScale: (float) 100 / 407]; image.tag = i;
                    [page addChild:image z:1 tag: val];
                    [cardsOnHand addObject:page];
                }
            
        }
    }
    else if ([a isEqual: @"spider"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[6];
            NSString *data3= [data2 substringWithRange: NSMakeRange (0,1)];
            if ([data3 isEqualToString:@"S" ]) {
                NSString *data4=[data2 substringWithRange:NSMakeRange(0, 2)];
                if ([data4 isEqualToString:@"Sp"]) {
                    int val = [data1[8] intValue];
                    NSLog(@"Name of the picture = %d", val);
                    page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                    NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                    image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                    image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                    [image setScale: (float) 100 / 407]; image.tag = i;
                    [page addChild:image z:1 tag: val];
                    [cardsOnHand addObject:page];
                }
                }
            
        }
    }
    else if ([a isEqual: @"fungi"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[6];
            NSString *data3= [data2 substringWithRange: NSMakeRange (0,1)];
                if ([data3 isEqualToString:@"F" ]) {
                    NSString *data4 = [data2 substringWithRange:NSMakeRange(0, 2)];
                    if ([data4 isEqualToString:@"Fu"])
                    {
                        NSLog(@"lastL = %@", data1[8]);
                        int val = [data1[8] intValue];
                        NSLog(@"Name of the picture = %d", val);
                        page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                        NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                        image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                        image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                        [image setScale: (float) 100 / 407]; image.tag = i;
                        [page addChild:image z:1 tag: val];
                        [cardsOnHand addObject:page];
                    }
                }
            
        }
    }
    else if ([a isEqual: @"microbe"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[6];
            NSString *data3= [data2 substringWithRange: NSMakeRange (0,1)];
                if ([data3 isEqualToString:@"M" ]) {
                    NSString *data4= [data2 substringWithRange: NSMakeRange(0, 2)];
                    if ([data4 isEqualToString:@"Mi"])
                    {
                        NSLog(@"lastL = %@", data1[8]);
                        int val = [data1[8] intValue];
                        NSLog(@"Name of the picture = %d", val);    
                        page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                        NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                        image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                        image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                        [image setScale: (float) 100 / 407]; image.tag = i;
                        [page addChild:image z:1 tag: val];
                        [cardsOnHand addObject:page];
                    }
                }
            
        }
    }
    else if ([a isEqual: @"starters"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[6];
            NSString *data3= [data2 substringWithRange: NSMakeRange (0,1)];
                if ([data3 isEqualToString:@"S" ]) {
                    NSString *data4=[data2 substringWithRange:NSMakeRange(0, 2)];
                    if ([data4 isEqualToString:@"St"]) {
                        NSLog(@"lastL = %@", data1[8]);
                        int val = [data1[8] intValue];
                        NSLog(@"Name of the picture = %d", val);
                        page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                        NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                        image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                        image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                        [image setScale: (float) 100 / 407]; image.tag = i;
                        [page addChild:image z:1 tag: val];
                        [cardsOnHand addObject:page];
                    }
                }
            
        }
    }
    else if ([a isEqual: @"habitat"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[6];
            NSString *data3= [data2 substringWithRange: NSMakeRange (0,1)];
                if ([data3 isEqualToString:@"H" ]) {
                    NSLog(@"lastL = %@", data1[8]);
                    int val = [data1[8] intValue];
                    NSLog(@"Name of the picture = %d", val);
                    page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                    NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                    image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                    image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                    [image setScale: (float) 100 / 407]; image.tag = i;
                    [page addChild:image z:1 tag: val];
                    [cardsOnHand addObject:page];
                }
            
        }
    }
    else if ([a isEqual: @"cold"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[7];
            NSString *data3 = [data2 substringWithRange: NSMakeRange (0,1)];
            if ([data3 isEqualToString:@"C" ]) {
                NSString *data4 = [data2 substringWithRange:NSMakeRange(0, 3)];
                if ([data4 isEqualToString:@"Col"]) {
                    NSLog(@"lastL = %@", data1[8]);
                    int val = [data1[8] intValue];
                    NSLog(@"Name of the picture = %d", val);
                    page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                    NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                    image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                    image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                    [image setScale: (float) 100 / 407]; image.tag = i;                
                    [page addChild:image z:1 tag: val];
                    [cardsOnHand addObject:page];
                }
            }
        }
    }
    else if ([a isEqual: @"cool"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[7];
            NSString *data3 = [data2 substringWithRange: NSMakeRange (0,1)];
            if ([data3 isEqualToString:@"C" ]) {;
                NSString *data4 = [data2 substringWithRange:NSMakeRange(0, 3)];
                if ([data4 isEqualToString:@"Coo"]) {
                    NSLog(@"lastL = %@", data1[8]);
                    int val = [data1[8] intValue];
                    NSLog(@"Name of the picture = %d", val);
                    page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                    NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                    image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                    image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                    [image setScale: (float) 100 / 407]; image.tag = i;                
                    [page addChild:image z:1 tag: val];
                    [cardsOnHand addObject:page];
                }
            }
            
        }
    }
    else if ([a isEqual: @"warm"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[7];
            NSString *data3 = [data2 substringWithRange: NSMakeRange (0,1)];
            if ([data3 isEqualToString:@"W" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407]; image.tag = i;                
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
        }
    }
    else if ([a isEqual: @"hot"])
    {
        
        NSMutableArray *data = [self getData];
        for (int i = 0; i<= ([data count] - 1); i++) {
            NSArray *data1 = [data[i] componentsSeparatedByString:@";"];
            NSString *data2 = data1[7];
            NSString *data3 = [data2 substringWithRange: NSMakeRange (0,1)];
            if ([data3 isEqualToString:@"H" ]) {
                NSLog(@"lastL = %@", data1[8]);
                int val = [data1[8] intValue];
                NSLog(@"Name of the picture = %d", val);
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", val, @".png"];
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testCalling)];
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                [image setScale: (float) 100 / 407];                
                [page addChild:image z:1 tag: val];
                [cardsOnHand addObject:page];
            }
        }
    }
    [scroller updateItems:cardsOnHand];
}

-(void)itemsScroller:(ItemsScroller *)sender didSelectItemIndex:(int)index{
    NSLog(@"Select Bottom %d Card", index);
    selected_card_index = index;
}

-(void)testCalling
{
    NSLog(@"Test Calling");
}

- (NSMutableArray *) getData {
    NSString *file = [[NSBundle mainBundle] pathForResource:@"AnimalData" ofType:@"txt"];
    NSString *content = [[NSString alloc] initWithContentsOfFile:file
                                                    usedEncoding:nil
                                                           error:nil];
    NSArray *data = [content componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"]];
    NSMutableArray *fixed = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < ([data count] - 1); i++ ){
        if (!(i%2)){
            [fixed addObject:data[i]];
        }
    }
    return fixed;
}

-(void)onEnter {
    [super onEnter];
    self.doubleTapRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)] autorelease];
    _doubleTapRecognizer.numberOfTapsRequired = 2;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:_doubleTapRecognizer];
}

-(void)handleDoubleTap:(UITapGestureRecognizer *)doubleTapRecognizer {
    CCLOG(@"Double Tap!");
    tapLocation = [doubleTapRecognizer locationInView:doubleTapRecognizer.view];
    tapLocation.y = 768 - tapLocation.y;
    NSLog(@"Tap Loc X = %f, Tap Loc Y = %f", tapLocation.x, tapLocation.y);
    
    bool tapBottomPlayerHand = CGRectContainsPoint(CGRectMake(10, 20, 1014, 155), tapLocation);
    
    if(tapBottomPlayerHand) {
        [self addCardToTablewithstring:@"Yes"];
    }
}
-(void) addCardToTablewithstring:(NSString*)a
{
    if ([a isEqualToString:@"No"]) {
        [self removeAllChildrenWithCleanup:YES];
        xWay1=0;
        xWay2=0;
        xWay3=0;
        xWay4=0;
        numberSelect=0;
    }
    else
    {
    CCLOG(@"Tapped at the bottom!");
    int selectedCardIndex = [scroller doubleTap:tapLocation];
    
    if(selectedCardIndex != -1) {
        SelectableItem* itemToBeRemoved = nil;
        itemToBeRemoved = [cardsOnHand objectAtIndex:selectedCardIndex];
        if(itemToBeRemoved != nil) {
            int cardIndex = -1;
            for(int i = 0; i < 1000; i++) {
                if([itemToBeRemoved getChildByTag:i] != nil) {
                    NSLog(@"The card index to be eliminated is %d", i);
                    cardIndex = i;
                    break;
                }
            }
            if(cardIndex != -1) {
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", cardIndex, @".png"];
                CCSprite *card = [CCSprite spriteWithFile:card_imageName];
                if (numberSelect<=8) {
                    card.position = ccp(94+xWay1, 510);
                    card.scale = 0.4;
                    xWay1=xWay1+104;
                }
                else if (9<=numberSelect && numberSelect<=17)
                {
                    card.position = ccp(94+xWay2, 430);
                    card.scale = 0.4;
                    xWay2=xWay2+104;
                }
                else if (18<=numberSelect && numberSelect<=26)
                {
                    card.position = ccp(94+xWay3, 350);
                    card.scale = 0.4;
                    xWay3=xWay3+104;
                }
                else if (27<=numberSelect && numberSelect<=35)
                {
                    card.position = ccp(94+xWay4, 270);
                    card.scale = 0.4;
                    xWay4=xWay4+104;
                }
                if (numberSelect >= 36)
                {
                    [self showAlertView];
                }
                else
                {
                    [cardsOnTable insertObject:card atIndex:numberSelect];
                    [self addChild:card z:-1];
                    numberSelect=numberSelect+1;
                }
                
                
            }
            [scroller updateItems:cardsOnHand];
        } else {
            NSLog(@"[GameTable : handleDoubleTap] item removed is nil (Nothing is selected)");
        }
        }
    }
}

-(void) showAlertView
{
	NSLog(@"Creating alert view ...");
	
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Deck Is Full"
														message:@"Please Create A New Deck!"
													   delegate:self
											  cancelButtonTitle:@"Back"
											  otherButtonTitles:@"OK", nil];
	[alertView show];
}
- (void) SetBotMenu
{
    NSLog(@"Setting up the main menu in the bot");
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    CCMenuItemImage *alphabetic = [CCMenuItemImage itemWithNormalImage:@"alphabetic.png" selectedImage:@"alphabetic.png" target:self selector:@selector(alphabeticMenuSet)];
    CCMenuItemImage *diet = [CCMenuItemImage itemWithNormalImage:@"diet.png" selectedImage:@"diet.png" target:self selector:@selector(dietMenuSet)];
    CCMenuItemImage *foodChain = [CCMenuItemImage itemWithNormalImage:@"foodChain.png" selectedImage:@"foodChain.png" target:self selector:@selector(foodChainMenuSet)];
    CCMenuItemImage *scale = [CCMenuItemImage itemWithNormalImage:@"scale.png" selectedImage:@"scale.png" target:self selector:@selector(scaleMenuSet)];
    CCMenuItemImage *points = [CCMenuItemImage itemWithNormalImage:@"points.png" selectedImage:@"points.png" target:self selector:@selector(pointsMenuSet)];
    CCMenuItemImage *terrain = [CCMenuItemImage itemWithNormalImage:@"terrain.png" selectedImage:@"terrain.png" target:self selector:@selector(terrainMenuSet)];
    CCMenuItemImage *evolutionTree = [CCMenuItemImage itemWithNormalImage:@"evolutionTree.png" selectedImage:@"evolutionTree.png" target:self selector:@selector(evolutionTreeMenuSet)];
    CCMenuItemImage *climate = [CCMenuItemImage itemWithNormalImage:@"climate.png" selectedImage:@"climate.png" target:self selector:@selector(climateMenuSet)];
    CCMenu *BotMenu = [CCMenu menuWithItems:alphabetic,diet,foodChain,scale,points,terrain,evolutionTree,climate, nil];
    [BotMenu alignItemsHorizontallyWithPadding:-5];
    BotMenu.position = ccp(screenSize.width/2, 150);
    [self addChild:BotMenu];
    
}

- (void) alphabeticMenuSet
{
    NSLog(@"show the menu of the alphabetic");
    CCMenuItem *a_d = [CCMenuItemImage itemWithNormalImage:@"a-d.png" selectedImage:@"a-d.png" target:self selector:@selector(a_dArray)];
    CCMenuItem *e_k = [CCMenuItemImage itemWithNormalImage:@"e-k.png" selectedImage:@"e-k.png" target:self selector:@selector(e_kArray)];
    CCMenuItem *l_q = [CCMenuItemImage itemWithNormalImage:@"l-q.png" selectedImage:@"l-q.png" target:self selector:@selector(l_qArray)];
    CCMenuItem *r_z = [CCMenuItemImage itemWithNormalImage:@"r-z.png" selectedImage:@"r-z.png" target:self selector:@selector(r_zArray)];
    CCMenu *pointsMenu = [CCMenu menuWithItems:a_d,e_k,l_q,r_z, nil];
    [pointsMenu alignItemsVerticallyWithPadding:-10];
    pointsMenu.position = ccp(70, 240);
    if (checkalephabetic == false)
    {
        [self addChild:pointsMenu z:+1 tag: 1];
        checkalephabetic=true;
    }
    else
    {
        [self removeChildByTag:1 cleanup:YES];
        checkalephabetic=false;
    }
    
    
}

- (void) dietMenuSet
{
    NSLog(@"show the menu of the diet");
    CCMenuItem *photosynthetic = [CCMenuItemImage itemWithNormalImage:@"photosynthetic.png" selectedImage:@"photosynthetic.png" target:self selector:@selector(photosyntheticArray)];
    CCMenuItem *molecular = [CCMenuItemImage itemWithNormalImage:@"molecular.png" selectedImage:@"molecular.png" target:self selector:@selector(molecularArray)];
    CCMenuItem *herbivore = [CCMenuItemImage itemWithNormalImage:@"herbivore.png" selectedImage:@"herbivore.png" target:self selector:@selector(herbivoreArray)];
    CCMenuItem *omnivore = [CCMenuItemImage itemWithNormalImage:@"omnivore.png" selectedImage:@"omnivore.png" target:self selector:@selector(omnivoreArray)];
    CCMenuItem *carnivore = [CCMenuItemImage itemWithNormalImage:@"carnivore.png" selectedImage:@"carnivore.png" target:self selector:@selector(carnivoreArray)];
    CCMenu *pointsMenu = [CCMenu menuWithItems:photosynthetic,molecular,herbivore,omnivore,carnivore, nil];
    [pointsMenu alignItemsVerticallyWithPadding:-10];
    pointsMenu.position = ccp(197, 259);
    if (diet == false)
    {
        [self addChild:pointsMenu z:+1 tag: 2];
        diet=true;
    }
    else
    {
        [self removeChildByTag:2 cleanup:YES];
        diet=false;
    }
}

- (void) foodChainMenuSet
{
    NSLog(@"show the menu of the foodChain");
    CCMenuItem *foodC1 = [CCMenuItemImage itemWithNormalImage:@"point1.png" selectedImage:@"point1.png" target:self selector:@selector(foodC1Array)];
    CCMenuItem *foodC2 = [CCMenuItemImage itemWithNormalImage:@"point2.png" selectedImage:@"point2.png" target:self selector:@selector(foodC2Array)];
    CCMenuItem *foodC3 = [CCMenuItemImage itemWithNormalImage:@"point3.png" selectedImage:@"point3.png" target:self selector:@selector(foodC3Array)];
    CCMenu *pointsMenu = [CCMenu menuWithItems:foodC1,foodC2,foodC3, nil];
    [pointsMenu alignItemsVerticallyWithPadding:-10];
    pointsMenu.position = ccp(323, 222);
    if (foodChain == false)
    {
        [self addChild:pointsMenu z:+1 tag: 3];
        foodChain=true;
    }
    else
    {
        [self removeChildByTag:3 cleanup:YES];
        foodChain=false;
    }
}

- (void) scaleMenuSet
{
    NSLog(@"show the menu of the points");
    CCMenuItemImage *scale1 = [CCMenuItemImage itemWithNormalImage:@"point1.png" selectedImage:@"point1.png" target:self selector:@selector(scale1Array)];
    CCMenuItemImage *scale2 = [CCMenuItemImage itemWithNormalImage:@"point2.png" selectedImage:@"point2.png" target:self selector:@selector(scale2Array)];
    CCMenuItemImage *scale3 = [CCMenuItemImage itemWithNormalImage:@"point3.png" selectedImage:@"point3.png" target:self selector:@selector(scale3Array)];
    CCMenuItemImage *scale4 = [CCMenuItemImage itemWithNormalImage:@"point4.png" selectedImage:@"point4.png" target:self selector:@selector(scale4Array)];
    CCMenuItemImage *scale5 = [CCMenuItemImage itemWithNormalImage:@"point5.png" selectedImage:@"point5.png" target:self selector:@selector(scale5Array)];
    CCMenuItemImage *scale6 = [CCMenuItemImage itemWithNormalImage:@"point6.png" selectedImage:@"point6.png" target:self selector:@selector(scale6Array)];
    CCMenuItemImage *scale7 = [CCMenuItemImage itemWithNormalImage:@"point7.png" selectedImage:@"point7.png" target:self selector:@selector(scale7Array)];
    CCMenuItemImage *scale8 = [CCMenuItemImage itemWithNormalImage:@"point8.png" selectedImage:@"point8.png" target:self selector:@selector(scale8Array)];
    CCMenuItemImage *scale9 = [CCMenuItemImage itemWithNormalImage:@"point9.png" selectedImage:@"point9.png" target:self selector:@selector(scale9Array)];
    CCMenu *pointsMenu = [CCMenu menuWithItems:scale1,scale2,scale3,scale4,scale5,scale6,scale7,scale8,scale9,nil];
    [pointsMenu alignItemsVerticallyWithPadding:-10];
    pointsMenu.position = ccp(449, 333);
    if (scale == false)
    {
        [self addChild:pointsMenu z:+1 tag: 4];
        scale=true;
    }
    else
    {
        [self removeChildByTag:4 cleanup:YES];
        scale=false;
    }
}

- (void) pointsMenuSet
{
    NSLog(@"show the menu of the points");
    CCMenuItemImage *point1 = [CCMenuItemImage itemWithNormalImage:@"point1.png" selectedImage:@"point1.png" target:self selector:@selector(point1Array)];
    CCMenuItemImage *point2 = [CCMenuItemImage itemWithNormalImage:@"point2.png" selectedImage:@"point2.png" target:self selector:@selector(point2Array)];
    CCMenuItemImage *point3 = [CCMenuItemImage itemWithNormalImage:@"point3.png" selectedImage:@"point3.png" target:self selector:@selector(point3Array)];
    CCMenuItemImage *point4 = [CCMenuItemImage itemWithNormalImage:@"point4.png" selectedImage:@"point4.png" target:self selector:@selector(point4Array)];
    CCMenuItemImage *point5 = [CCMenuItemImage itemWithNormalImage:@"point5.png" selectedImage:@"point5.png" target:self selector:@selector(point5Array)];
    CCMenuItemImage *point6 = [CCMenuItemImage itemWithNormalImage:@"point6.png" selectedImage:@"point6.png" target:self selector:@selector(point6Array)];
    CCMenuItemImage *point7 = [CCMenuItemImage itemWithNormalImage:@"point7.png" selectedImage:@"point7.png" target:self selector:@selector(point7Array)];
    CCMenuItemImage *point8 = [CCMenuItemImage itemWithNormalImage:@"point8.png" selectedImage:@"point8.png" target:self selector:@selector(point8Array)];
    CCMenuItemImage *point9 = [CCMenuItemImage itemWithNormalImage:@"point9.png" selectedImage:@"point9.png" target:self selector:@selector(point9Array)];
    CCMenu *pointsMenu = [CCMenu menuWithItems:point1,point2,point3,point4,point5,point6,point7,point8,point9, nil];
    [pointsMenu alignItemsVerticallyWithPadding:-10];
    pointsMenu.position = ccp(575, 333);
    if (checkPoints == false)
    {
        [self addChild:pointsMenu z:+1 tag:5];
        checkPoints=true;
    }
    else
    {
        [self removeChildByTag:5 cleanup:YES];
        checkPoints=false;
    }
}

- (void) terrainMenuSet
{
    NSLog(@"show the menu of the points");
    CCMenuItemImage *desert = [CCMenuItemImage itemWithNormalImage:@"desert.png" selectedImage:@"desert.png" target:self selector:@selector(desertArray)];
    CCMenuItemImage *freshwater = [CCMenuItemImage itemWithNormalImage:@"freshwater.png" selectedImage:@"freshwater.png" target:self selector:@selector(freshwaterArray)];
    CCMenuItemImage *forest = [CCMenuItemImage itemWithNormalImage:@"forest.png" selectedImage:@"forest.png" target:self selector:@selector(forestArray)];
    CCMenuItemImage *grassland = [CCMenuItemImage itemWithNormalImage:@"grassland.png" selectedImage:@"grassland.png" target:self selector:@selector(grasslandArray)];
    CCMenuItemImage *ocean = [CCMenuItemImage itemWithNormalImage:@"ocean.png" selectedImage:@"ocean.png" target:self selector:@selector(oceanArray)];
    CCMenuItemImage *tundra = [CCMenuItemImage itemWithNormalImage:@"tundra.png" selectedImage:@"tundra.png" target:self selector:@selector(tundraArray)];
    CCMenuItemImage *urban = [CCMenuItemImage itemWithNormalImage:@"urban.png" selectedImage:@"urban.png" target:self selector:@selector(urbanArray)];
    CCMenu *pointsMenu = [CCMenu menuWithItems:desert,freshwater,forest,grassland,ocean,tundra,urban, nil];
    [pointsMenu alignItemsVerticallyWithPadding:-10];
    pointsMenu.position = ccp(701, 296);
    if (terrain == false)
    {
        [self addChild:pointsMenu z:+1 tag: 6];
        terrain=true;
    }
    else
    {
        [self removeChildByTag:6 cleanup:YES];
        terrain=false;
    }
}

- (void) evolutionTreeMenuSet
{
    NSLog(@"show the menu of the points");
    CCMenuItemImage *event = [CCMenuItemImage itemWithNormalImage:@"event.png" selectedImage:@"event.png" target:self selector:@selector(eventArray)];
    CCMenuItemImage *mammal = [CCMenuItemImage itemWithNormalImage:@"mammal.png" selectedImage:@"mammal.png" target:self selector:@selector(mammalArray)];
    CCMenuItemImage *plant = [CCMenuItemImage itemWithNormalImage:@"plant.png" selectedImage:@"plant.png" target:self selector:@selector(plantArray)];
    CCMenuItemImage *bird = [CCMenuItemImage itemWithNormalImage:@"bird.png" selectedImage:@"bird.png" target:self selector:@selector(birdArray)];
    CCMenuItemImage *cephalopod = [CCMenuItemImage itemWithNormalImage:@"cephalopod.png" selectedImage:@"cephalopod.png" target:self selector:@selector(cephalopodArray)];
    CCMenuItemImage *reptile = [CCMenuItemImage itemWithNormalImage:@"reptile.png" selectedImage:@"reptile.png" target:self selector:@selector(reptileArray)];
    CCMenuItemImage *fish = [CCMenuItemImage itemWithNormalImage:@"fish.png" selectedImage:@"fish.png" target:self selector:@selector(fishArray)];
    CCMenuItemImage *insect = [CCMenuItemImage itemWithNormalImage:@"insect.png" selectedImage:@"insect.png" target:self selector:@selector(insectArray)];
    CCMenuItemImage *spider = [CCMenuItemImage itemWithNormalImage:@"spider.png" selectedImage:@"spider.png" target:self selector:@selector(spiderArray)];
    CCMenuItemImage *fungi = [CCMenuItemImage itemWithNormalImage:@"fungi.png" selectedImage:@"fungi.png" target:self selector:@selector(fungiArray)];
    CCMenuItemImage *microbe = [CCMenuItemImage itemWithNormalImage:@"microbe.png" selectedImage:@"microbe.png" target:self selector:@selector(microbeArray)];
    CCMenuItemImage *starters = [CCMenuItemImage itemWithNormalImage:@"starters.png" selectedImage:@"starters.png" target:self selector:@selector(startersArray)];
    CCMenuItemImage *habitat = [CCMenuItemImage itemWithNormalImage:@"habitat.png" selectedImage:@"habitat.png" target:self selector:@selector(habitatArray)];
    CCMenu *pointsMenu = [CCMenu menuWithItems:event,mammal,plant,bird,cephalopod,reptile,fish,insect,spider,fungi,microbe,starters,habitat, nil];
    [pointsMenu alignItemsVerticallyWithPadding:-10];
    pointsMenu.position = ccp(827, 407);
    if (evolutionTree == false)
    {
        [self addChild:pointsMenu z:+1 tag: 7];
        evolutionTree=true;
    }
    else
    {
        [self removeChildByTag:7 cleanup:YES];
        evolutionTree=false;
    }
}

- (void) climateMenuSet
{
    NSLog(@"show the menu of the diet");
    CCMenuItem *cold = [CCMenuItemImage itemWithNormalImage:@"cold.png" selectedImage:@"cold.png" target:self selector:@selector(coldArray)];
    CCMenuItem *cool = [CCMenuItemImage itemWithNormalImage:@"cool.png" selectedImage:@"cool.png" target:self selector:@selector(coolArray)];
    CCMenuItem *warm = [CCMenuItemImage itemWithNormalImage:@"warm.png" selectedImage:@"warm.png" target:self selector:@selector(warmArray)];
    CCMenuItem *hot = [CCMenuItemImage itemWithNormalImage:@"hot.png" selectedImage:@"hot.png" target:self selector:@selector(hotArray)];
    CCMenu *pointsMenu = [CCMenu menuWithItems:cold,cool,warm,hot, nil];
    [pointsMenu alignItemsVerticallyWithPadding:-10];
    pointsMenu.position = ccp(953, 240);
    if (climate == false)
    {
        [self addChild:pointsMenu z:+1 tag: 8];
        climate=true;
    }
    else
    {
        [self removeChildByTag:8 cleanup:YES];
        climate=false;
    }
}

- (void)selectSpriteForTouch:(CGPoint)touchLocation {
    CCSprite * newSprite = nil;
    for (CCSprite *sprite in movableSprites) {
        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) {
            newSprite = sprite;
            break;
        }
    }
    if (newSprite != selSprite) {
        [selSprite stopAllActions];
        selSprite = newSprite;
    }
}

- (void) a_dArra
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"a_d"];
    
}

- (void) e_kArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"e_k"];
    
}

- (void) l_qArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"l_q"];
    
}
- (void) r_zArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"r_z"];
    
}
- (void) photosyntheticArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"photosynthetic"];
    
}
- (void) molecularArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"molecular"];
    
}
- (void) herbivoreArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"herbivore"];
    
}
- (void) omnivoreArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"omnivore"];
    
}
- (void) carnivoreArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"carnivore"];
    
}
- (void) foodC1Array
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"foodC1"];
    
}
- (void) foodC2Array
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"foodC2"];
    
}
- (void) foodC3Array
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"foodC3"];
    
}
- (void) scale1Array
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"scale1"];
    
}
- (void) scale2Array
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"scale2"];
    
}
- (void) scale3Array
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"scale3"];
    
}
- (void) scale4Array
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"scale4"];
    
}
- (void) scale5Array
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"scale5"];
    
}
- (void) scale6Array
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"scale6"];
    
}
- (void) scale7Array
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"scale7"];
    
}
- (void) scale8Array
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"scale8"];
    
}
- (void) scale9Array
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"scale9"];
    
}
- (void) point1Array
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"point1"];
    
}
- (void) point2Array
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"point2"];
    
}
- (void) point3Array
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"point3"];
    
}
- (void) point4Array
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"point4"];
    
}
- (void) point5Array
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"point5"];
    
}
- (void) point6Array
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"point6"];
    
}
- (void) point7Array
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"point7"];
    
}
- (void) point8Array
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"point8"];
    
}
- (void) point9Array
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"point9"];
    
}
- (void) desertArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"desert"];
    
}
- (void) freshwaterArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"freshwater"];
    
}
- (void) forestArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"forest"];
    
}
- (void) grasslandArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"grassland"];
    
}
- (void) oceanArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"ocean"];
    
}
- (void) tundraArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"tundra"];
    
}
- (void) urbanArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"urban"];
    
}
- (void) eventArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"event"];
    
}
- (void) mammalArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"mammal"];
    
}
- (void) plantArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"plant"];
    
}
- (void) birdArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"bird"];
    
}
- (void) cephalopodArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"cephalopod"];
    
}
- (void) reptileArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"reptile"];
    
}
- (void) fishArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"fish"];
    
}
- (void) insectArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"insect"];
    
}

- (void) spiderArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"spider"];
    
}
- (void) fungiArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"fungi"];
    
}
- (void) microbeArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"microbe"];
    
}
- (void) startersArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"starters"];
    
}
- (void) habitatArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"habitat"];
    
}
- (void) coldArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"cold"];
    
}
- (void) coolArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"cool"];
    
}
- (void) warmArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"warm"];
    
}
- (void) hotArray
{
    //[pBot testCalling];
    [self addCardScrollerwithstring:@"hot"];
    
}


@end