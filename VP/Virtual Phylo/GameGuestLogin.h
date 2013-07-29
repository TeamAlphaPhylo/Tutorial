//
//  GameGuestLogin.h
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-06.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Game.h"
#import "MainMenuLayer.h"
#import "GuestDeckChoose.h"

@interface GameGuestLogin : CCLayer <UIAlertViewDelegate, UITextFieldDelegate> {
    UITextField* usernameField;
    UITextField* pwdField;
}

+(CCScene *) scene;

@end
