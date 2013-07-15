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

// GameGuestLogin Screen
// provides an interface to allow player 2 to login, so that they can pick from their list of decks

@interface GameGuestLogin : CCLayer <UIAlertViewDelegate, UITextFieldDelegate> {
    UITextField* usernameField;
    UITextField* pwdField;
}

+(CCScene *) scene;

// add title images
- (void)setTitle;

// jump to Main Menu Screen
- (void)jumpToMainMenu;

// add login images
- (void)addLoginBlock;

// allows user to enter their username and password
- (void)addLoginFields;

// verifies if username matches password
- (void)verifyIdentity;

// writes input string to a text file
- (void)writeToTextFile;

// creates an alert to show the username/password is wrong
- (void)showAlertView;

// jump to GuestDeckChoose Screen, to allow player 2 to choose their deck
- (void)jumpToGuestDeckChoose;

@end
