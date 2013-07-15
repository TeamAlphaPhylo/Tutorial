//
//  PlayerLayerTop.h
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-14.
//  Copyright 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCSelectableItem.h"
#import "CCItemsScroller.h"


@interface PlayerLayerTop : CCLayer <CCItemsScrollerDelegate>{
    
}

@property bool show_hide;
@property int selected_card_index;
@end
