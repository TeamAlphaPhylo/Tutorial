//
//  Player.h
//  Virtual Phylo
//
//  Created by Brandon Wong on 2013-06-26.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

// (Roger) I think we could combine Player class and Account class into one "Player" class

// (Roger) (Thought) We could use XML for data passing between server and application

#import <Foundation/Foundation.h>

@interface Player : NSObject{
//    @private
//    id player_DrawPile; // a deck object
//    id player_DiscardPile; // a deck object
//    id player_Hand; // a deck object
}

//@property (nonatomic, retain) NSString *tempTest;
// (Roger) Declaration of member variables
@property int playerPoints;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
// (Roger) Use mutable array as the decklist
@property (nonatomic, retain) NSMutableArray *deckList;
// (Roger) Use an integer array to represent the unlocked card
@property (nonatomic, retain) NSMutableArray *unlockedCards;
// (Roger) The last sign on and creation date will be implemented later
// (Roger) (Question) What is the difference between last signed on and signed on?
//@property (nonatomic, retain) NSString *lastSignedOn;
//@property (nonatomic, retain) NSString *accountCreatedOn;
//@property (nonatomic, retain) NSString *signedOn;



@end
