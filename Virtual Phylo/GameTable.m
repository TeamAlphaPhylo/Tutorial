//
//  GameTable.m
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-06.
//  Copyright 2013 Group_12. All rights reserved.
//

#import "GameTable.h"


@implementation GameTable

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
    // (Brandon) PlayerLayers act as layers or regions for the players
    PlayerLayerBot *pBot = [PlayerLayerBot node];
    [scene addChild:pBot z:2];
    
    PlayerLayerTop *pTop = [PlayerLayerTop node];
    [scene addChild:pTop z:1];
    
     
     
	// 'layer' is an autorelease object.
	GameTable *layer = [GameTable node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init//WithPlayer1:(PlayerLayerBot *)pBot Player2:(PlayerLayerTop *)pTop
{
    if( (self=[super init]) ) {
        
        NSLog(@"Game Table Layer Initialization");
        
        //_pBot = pBot;
        //_pTop = pTop;
        // add components created as children to this Layer (Notice there are added in a specific sequence)
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        [self setBackground];
        [self addSprites];
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

// (Brandon) add some card sprites to fool around with
- (void) addSprites {
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    movableSprites = [[NSMutableArray alloc] init];
    NSArray *images = [NSArray arrayWithObjects:@"0.png", @"1.png", @"2.png", @"3.png", nil];
    for(int i = 0; i < images.count; ++i) {
        NSString *image = [images objectAtIndex:i];
        CCSprite *sprite = [CCSprite spriteWithFile:image];
        float offsetFraction = ((float)(i+1))/(images.count+1);
        sprite.position = ccp(winSize.width*offsetFraction, winSize.height/2);
        sprite.scale = 0.3;
        [self addChild:sprite];
        [movableSprites addObject:sprite];
    }
}

// (Brandon) allow touch
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
        [selSprite runAction:[CCRotateTo actionWithDuration:0.1 angle:0]];
        CCRotateTo * rotLeft = [CCRotateBy actionWithDuration:0.1 angle:-4.0];
        CCRotateTo * rotCenter = [CCRotateBy actionWithDuration:0.1 angle:0.0];
        CCRotateTo * rotRight = [CCRotateBy actionWithDuration:0.1 angle:4.0];
        CCSequence * rotSeq = [CCSequence actions:rotLeft, rotCenter, rotRight, rotCenter, nil];
        [newSprite runAction:[CCRepeatForever actionWithAction:rotSeq]];
        selSprite = newSprite;
    }
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation];
    return TRUE;
}


// (Roger) Set up the background
- (void) setBackground {
    CGSize winSize = [CCDirector sharedDirector].winSize;
//    menu.position = ccp(screenSize.width/2, 50);
    NSLog(@"Setting up Game Table Background Image");
    background = [CCSprite spriteWithFile: @"green.png"];
    background.scale = 2.0;
    // (Roger) Set up the position as the center
    background.position = ccp(winSize.width / 2, winSize.height / 2);
    [self addChild:background];
    
    
    /*
    CCSprite *lowerPlayerRegion = [CCSprite spriteWithFile: @"playerRegion.png"];
    lowerPlayerRegion.position = ccp(screenSize.width / 2, 77);
    [self addChild:lowerPlayerRegion];
    
    CCSprite *upperPlayerRegion = [CCSprite spriteWithFile: @"playerRegion.png"];
    upperPlayerRegion.position = ccp(screenSize.width / 2, 691);
    [self addChild:upperPlayerRegion];
    
    CCSprite *lowerPlayerHand = [CCSprite spriteWithFile:@"hand.png"];
    lowerPlayerHand.position = ccp(screenSize.width / 2, 70);
    [self addChild:lowerPlayerHand];
    
    CCSprite *upperPlayerHand = [CCSprite spriteWithFile:@"hand.png"];
    upperPlayerHand.position = ccp(screenSize.width / 2, 698);
    [self addChild:upperPlayerHand];
    
    CCSprite *lowerDeckDiscardPile = [CCSprite spriteWithFile:@"deckdiscardPile.png"];
    lowerDeckDiscardPile.position = ccp(50, 70);
    [self addChild:lowerDeckDiscardPile];
    
    CCSprite *upperDeckDiscardPile = [CCSprite spriteWithFile:@"deckdiscardPile.png"];
    upperDeckDiscardPile.position = ccp(964, 698);
    [self addChild:upperDeckDiscardPile];
     */
    
    // (Roger) Intend to implement the card deck on the right (to pick the card) as a menu or something
    // (Roger) Those arrows are also going to be done as the menu
    // (Roger) But I don't know how to implement hiding the hand area. (Use Layers ?)
}

// (Brandon) Move the layer
- (CGPoint)boundLayerPos:(CGPoint)newPos {
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CGPoint retval = newPos;
    retval.x = MIN(retval.x, background.contentSize.width-winSize.width);
    retval.x = MAX(retval.x, -background.contentSize.width+winSize.width);
    retval.y = self.position.y;
    return retval;
}

- (void)panForTranslation:(CGPoint)translation {
    if (selSprite) {
        CGPoint newPos = ccpAdd(selSprite.position, translation);
        selSprite.position = newPos;
    } else {
        CGPoint newPos = ccpAdd(self.position, translation);
        self.position = [self boundLayerPos:newPos];
    }
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);
    [self panForTranslation:translation];
}


@end
