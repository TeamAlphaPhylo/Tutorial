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
//@synthesize initialCheck;
//@synthesize a_dCheck;


-(id) init
{
    if( (self=[super init]) ) {
        
        NSLog(@"the initial cards for the searching");
        // (Roger) Add delegate
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        selected_card_index = 0;


        // (Roger) Add hand scroller
        [self addCardScrollerwithboolean1:YES andBool2:NO andBool3:NO];
        // (Roger) Set up background
        [self setBackground];
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

-(void) addCardScrollerwithboolean1:(BOOL)a andBool2:(BOOL)b andBool3:(BOOL)c {
    NSLog(@"Trying to add CCScroll View.");
    
    // (Roger) First set up a window size holder
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    // (Roger) Setting up an NSMutableArray (To be corporated with CoreData function)
    // (Roger) Storing the Sprite instances
    [page removeChildByTag:10 cleanup:YES];
    [page removeChild:image cleanup:YES];
    NSMutableArray *cardArray = [[NSMutableArray alloc] init];
    if (a == true) {
    //    NSMutableArray *cardArray = [[NSMutableArray alloc] init];
        page = [[SelectableItem alloc] init];
        [cardArray removeAllObjects];
            NSLog(@"initial check");
            [cardArray removeAllObjects];
        
            NSLog(@"array count #:%d",[cardArray count]);
            for (int i = 0; i < 1; i++) {
                
                page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
                
                NSString *card_imageName = [NSString stringWithFormat:@"%d%@", i, @".png"];
                
                image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testCalling)];
    //            NSArray *data = [self getData];
    //            NSLog(data[0]);
    //            NSArray *data1 = [data[0] componentsSeparatedByString:@";"];
    //            NSLog(data1[7]);
    //            NSArray *data2 = [data1[7] componentsSeparatedByString:@","];
    //            NSLog(data2[0]);
    //            NSLog(data2[1]);
                //[self getData];
                
                image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
                // The card dimensions are 264 * 407 (Width * Height)
                [image setScale: (float) 100 / 407];
                
                [page addChild:image];
                [cardArray addObject:page];
            }
    }
    else if (b == true)
    {
        NSLog(@"a_d check");
        [cardArray removeAllObjects];
        //NSMutableArray *cardArray = [[NSMutableArray alloc] init];
        page = [[SelectableItem alloc] init];
        
        for (int i = 0; i < 5; i++) {
            page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
            NSString *card_imageName = [NSString stringWithFormat:@"%d%@", i, @".png"];
            
            image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
            
            image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
            // The card dimensions are 264 * 407 (Width * Height)
            [image setScale: (float) 100 / 407];
            
            [page addChild:image z:1 tag:10];
            
            [cardArray addObject:page];
        }
    }
    else if (c == true)
    {
        NSLog(@"e_k check");
        [cardArray removeAllObjects];
        //NSMutableArray *cardArray = [[NSMutableArray alloc] init];
        page = [[SelectableItem alloc] init];

        for (int i = 0; i < 20; i++) {
            page = [[SelectableItem alloc] initWithNormalColor:ccc4(0,0,0,0) andSelectectedColor:ccc4(190, 150, 150, 255) andWidth:77 andHeight:100];
            
            NSString *card_imageName = [NSString stringWithFormat:@"%d%@", i, @".png"];
            
            image = [CCMenuItemImage itemWithNormalImage:card_imageName selectedImage:card_imageName target:self selector:@selector(testAddingCard)];
            
            image.position = ccp(page.contentSize.width/2, page.contentSize.height/2);
            // The card dimensions are 264 * 407 (Width * Height)
            [image setScale: (float) 100 / 407];
            
            [page addChild:image];
            
            [cardArray addObject:page];
        }
    }

    ItemsScroller *lowerHandScoller = [ItemsScroller itemsScrollerWithItems:cardArray andOrientation:ItemsScrollerHorizontal andRect:CGRectMake(10, 20, winSize.width - 20, 155)];
    //    lowerHandScoller.delegate = self;
    [self addChild:lowerHandScoller z:3];
}



-(void)itemsScroller:(ItemsScroller *)sender didSelectItemIndex:(int)index{
    NSLog(@"Select Bottom %d Card", index);
    selected_card_index = index;
}

-(void)testAddingCard
{
    NSString *card_imageName = [NSString stringWithFormat:@"%d%@", selected_card_index, @".png"];
    CCSprite *card = [CCSprite spriteWithFile:card_imageName];
    card.scale = 0.4;
    card.position = CGPointMake(500, 500);
    [self addChild:card];
}

-(void)testCalling
{
    NSLog(@"Test Calling");
}

- (NSArray *) getData {
    NSString *file = [[NSBundle mainBundle] pathForResource:@"AnimalData" ofType:@"txt"];
    NSString *content = [[NSString alloc] initWithContentsOfFile:file
                                                    usedEncoding:nil
                                                           error:nil];
    NSArray *data = [content componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"]];
    
    //NSLog(@"size is: %lu", (unsigned long)([data count] - 1));
    //NSLog(@"Card data:");
    //Gets a single line of data
    //NSLog(@"%@", data[0]);
    return data;
}



@end