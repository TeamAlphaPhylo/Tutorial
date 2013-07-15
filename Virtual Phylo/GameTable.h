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
#import "PlayerLayerBot.h"
#import "PlayerLayerTop.h"

@interface GameTable : CCLayer<CCItemsScrollerDelegate>{
    PlayerLayerBot *pBot;
    PlayerLayerTop *pTop;
    CCSprite *background;
    CCSprite *selSprite;
    NSMutableArray *movableSprites;
}

@property (nonatomic, retain) PlayerLayerBot *pBot;
@property (nonatomic, retain) PlayerLayerTop *pTop;
//  <CCItemsScrollerDelegate>
+(CCScene *) scene;

@end
