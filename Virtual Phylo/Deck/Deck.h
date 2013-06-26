//
//  Deck.h
//  Virtual Phylo
//
//  Created by Brandon Wong on 2013-06-26.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Deck : NSObject{
    @private
    int *deck_CardNos; // pointer to an array of card id numbers that 
    NSString *deck_name;
    int deck_cardCount;
    
}

// (void)addCard(int cardNo);
// (void)delCard(int cardNo);
// (void)rename(NSString newName);


@end
