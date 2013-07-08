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
    // (Roger) if we set those methods as private, we have to set a bunch of "setters" and "getters" to fetch the data
    // (Roger) Also, it would be hard to modify / update card information.
    // (Roger) The encapsulation seems to be unnecessary here.
//    @private
    @public
//    int card_no; // card's id number
//    NSString *card_imageName;
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
//- (id) initWithCardNo: cardNo;
// (BUG) Fixed!

// (Roger) It should return a card object which contains all the relevant info.
// (Roger) Also, the - should be substituted by +, + represents that it can be accessed and instantiated by other classes
//+ (Card*) initWithCardNo: cardNo;
@property int card_no;
@property (nonatomic, retain) NSString *card_imageName;

- (id) initWithCardNo: cardNo;

@end
