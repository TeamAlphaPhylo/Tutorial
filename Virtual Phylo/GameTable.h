//
//  GameTable.h
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-06.
//  Copyright 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCItemsScroller.h"
#import "CCSelectableItem.h"

@interface GameTable : CCLayer<CCItemsScrollerDelegate>

+(CCScene *) scene;

@end
