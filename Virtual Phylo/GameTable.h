//
//  GameTable.h
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-06.
//  Copyright 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PlayerLayerBot.h"
#import "PlayerLayerTop.h"

@interface GameTable : CCLayer {
    PlayerLayerBot *_pBot;
    PlayerLayerTop *_pTop;
}

+(CCScene *) scene;
-(id) initWithPlayer1:(PlayerLayerBot *)pBot Player2:(PlayerLayerTop *)pTop;
@end
