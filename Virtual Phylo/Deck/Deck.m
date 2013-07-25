//
//  Deck.m
//  Virtual Phylo
//
//  Created by Brandon Wong on 2013-06-26.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import "Deck.h"

@implementation Deck

bool checkPoints=false;
bool checkalephabetic=false;
bool diet=false;
bool foodChain=false;
bool scale=false;
bool climate=false;
bool terrain=false;
bool evolutionTree=false;

// (Roger) Add Synthesization
@synthesize deckCards;
@synthesize deckName;

+ (CCScene *) scene
{
    CCScene *scene = [CCScene node];
    Deck *layer = [Deck node];
    [scene addChild:layer];
    return scene;
}
// (Roger) init method as usual
- (id) init
{
    if (self = [super init])
    {
        NSLog(@"Deck Initialization");
        [self setBackground];
        [self setTopLMenu];
        [self setTopRMenu];
        [self setTopMMenu];
        [self SetBotMenu];
        
    }
    
    return self;
    
}

- (void) setBackground
{
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    background = [CCSprite spriteWithFile:@"greenDeck.jpg"];
    background.scale=0.8;
    background.position = ccp(screenSize.width/2, screenSize.height/2);
    [self addChild:background z:-1];
    
    CCSprite *lowerPlayerHand = [CCSprite spriteWithFile:@"deckHand.png"];
    lowerPlayerHand.position = ccp(screenSize.width/2, 65);
    [self addChild:lowerPlayerHand];
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

- (void)renameDeckSet
{
//    [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(renameDeck) userInfo:nil repeats:NO];
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
    [self addChild:renameDeckPicture];
    [self addRename];
    self.touchEnabled = YES;
}

- (void) addRename
{
    UIView *glView = [CCDirector sharedDirector].view;
    [glView addSubview:alphabeticMenuField];
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
    CCMenuItem *yellow = [CCMenuItemImage itemWithNormalImage:@"yellow.png" selectedImage:@"yellow.png" target:self selector:@selector(yellowArray)];
    CCMenuItem *black = [CCMenuItemImage itemWithNormalImage:@"black.png" selectedImage:@"black.png" target:self selector:@selector(blackArray)];
    CCMenuItem *green = [CCMenuItemImage itemWithNormalImage:@"green.png" selectedImage:@"green.png" target:self selector:@selector(greenArray)];
    CCMenuItem *brown = [CCMenuItemImage itemWithNormalImage:@"brown.png" selectedImage:@"brown.png" target:self selector:@selector(brownArray)];
    CCMenuItem *red = [CCMenuItemImage itemWithNormalImage:@"red.png" selectedImage:@"red.png" target:self selector:@selector(redArray)];
    CCMenu *pointsMenu = [CCMenu menuWithItems:yellow,black,green,brown,red, nil];
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
    CCMenuItem *foodC3 = [CCMenuItemImage itemWithNormalImage:@"point3.png" selectedImage:@"point3.png" target:self selector:@selector(foodc3Array)];
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
    CCMenu *pointsMenu = [CCMenu menuWithItems:scale1,scale2,scale3,scale4,scale5,scale6, nil];
    [pointsMenu alignItemsVerticallyWithPadding:-10];
    pointsMenu.position = ccp(449, 277);
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
        [self addChild:pointsMenu z:+1 tag: 5];
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


- (void) jumpToMenu
{
    NSLog(@"jump to main menu");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.5 scene:[MainMenuLayer scene]]];
}

- (void) jumpToDefault
{
    NSLog(@"jump to main menu");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.5 scene:[Deck scene]]];

}


 
@end
