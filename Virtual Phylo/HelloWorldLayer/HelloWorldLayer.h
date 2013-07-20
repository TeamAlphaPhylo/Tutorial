//
//  HelloWorldLayer.h
//  Virtual Phylo
//
//  Created by Petr Krakora on 6/21/13.
//  Copyright Group_12 2013. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "MainMenuLayer.h"
#import "Player.h"
#import "CurrentUsers.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <UIAlertViewDelegate, UITextFieldDelegate> {
    UITextField* usernameField;
    UITextField* pwdField;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
