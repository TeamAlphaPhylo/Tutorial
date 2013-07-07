//
//  MasterCard.h
//  Virtual Phylo
//
//  Created by Brandon Wong on 2013-07-05.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface MasterCard : NSObject
{
    @public
    // (Roger) Use NSMutableArray instead of the static array for update functions
    //    NSArray *masterCard_cards;
    
    NSMutableArray *masterCardList;
    
    // (Roger) This part is substituted by the #Define in the .m implementation
    //    @private
    //    int count;
}
@end
