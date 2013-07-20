//
//  CurrentUsers.h
//  Virtual Phylo
//
//  Created by Petr Krakora on 7/19/13.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentUsers : NSObject{
    NSMutableArray *currentUsers;
}

+ (void) addUser:(NSString *)user;
+ (void) removeUser:(NSString *)user;

@end

