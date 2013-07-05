//
//  CoreData.h
//  Virtual Phylo
//
//  Created by Roger Zhao on 2013-07-04.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>

// (Roger) Create an object which will be handled by the OS and it can be accessed
// (Roger) during the running life of the application

@interface CoreData : NSObject {
    NSString *tempTest;
}

// (Roger) Declare a string here
@property (nonatomic, retain) NSString *tempTest;

// (Roger) Declare a "quasi-constructor" for accessing the object 
+ (id)sharedCore;

@end
