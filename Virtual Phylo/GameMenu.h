//
//  GameMenu.h
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-28.
//  Copyright 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MainMenuLayer.h"
#import "Player.h"

@interface GameMenu : CCLayer {
    
}

@property bool hidden;

// adds menu background
-(void) setBackground;

// hand hiding functionality, to hide hand from opposing player
-(void)hideMenu;

// jump to the main menu
- (void)jumpToMainMenu;


@end
