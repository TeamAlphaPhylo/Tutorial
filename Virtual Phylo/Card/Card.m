//
//  Card.m
//  Virtual Phylo
//
//  Created by Brandon Wong on 2013-06-26.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import "Card.h"

@implementation Card
@synthesize card_no;
@synthesize card_imageName;

//+ (Card*) initWithCardNo: cardNo
- (id) initWithCardNo : cardNo
{
    if (self = [super init])
    {
        card_no = cardNo;
        // (Brandon)
        // need to fix this
        // (Roger) Fixed!
        // card_imageName = @card_no + ".png";
        card_imageName = [NSString stringWithFormat:@"%d%@", card_no, @".png"];
        NSLog(@"%@", card_imageName);
        
    }
    return self;
}

@end
