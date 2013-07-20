//
//  Player.m
//  Virtual Phylo
//
//  Created by Petr Krakora on 2013-07-20.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

+ (void) createPlayer:(NSString *)username;
+ (NSString *) createDeck:(NSString *)username deckname:(NSString *)deckname cards:(NSArray *)cards;
+ (NSArray *) getDecks:(NSString *)username;
+ (BOOL *) checkExistance:(NSString *)name;


@end
