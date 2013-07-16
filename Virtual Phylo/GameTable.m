//
//  GameTable.m
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-06.
//  Copyright 2013 Group_12. All rights reserved.
//

#import "GameTable.h"

@implementation GameTable

@synthesize pBot;
@synthesize pTop;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    // (Brandon) PlayerLayers act as layers or regions for the players
    PlayerLayerBot *pBot = [PlayerLayerBot node];
    [scene addChild:pBot z:1]; // z-index: 1, above the playing field
    pBot.touchEnabled = YES;
    
    PlayerLayerTop *pTop = [PlayerLayerTop node];
    [scene addChild:pTop z:1]; // z-index: 1
    
	// 'layer' is an autorelease object.
	GameTable *layer = [GameTable node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    	
	// return the scene
	return scene;
}

-(id) init
{
    if( (self=[super init]) ) {
    
        //_touchEnabled = YES;
        NSLog(@"Game Table Layer Initialization");
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    
        // add components created as children to this Layer (Notice there are added in a specific sequence)
        [self setBackground];
        [self addSprites];
//        [self addCardScroller];
    }
    return self;
}

// (Brandon) add some card sprites to fool around with, use this same means of adding cards to hand?
- (void) addSprites {
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    movableSprites = [[NSMutableArray alloc] init];
    NSArray *images = [NSArray arrayWithObjects:@"0.png", @"1.png", @"2.png", @"3.png", nil];
    for(int i = 0; i < images.count; ++i) {
        NSString *image = [images objectAtIndex:i];
        CCSprite *sprite = [CCSprite spriteWithFile:image];
        float offsetFraction = ((float)(i+1))/(images.count+1);
        sprite.position = ccp(winSize.width*offsetFraction, winSize.height/2);
        sprite.scale = 0.4;
        [self addChild:sprite];
        [movableSprites addObject:sprite];
    }
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

// (Roger) Set up the background
- (void) setBackground {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
////    menu.position = ccp(screenSize.width/2, 50);
    NSLog(@"Setting up Game Table Background Image");
    background = [CCSprite spriteWithFile: @"green.jpg"];
    background.rotation = 90.0;
    background.scale = 1.5;
    // (Roger) Set up the position as the center
    background.position = ccp(screenSize.width / 2, screenSize.height / 2);
    [self addChild:background z:-2];
}

// (Roger) Implement the interface requirements
-(void)itemsScroller:(CCItemsScroller *)sender didSelectItemIndex:(int)index{
    NSLog(@"Select Bottom %d Card", index);
}

// (Brandon) keeps track of which sprite is being touched
- (void)selectSpriteForTouch:(CGPoint)touchLocation {
    CCSprite * newSprite = nil;
    for (CCSprite *sprite in movableSprites) {
        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) {
            newSprite = sprite;
            [newSprite runAction:[CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:1 scaleX:1.0 scaleY:1.0] rate:8.0]];
            break;
        }
    }
    if (newSprite != selSprite) {
        [selSprite stopAllActions];
//        id scaleUpAction =  [CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:1 scaleX:1.0 scaleY:1.0] rate:2.0];
//        id scaleDownAction = [CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:0.5 scaleX:0.8 scaleY:0.8] rate:2.0];
        
         // make selected sprite wiggle when touched
         [selSprite runAction:[CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:1 scaleX:0.4 scaleY:0.4] rate:8.0]];
//         CCRotateTo * rotLeft = [CCRotateBy actionWithDuration:0.1 angle:-4.0];
//         CCRotateTo * rotCenter = [CCRotateBy actionWithDuration:0.1 angle:0.0];
//         CCRotateTo * rotRight = [CCRotateBy actionWithDuration:0.1 angle:4.0];
//         CCSequence * rotSeq = [CCSequence actions:rotLeft, rotCenter, rotRight, rotCenter, nil];
//         [newSprite runAction:[CCRepeatForever actionWithAction:rotSeq]];
        
        selSprite = newSprite;
    }
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation];
    return TRUE;
}

- (CGPoint)boundLayerPos:(CGPoint)newPos {
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CGPoint retval = newPos;
    retval.y = MIN(retval.y, background.contentSize.width-winSize.width+300);
    // (Roger) Modified to match the bound
    retval.y = MAX(retval.y, -background.contentSize.width+winSize.width-280);
    retval.x = MIN(retval.x, background.contentSize.height-winSize.height-100);
    retval.x = MAX(retval.x, -background.contentSize.height+winSize.height+100);
    return retval;
}

- (void)panForTranslation:(CGPoint)translation {
    // (Brandon) if a sprite is touched, move the sprite
    if (selSprite) {
        CGPoint newPos = ccpAdd(selSprite.position, translation);
        selSprite.position = newPos;
        
        // (Brandon) if the background is touched, move the sprite
        // note, this still works if you're touching the hand, because the background is beneath it, needs fixing
    } else if (background) {
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
