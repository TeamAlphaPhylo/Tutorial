//
//  Deck.m
//  Virtual Phylo
//
//  Created by Brandon Wong on 2013-06-26.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import "Deck.h"

@implementation Deck
@synthesize deckCards;
@synthesize deckName;
static SearchIn *pBot1 = nil;
bool renameCheck=false;
bool addRenameCheck=false;

+ (CCScene *) scene
{
    CCScene *scene = [CCScene node];
    
    SearchIn *_pBot = [SearchIn node];
    [scene addChild:_pBot z:1]; // z-index: 1, above the playing fields
    pBot1 = _pBot;
    
    Deck *layer = [Deck node];
    [scene addChild:layer];    
    return scene;
}

- (id) init
{
    if (self = [super init])
    {
        NSLog(@"Deck Initialization");
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        [self setBackground];
        [self setTopLMenu];
        [self setTopRMenu];
        [self setTopMMenu];       
    } 
    return self;
}

- (void) setBackground
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    background = [CCSprite spriteWithFile:@"greenDeck.jpg"];
    background.scale=0.8;
    background.position = ccp(screenSize.width/2, screenSize.height/2);
    [self addChild:background z:-2];
}

- (void) setTopLMenu
{
    NSLog(@"Setting up the main menu in the left at the top");
    CCMenuItemImage *BackMenu = [CCMenuItemImage itemWithNormalImage:@"BackMenu.png" selectedImage:@"BackMenu.png" target:self selector:@selector(jumpToMenu)];
    CCMenuItemImage *NewDeck = [CCMenuItemImage itemWithNormalImage:@"NewDeck.png" selectedImage:@"NewDeck.png" target:self selector:@selector(jumpToNewDeck)];
    CCMenuItemImage *Default = [CCMenuItemImage itemWithNormalImage:@"SetAsDefault.png" selectedImage:@"SetAsDefault.png" target:self selector:@selector(jumpToDefault)];
    CCMenu *TopLMenu1 = [CCMenu menuWithItems: BackMenu, nil];
    CCMenu *TopLMenu2 = [CCMenu menuWithItems: NewDeck,Default, nil];
    [TopLMenu2 alignItemsVerticallyWithPadding:-10];
    TopLMenu1.position = ccp(110,730);
    TopLMenu2.position = ccp(80,650);
    [self addChild: TopLMenu1];
    [self addChild: TopLMenu2];
}

- (void) setTopRMenu
{
    NSLog(@"Setting up the main menu in the right at the top");
    CCMenuItemImage *testUser = [CCMenuItemImage itemWithNormalImage:@"testUser.png" selectedImage:@"testUser.png" target:self selector:@selector(testUser)];
    CCMenuItemImage *clearDeck = [CCMenuItemImage itemWithNormalImage:@"ClearDeck.png" selectedImage:@"ClearDeck.png" target:self selector:@selector(ClearDeck)];
    CCMenuItemImage *renameDeck = [CCMenuItemImage itemWithNormalImage:@"RenameDeck.png" selectedImage:@"RenameDeck.png" target:self selector:@selector(renameDeckSet)];
    CCMenu *TopRMenu1 = [CCMenu menuWithItems: testUser, nil];
    CCMenu *TopRMenu2 = [CCMenu menuWithItems: clearDeck,renameDeck, nil];
    [TopRMenu2 alignItemsVerticallyWithPadding:-10];
    TopRMenu1.position = ccp(913,730);
    TopRMenu2.position = ccp(943,650);
    [self addChild: TopRMenu1];
    [self addChild: TopRMenu2];
}

- (void) setTopMMenu
{
    NSLog(@"Setting up the main menu in the mid at the top");
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    CCMenuItemImage *DeckName = [CCMenuItemImage itemWithNormalImage:@"deckSlider2b.png" selectedImage:@"deckSlider2b.png" target:self selector:@selector(nameOfDeck)];
    CCMenuItemImage *deleteDeck = [CCMenuItemImage itemWithNormalImage:@"DeleteDeck.png" selectedImage:@"DeleteDeck.png" target:self selector:@selector(deleteDeck)];
    CCMenuItemImage *saveDeck = [CCMenuItemImage itemWithNormalImage:@"saveDeck.png" selectedImage:@"saveDeck.png" target:self selector:@selector(saveDeck)];
    CCMenu *TopMMenu1 = [CCMenu menuWithItems: DeckName, nil];
    CCMenu *TopMMenu2 = [CCMenu menuWithItems: deleteDeck,saveDeck, nil];
    [TopMMenu2 alignItemsHorizontallyWithPadding:-10];
    TopMMenu1.position = ccp(screenSize.width/2,690);
    TopMMenu2.position = ccp(screenSize.width/2,645);
    [self addChild: TopMMenu1];
    [self addChild: TopMMenu2];
    
}

- (void)renameDeckSet
{
    [self performSelector:@selector(renameDeck)];
}

- (void)renameDeck
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CGRect renameDeckPostion = CGRectMake(400, 63, 240, 30);
    alphabeticMenuField = [[UITextField alloc] initWithFrame:renameDeckPostion];
    alphabeticMenuField.text = @"Deck Name";
    alphabeticMenuField.borderStyle = UITextBorderStyleRoundedRect;
    alphabeticMenuField.delegate = self;
    
    CCSprite *renameDeckPicture = [CCSprite spriteWithFile:@"deckSlider2.png"];
    renameDeckPicture.position = ccp(winSize.width/2,690);
    if (renameCheck == false)
    {
        [self addChild:renameDeckPicture z:+1 tag: 1];
        [self addRenamewithstring:@"show"];
        renameCheck=true;
    }
    else
    {
        [self removeChildByTag:1 cleanup:YES];
        [self addRenamewithstring:@"No"];
        renameCheck=false;
    }
    //[self addChild:renameDeckPicture];
    //[self addRename];
    self.touchEnabled = YES;
}

- (void) addRenamewithstring:(NSString*)a
{
    if ([a isEqualToString:@"show"])
    {
        glView = [CCDirector sharedDirector].view;
        [glView addSubview:alphabeticMenuField];
    }
    else if([a isEqualToString:@"No"])
    {
        NSArray * subviews = [[CCDirector sharedDirector] view].subviews;
        for (id sv in subviews) {
            [((UIView *)sv) removeFromSuperview];
            [sv release];
        }
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

-(void)itemsScroller:(ItemsScroller *)sender didSelectItemIndex:(int)index{
    NSLog(@"Select Bottom %d Card", index);
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation];
    return TRUE;
}

- (void) jumpToMenu
{
    NSLog(@"jump to main menu");
    NSArray * subviews = [[CCDirector sharedDirector] view].subviews;
    for (id sv in subviews) {
        [((UIView *)sv) removeFromSuperview];
        [sv release];
    }
    [pBot1 addCardToTablewithstring:@"No"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.5 scene:[MainMenuLayer scene]]];
    
    
}

- (void) jumpToDefault
{
    NSLog(@"jump to main menu");
    NSArray * subviews = [[CCDirector sharedDirector] view].subviews;
    for (id sv in subviews) {
        [((UIView *)sv) removeFromSuperview];
        [sv release];
    }
    [pBot1 addCardToTablewithstring:@"No"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.5 scene:[Deck scene]]];

}

@end
