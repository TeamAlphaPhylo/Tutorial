//
//  CardInst.h
//  Virtual Phylo
//
//  Created by Brandon Wong on 2013-06-26.
//  Copyright (c) 2013 Team Alpha. All rights reserved.
//

// An object that is acatually shown on the screen that keeps track of width/height/x/y


#import <Foundation/Foundation.h>

@interface CardInst : NSObject
// Should it be a child of CSSprite?
// @interface CardInst : CCSprite
// this class is kind of useless, i'll probably get rid of it later
{
    
    id cardInst_Card; // the Card that CardInst is representing
    int cardInst_width;
    int cardInst_height;
    int x;
    int y;
    
    
    
}

// Changes the size of the CardInst
- (void)changeWidth:(int)width andHeight:(int)height;

// Changes the (x,y) position
- (void)setX:(int)x andY:(int)y;


@end
