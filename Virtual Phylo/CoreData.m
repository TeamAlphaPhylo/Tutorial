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
@synthesize coreData_MasterCardArray;
@synthesize cardsOnTable;

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
    
    // (Brandon) initalize the MasterCardArray to keep track of all card data, which can be accessed by any class so long as MainMenuLayer never gets deallocated
    // coreData_MasterCardArray = [[MasterCard alloc] init];

    
}

-(id) init {
    if(self = [super init]) {
        NSLog(@"CoreData Class Initialization");
        // (Roger) Be careful about the init, double check the syntax
        tempTest = [[NSString alloc] initWithString: @"Test for accessing the core data"];
        cardsOnTable = [[NSMutableArray alloc] initWithObjects: [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:4], nil];
        for(int i = 0; i < cardsOnTable.count; i++) {
            NSLog(@"%d", [[cardsOnTable objectAtIndex:i] integerValue]);
        }
        NSLog(@"Init CoreData");
        coreData_MasterCardArray = [[MasterCard alloc] init];
    }
    
    return self;
}

//- (void) dealloc {
//    // Never be called
//}
@end
