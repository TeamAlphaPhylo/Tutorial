//
//  Deck.h
//  Virtual Phylo
//
//  Created by Brandon Wong on 2013-06-26.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreData.h"
// (Roger) (Thought) Alternative Design: The deck doesn't contain any actual card instances,
// (Roger) (Thought) instead, they only referencing the card number (unique identifier) of cards

@interface Deck : NSObject{
    // (Roger) Use property instead, otherwise you have to set mutators to access the data
//    @private
//    NSArray *deck_CardNos; // an array of card id numbers (ints) that represent what cards are in the deck
//    NSString *deck_name;
//    int deck_cardCount;
//    
}

// (Roger) Property Declaration
@property (nonatomic, retain) NSMutableArray *deckCards;
@property (nonatomic, retain) NSString *deckName;
// (Roger) Deck card count is unnecessary because the count can be internally figured out by the NSMutableArray class
//@property int deckCardCount;

// (void)addCard(int cardNo);
// (void)delCard(int cardNo);
// (void)rename(NSString newName);


@end
