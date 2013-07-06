//
//  CardSprite.m
//  Virtual Phylo
//
//  Created by Brandon Wong on 2013-06-26.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import "CardSprite.h"

@implementation CardSprite
// (Brandon) constructor-ish for CardSprite
// (Brandon) reference: http://pixeleap.com/?p=280
+ (id) spriteWithCard:(int)cardNo atLocation:(int)x andAt:(int)y withWidth:(int)width{
    // cardSprite_Card = masterCard_Cards[cardNo]; --> (Brandon) need to find the right syntax for this
    NSString *filename = @"1.png"; // (Brandon) need to change to grab file name from cardSprite_Card
    self = [[[self alloc] initWithFile:filename] autorelease];
    // self.position = ccp(x,y); --> (Brandon) need to find the right syntax for this
    // need a method to set the size, using width, with the height changing based on the width
    return self;
}


@end
