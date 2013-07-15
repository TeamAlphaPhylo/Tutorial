//
//  MainMenuLayer.h
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-06-29.
//  Copyright 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
// (Roger) import HelloWorldLayer for jumping back
#import "HelloWorldLayer.h"
#import "CCMenuAdvancedTest.h"
// (Brandon) import the objects we've created
//#import "CardSprite.h"
// (Roger) I don't get it... since all the info stored in the CoreData class
// (Brandon) I wrote that code before seeing your CoreData class. Your idea works better.

#import "MasterCard.h"

@interface MainMenuLayer : CCLayer {
    
}

+(CCScene *) scene;

@end
