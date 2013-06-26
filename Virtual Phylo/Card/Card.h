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
    int card_no;
    id card_image;
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
@end
