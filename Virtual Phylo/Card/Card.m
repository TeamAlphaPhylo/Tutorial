//
//  Card.m
//  Virtual Phylo
//
//  Created by Brandon Wong on 2013-06-26.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import "Card.h"

@implementation Card

- (id) initWithCardNo: cardNo
{
    if (self = [super init])
    {
        card_no = cardNo;
        // (Brandon)
        // need to fix this
        // card_imageName = @card_no + ".png";
        
    }
    return self;
}

@end
