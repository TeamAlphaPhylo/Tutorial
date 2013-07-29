//
//  CCItemsScroller.h
//
//  Created by Aleksander Bykin on 26.06.12.
//  Copyright 2012. All rights reserved.
//

#import "cocos2d.h"

typedef enum{
    ItemsScrollerVertical,
    ItemsScrollerHorizontal
} ItemsScrollerOrientations;

@protocol ItemsScrollerDelegate;

@interface ItemsScroller : CCLayer

@property (strong, nonatomic) id<ItemsScrollerDelegate> delegate;
@property (assign, nonatomic) ItemsScrollerOrientations orientation;

+(id)itemsScrollerWithItems:(NSArray*)items andOrientation:(ItemsScrollerOrientations)orientation andRect:(CGRect)rect;

-(id)initWithItems:(NSArray*)items andOrientation:(ItemsScrollerOrientations)orientation andRect:(CGRect)rect;

-(void)updateItems:(NSArray*)items;

-(int)doubleTap:(CGPoint)tapPosition;

@end


// PROTOCOL
@protocol ItemsScrollerDelegate <NSObject>

@required

- (void)itemsScroller:(ItemsScroller *)sender didSelectItemIndex:(int)index;

@optional

- (void)itemsScrollerScrollingStarted:(ItemsScroller *)sender;

@end


// PROTOCOL
@protocol SelectableItemDelegate <NSObject>

@optional

-(void)setIsSelected:(BOOL)isSelected;


@end