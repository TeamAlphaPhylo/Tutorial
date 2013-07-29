//
//  Player.m
//  Virtual Phylo
//
//  Created by Petr Krakora on 2013-07-20.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

- (void) createPlayer:(NSString *)username;
- (BOOL) createDeck:(NSString *)username deckName:(NSString *)deckname cardArray:(NSArray *)cards;
- (NSArray *) getDecks:(NSString *)username;
- (void) playerWin:(BOOL)win withusername:(NSString *)username ;
+ (BOOL) checkExistance:(NSString *)name;


@end
