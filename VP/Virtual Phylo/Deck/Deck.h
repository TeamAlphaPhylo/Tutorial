//
//  Deck.h
//  Virtual Phylo
//
//  Created by Brandon Wong on 2013-06-26.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreData.h"
// (Roger) Deck references the card number (unique identifier) of cards

@interface Deck : NSObject {
    // (Roger) Use property instead, otherwise you have to set mutators to access the data
}

@property (nonatomic, retain) NSMutableArray *deckCards;
@property (nonatomic, retain) NSString *deckName;

//-(void)addCard:(int* cardNum);
//-(void)delCard:(int*);
//-(void)rename:(NSString*);


@end
