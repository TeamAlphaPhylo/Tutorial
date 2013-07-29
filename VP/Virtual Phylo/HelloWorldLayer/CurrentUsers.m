//
//  CurrentUsers.m
//  Virtual Phylo
//
//  Created by Darkroot on 7/19/13.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import "CurrentUsers.h"

@implementation CurrentUsers : NSObject

- (void) addUser:(NSString *)user {
    [currentUsers addObject: user];
}

- (void) removeUser:(NSString *)user {
    [currentUsers removeObject: user];
}
@end
