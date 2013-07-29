//
//  Deck.h
//  Virtual Phylo
//
//  Created by Brandon Wong on 2013-06-26.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreData.h"
#import "ItemsScroller.h"
#import "SelectableItem.h"
#import "MainMenuLayer.h"
#import "SearchIn.h"


@interface Deck :  CCLayer <ItemsScrollerDelegate,UIAlertViewDelegate,UITextFieldDelegate>{
    CCSprite *background;
    CCSprite *selSprite;
    UITextField* alphabeticMenuField;
    NSMutableArray *movableSprites;
    UIView *glView;
}
+ (CCScene *) scene;
- (void) setBackground;
- (void) setTopLMenu;
- (void) addRenamewithstring:(NSString*)a;
@property (nonatomic, retain) NSMutableArray *deckCards;
@property (nonatomic, retain) NSString *deckName;
@end
