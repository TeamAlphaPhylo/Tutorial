//
//  IntroLayer.h
//  Virtual Phylo
//
//  Created by Petr Krakora on 6/21/13.
//  Copyright Group_12 2013. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "CoreData.h"
// Intro Screen
// first layer that is seen by the user
// introduces what the app is
@interface IntroLayer : CCLayer
{
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
-(void)onEnter;
@end
