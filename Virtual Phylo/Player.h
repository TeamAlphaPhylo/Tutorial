//
//  Player.m
//  Virtual Phylo
//
//  Created by Petr Krakora on 2013_07_20.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

+ (void) createPlayer:(NSString *)username;
+ (BOOL) createDeck:(NSString *)username deckName:(NSString *)deckname cardArray:(NSMutableArray *)cards;
+ (NSMutableArray *) getDecks:(NSString *)username;
+ (NSString *) getStats:(NSString *)username;
+ (NSString *) getSync:(NSString *)username;
+ (void) setSync:(NSString *)username sync:(NSString *)sync;
+ (void)buildFile:(NSString *)username data:(NSString *)cards;
+ (void) playerWin:(BOOL)win withusername:(NSString *)username;
+ (void) deleteDeck:(NSString *)username deckname:(NSString *)deckname;
+ (BOOL) checkExistance:(NSString *)name;

@end
