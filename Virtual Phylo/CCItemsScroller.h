//
//  CCItemsScroller.h
//
//  Created by Aleksander Bykin on 26.06.12.
//  Copyright 2012. All rights reserved.
//

#import "cocos2d.h"
#import "PlayerLayerBot.h"
@class PlayerLayerBot;
#import "PlayerLayerTop.h"
@class PlayerLayerTop;

typedef enum{
    CCItemsScrollerVertical,
    CCItemsScrollerHorizontal
} CCItemsScrollerOrientations;

@protocol CCItemsScrollerDelegate;

@interface CCItemsScroller : CCLayer {
//    UITapGestureRecognizer * _doubleTapRecognizer;
}

@property (strong, nonatomic) id<CCItemsScrollerDelegate> delegate;
@property (assign, nonatomic) CCItemsScrollerOrientations orientation;
//@property (nonatomic, assign) NSMutableArray *tagArray;
//@property (retain) UITapGestureRecognizer * doubleTapRecognizer;
//@property



+(id)itemsScrollerWithItems:(NSArray*)items andOrientation:(CCItemsScrollerOrientations)orientation andRect:(CGRect)rect;

-(id)initWithItems:(NSArray*)items andOrientation:(CCItemsScrollerOrientations)orientation andRect:(CGRect)rect;

-(void)updateItems:(NSArray*)items;

-(int)doubleTap:(CGPoint)tapPosition;

@end