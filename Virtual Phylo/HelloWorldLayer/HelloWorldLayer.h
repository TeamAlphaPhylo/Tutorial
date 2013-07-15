//
//  HelloWorldLayer.h
//  Virtual Phylo
//
//  Created by Darkroot on 6/21/13.
//  Copyright Group_12 2013. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "MainMenuLayer.h"

// Login Screen

// (Brandon): 
// first screen that user interacts with
// registers accounts, saves accounts, allows login with registered accounts

@interface HelloWorldLayer : CCLayer <UIAlertViewDelegate, UITextFieldDelegate> {
    UITextField* usernameField;
    UITextField* pwdField;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

// allows user to enter their username and password
-(void) addLoginFields;

// verifies if username matches password
-(void)verifyIdentity;

// writes input string to a text file
-(void)writeToTextFile;

// creates an alert to show the username/password is wrong
-(void) showAlertView;

// jump to Main Menu Screen
-(void)jumpToMainMenu;

@end
