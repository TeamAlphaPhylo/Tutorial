//
//  Card.h
//  Virtual Phylo
//
//  Created by Brandon Wong on 2013-06-26.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

    
#import <Foundation/Foundation.h>

@interface Card : NSObject
{
    @private
    int card_no; // card's id number
    NSString *card_imageName;
    NSString *card_commName;
    NSString *card_latinName;
    int card_scale;
    NSString *card_foodChain;
    NSString *card_diet;
    NSString *evoTree;
    int card_points;
    NSString *card_trivia;
    NSString *card_effect;
    NSString *card_climate;
}

// (Brandon) initialize a card with the card number, use the card number to figure out which data to load
- (id) initWithCardNo: cardNo;

@end
