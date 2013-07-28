//
//  CoreData.h
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-04.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"


// (Roger) Create an object which will be handled by the OS and it can be accessed
// (Roger) during the running life of the application

@interface CoreData : NSObject {
    NSString *tempTest;
    NSString *userName;
    NSString *hostPlayerDeck;
    NSString *guestUserName;
    int userWin;
    int userLoss;
    int guestPlayerWin;
    int guestPlayerLoss;
}

// (Roger) Declare a string here
@property (nonatomic, retain) NSString *tempTest;
// (Roger) The user data here should all belong to the host player for display game stat
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *hostPlayerDeck;
@property (nonatomic, retain) NSString *guestPlayerDeck;
@property int userWin;
@property int userLoss;
@property int guestPlayerWin;
@property int guestPlayerLoss;
@property (nonatomic, retain) NSString *guestUserName;

// (Roger) Declare a "quasi-constructor" for accessing the object 
+ (id)sharedCore;
- (void) parseStat: (NSString *)stat;
- (void) parseGuestStat: (NSString *) stat;

-(NSMutableArray*) getHostPlayerDeckList;
-(NSMutableArray*) getGuestPlayerDeckList;

@end
