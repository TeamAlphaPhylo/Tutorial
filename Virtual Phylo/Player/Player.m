//
//  Player.m
//  Virtual Phylo
//
//  Created by Brandon Wong on 2013-06-26.
//  Copyright (c) 2013 Group_12. All rights reserved.
//


#import "Player.h"

@implementation Player

// (Roger) Synthesization
@synthesize playerPoints;
@synthesize username;
@synthesize password;
@synthesize deckList;
@synthesize unlockedCards;

// (Roger) init method as usual
- (id) init
{
    if (self = [super init]) {
    
    }
    
    return self;
    
}

@end
