//
//  CoreData.m
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-04.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import "CoreData.h"

@implementation CoreData

@synthesize tempTest;
@synthesize userName;
@synthesize userWin;
@synthesize userLoss;
@synthesize hostPlayerDeck;
@synthesize guestUserName;
@synthesize guestPlayerWin;
@synthesize guestPlayerLoss;
@synthesize guestPlayerDeck;

// (Roger) Implement the public constructor
+(id) sharedCore {
    static CoreData *sharedMyCore = nil;
    // (Roger) Using the GCD to manipulate and maintain the thread
    static dispatch_once_t token;
    // (Roger) Dispatch once, referring to the Apple Dev Docs
    dispatch_once(&token, ^ {
        // (Roger) Self-initiation
        sharedMyCore = [[self alloc] init];
    });
    // (Roger) Return itself for further access
    return sharedMyCore;
}

-(id) init {
    if(self = [super init]) {
        NSLog(@"CoreData Class Initialization");
        // (Roger) Be careful about the init, double check the syntax
        tempTest = [[NSString alloc] initWithString: @"Test for accessing the core data"];
    }
    return self;
}

- (void) parseStat: (NSString *)stat {
    NSArray *wins_losses = [stat componentsSeparatedByString: @";"];
    userWin = [[NSString alloc] initWithString:[wins_losses objectAtIndex: 0]].integerValue;
    userLoss = [[NSString alloc] initWithString:[wins_losses objectAtIndex: 1]].integerValue;
}

- (void) parseGuestStat: (NSString *) stat {
    NSArray *wins_losses = [stat componentsSeparatedByString: @";"];
    guestPlayerWin = [[NSString alloc] initWithString:[wins_losses objectAtIndex: 0]].integerValue;
    guestPlayerLoss = [[NSString alloc] initWithString:[wins_losses objectAtIndex: 1]].integerValue;
}

-(NSMutableArray*) getHostPlayerDeckList {
    NSMutableArray *deckList = [[NSMutableArray alloc] init];
    // (Roger) First fetch the unparsed deck list
    NSMutableArray *deckRawList = [Player getDecks: userName];
    for(int i = 0; i < deckRawList.count; i++) {
        NSLog(@"%@", deckRawList[i]);
        // (Roger) Here we define the format: index 0 is the deck name
        // (Roger) the rest of the index is the card index which is the card number
        NSArray *temporaryLineOfDeck = [deckRawList[i] componentsSeparatedByString:@";"];
        NSString *deckname = [[NSString alloc] initWithString:[temporaryLineOfDeck objectAtIndex:0]];
        NSString *deckIndexStr = [[NSString alloc] initWithString:[temporaryLineOfDeck objectAtIndex:1]];
        NSArray *deckIndex = [deckIndexStr componentsSeparatedByString:@"!"];
        for(int i = 0; i < deckIndex.count; i++) {
            NSLog(@"Deck Index: %@", [deckIndex objectAtIndex:i]);
        }
        [deckList addObject:deckname];
        // (Roger) When the deck index array was added to the return array, each one is in the form of the string instead of integer
        [deckList addObject:deckIndex];
    }
    return deckList;
}

-(NSMutableArray*) getGuestPlayerDeckList {
    NSMutableArray *deckList = [[NSMutableArray alloc] init];
    // (Roger) First fetch the unparsed deck list
    NSMutableArray *deckRawList = [Player getDecks: guestUserName];
    for(int i = 0; i < deckRawList.count; i++) {
        NSLog(@"%@", deckRawList[i]);
        // (Roger) Here we define the format: index 0 is the deck name
        // (Roger) the rest of the index is the card index which is the card number
        NSArray *temporaryLineOfDeck = [deckRawList[i] componentsSeparatedByString:@";"];
        NSString *deckname = [[NSString alloc] initWithString:[temporaryLineOfDeck objectAtIndex:0]];
        NSString *deckIndexStr = [[NSString alloc] initWithString:[temporaryLineOfDeck objectAtIndex:1]];
        NSArray *deckIndex = [deckIndexStr componentsSeparatedByString:@"!"];
        [deckList addObject:deckname];
        // (Roger) When the deck index array was added to the return array, each one is in the form of the string instead of integer
        [deckList addObject:deckIndex];
    }
    return deckList;
}

//- (void) dealloc {
//    // Never be called
//}
    
@end
