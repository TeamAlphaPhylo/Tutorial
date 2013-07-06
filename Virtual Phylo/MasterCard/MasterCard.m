//
//  MasterCard.m
//  Virtual Phylo
//
//  Created by Brandon Wong on 2013-07-05.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import "MasterCard.h"

@implementation MasterCard

- (id) init
{
    if (self = [super init]){
        // (Brandon) how the hell do you make an array? lol
        //masterCard_cards = [[NSArray alloc] arrayWithObjects:(const id *Card) count:(428)];
        for (int i = 0; i < count; i++) {
            
            // masterCard_cards  = [[Card alloc] initWithCardNo:i];
        }
        
    }
    return self;
}

@end
