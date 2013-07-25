//
//  CCItemsScroller.m
//
//  Created by Aleksander Bykin on 26.06.12.
//  Copyright 2012. All rights reserved.
//

#import "CCItemsScroller.h"

enum
{
    kCCScrollLayerStateIdle,
    kCCScrollLayerStateSliding
};

@implementation CCItemsScroller{
    CGRect _rect;
    int _state;
    CGPoint _startSwipe;
    CGPoint _offset;
    CGSize _itemSize;
    NSInteger _lastSelectedIndex;
}

@synthesize delegate = _delegate;
@synthesize orientation = _orientation;

+(id)itemsScrollerWithItems:(NSArray *)items andOrientation:(CCItemsScrollerOrientations)orientation andRect:(CGRect)rect{
    return [[self alloc] initWithItems:items andOrientation:(CCItemsScrollerOrientations)orientation andRect:rect];
}

// (Roger) This class is in control of the boundary of the scroller
-(void) visit
{
    CGRect _glRect = CC_RECT_POINTS_TO_PIXELS(_rect);
    
    //glPushMatrix();
    glEnable(GL_SCISSOR_TEST);
    glScissor(_glRect.origin.x, _glRect.origin.y, _glRect.size.width, _glRect.size.height);
    
    [super visit];
    
    glDisable(GL_SCISSOR_TEST);
    //glPopMatrix();
}

-(id)initWithItems:(NSArray *)items andOrientation:(CCItemsScrollerOrientations)orientation andRect:(CGRect)rect{
    self = [super init];
    
    if(self){
        _rect = rect;
        _orientation = orientation;

//        self.TouchEnabled = YES;
        [self updateItems:items];
    }
    
    return self;
}

-(void)updateItems:(NSArray*)items{
    [self removeAllChildrenWithCleanup:YES];
    int i = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    
    NSLog(@"[CCItemsScroller] Updating Items");
    
    for (CCLayer *item in items)
    {
        if(i == 0){
            int csWidth = 0;
            int csHeight = 0;
            
            _itemSize = CGSizeMake(item.contentSize.width, item.contentSize.height);
            
            if(_orientation == CCItemsScrollerHorizontal){
                csWidth = items.count*_itemSize.width;
                csHeight = _rect.size.height;
            }
            
            if(_orientation == CCItemsScrollerVertical){
                csWidth = _rect.size.width;
                csHeight = items.count*_itemSize.height;
            }
            
            self.contentSize = CGSizeMake(csWidth, csHeight);
        }
        
        if (_orientation == CCItemsScrollerHorizontal) {
            x = (i * item.contentSize.width);
        }
        
        if(_orientation == CCItemsScrollerVertical){
            y = (i * item.contentSize.height);
        }
        
        item.tag = i;
        item.position = ccp(x, y);
        
        if (!item.parent)
            [self addChild:item z:i tag:i];
        
        ++i;
    }
    
    _offset.x = _rect.origin.x;
    _offset.y = _rect.origin.y;
    
    if(_orientation == CCItemsScrollerHorizontal)
        self.position = ccp(_rect.origin.x, _rect.origin.y);
    
    if(_orientation == CCItemsScrollerVertical){
        _offset.y = -(self.contentSize.height-_rect.size.height-_rect.origin.y/2);
        self.position = ccp(_rect.origin.x, _offset.y);
    }
}

-(void)handleTouchMoved: (CGPoint) touchPoint
{
    touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    
    // (Roger) Modified Library to make it work only in the scroll part
    if((touchPoint.x > _rect.origin.x) && (touchPoint.x < (_rect.origin.x + _rect.size.width)) && (touchPoint.y > _rect.origin.y) && (touchPoint.y < (_rect.origin.y + _rect.size.height))) {
        NSLog(@"Handling Sliding???");
        if ( _state != kCCScrollLayerStateSliding )
        {
            _state = kCCScrollLayerStateSliding;
            
            _startSwipe = CGPointMake(_offset.x - touchPoint.x, _offset.y - touchPoint.y);
            
            if ([_delegate respondsToSelector:@selector(scrollLayerScrollingStarted:)])
                [_delegate itemsScrollerScrollingStarted:self];
        }
        
        if (_state == kCCScrollLayerStateSliding)
        {
            if(_orientation == CCItemsScrollerHorizontal){
                _offset.x = _startSwipe.x + touchPoint.x;
                
                if(_offset.x > _rect.origin.x){
                    _offset.x = _rect.origin.x;
                }
                else if(_offset.x < -(self.contentSize.width-_rect.size.width-_rect.origin.x)){
                    _offset.x = -(self.contentSize.width-_rect.size.width-_rect.origin.x);
                }
            }
            
            if(_orientation == CCItemsScrollerVertical){
                _offset.y = _startSwipe.y + touchPoint.y;
                
                if(_startSwipe.y < touchPoint.y){
                    if (_offset.y > _rect.origin.y) {
                        _offset.y = _rect.origin.y;
                    }else
                        if (_offset.y < -(self.contentSize.height-_rect.size.height-_rect.origin.y))
                        {
                            _offset.y = -(self.contentSize.height-_rect.size.height-_rect.origin.y);
                        }
                }
                else {
                    if (_offset.y > _rect.origin.y) {
                        _offset.y = _rect.origin.y;
                    }
                }
            }
            
            self.position = ccp(_offset.x, _offset.y);
        }
    }
}

-(void)handleTouchEnded:(CGPoint) touchPoint{
    touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    
    CGFloat touchX = 0;
    CGFloat touchY = 0;
    
    if(_orientation == CCItemsScrollerHorizontal){
        touchY = touchPoint.y;
        touchX = self.position.x*-1 + touchPoint.x;
    }
    
    if(_orientation == CCItemsScrollerVertical){
        touchX = touchPoint.x;
        touchY = self.position.y - touchPoint.y;
        
        if(touchY < 0)
            touchY *= -1;
    }
    
    for (CCLayer *item in self.children) {
        BOOL isX = NO;
        BOOL isY = NO;
        
        if(_orientation == CCItemsScrollerHorizontal){
            isX = (touchX >= item.position.x && touchX <= item.position.x + item.contentSize.width);
            isY = (touchY >= self.position.y && touchY <= self.position.y + item.contentSize.height);
        }
        
        if(_orientation == CCItemsScrollerVertical){
            isX = (touchX >= item.position.x && touchX <= item.contentSize.width);
            isY = (touchY >= item.position.y && touchY <= item.position.y + item.contentSize.height);
        }
        
        if(isX && isY){
            [self setSelectedItemIndex:item.tag];
            
            break;
        }
    }
}


-(void)setSelectedItemIndex:(NSInteger)index{
    id currentChild = [self getChildByTag:index];
    id lastSelectedChild = [self getChildByTag:_lastSelectedIndex];
    
    if([lastSelectedChild respondsToSelector:@selector(setIsSelected:)])
    {
        [lastSelectedChild setIsSelected:NO];
    }
    
    if([currentChild respondsToSelector:@selector(setIsSelected:)]){
        [currentChild setIsSelected:YES];
        
    }
    
    _lastSelectedIndex = index;
    
    if([_delegate respondsToSelector:@selector(itemsScroller:didSelectItemIndex:)])
        [_delegate itemsScroller:self didSelectItemIndex:index];
}

// (Roger) This function is going to identify the double tap action and remove the item of the tapped item and return the image tag (a.k.a. the card tag of the selected item)
// (Roger) Input: The tap position; Output: the card index of the selected item.
-(int)doubleTap:(CGPoint)tapPosition {
    int selectedItem = -1;
//    tapPosition = [[CCDirector sharedDirector] convertToGL:tapPosition];
    
    CGFloat touchX = 0;
    CGFloat touchY = 0;
    
    if(_orientation == CCItemsScrollerHorizontal){
        touchY = tapPosition.y;
        touchX = self.position.x*-1 + tapPosition.x;
    }
    
    if(_orientation == CCItemsScrollerVertical){
        touchX = tapPosition.x;
        touchY = self.position.y - tapPosition.y;
        
        if(touchY < 0)
            touchY *= -1;
    }
    
    NSLog(@"Double Tap (ItemScroller Handling) Touch X = %f, Touch Y = %f", touchX, touchY);
    
    for (CCLayer *item in self.children) {
        BOOL isX = NO;
        BOOL isY = NO;
        NSLog(@"(CCItemScroller)item position: (%f, %f)", item.position.x, item.position.y);
        
        if(_orientation == CCItemsScrollerHorizontal){
            isX = (touchX >= item.position.x && touchX <= item.position.x + item.contentSize.width);
            isY = (touchY >= self.position.y && touchY <= self.position.y + item.contentSize.height);
        }
        
        if(_orientation == CCItemsScrollerVertical){
            isX = (touchX >= item.position.x && touchX <= item.contentSize.width);
            isY = (touchY >= item.position.y && touchY <= item.position.y + item.contentSize.height);
        }
        
        if(isX && isY){
//            [self setSelectedItemIndex:item.tag];
            selectedItem = item.tag;
            break;
        }
    }
    NSLog(@"Index: %d item is selected", selectedItem);
    return selectedItem;
}

@end