//
//  Player.m
//  Virtual Phylo
//
//  Created by Petr Krakora on 2013-07-20.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import "Player.h"

@implementation Player

- (void) createPlayer:(NSString *)username {
    BOOL exists = true;
    exists = [self checkExistance:username];
    if (!exists)
    {
        NSLog(@"Creating data file for %@", username);
        NSArray *paths = NSSearchPathForDirectoriesInDomains
        (NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        //make a file name to write the data to using the documents directory:
        NSString *fileName = [NSString stringWithFormat:@"%@/%@.txt",
                              documentsDirectory, username];
        NSString *data = @"";
        
        [data writeToFile:fileName
               atomically:NO
                 encoding:NSStringEncodingConversionAllowLossy
                    error:nil];
    }
}

- (NSString *) createDeck:(NSString *)username deckname:(NSString *)deckname cards:(NSArray *)cards {
    BOOL exists = true;
    NSString *deckName = [NSString stringWithFormat:@"%@Decks", username];
    exists = [self checkExistance:deckName];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/%@.txt",
                          documentsDirectory, username];
    
    //Makes string in the format Deckname;CardArray
    NSString *data = [NSString stringWithFormat:@"%@;%@", deckname, cards];
    
    if (!exists) {
        [data writeToFile:fileName
               atomically:NO
                 encoding:NSStringEncodingConversionAllowLossy
                    error:nil];
        return true;
    }
    else {
        NSString *contents = [[NSString alloc] initWithContentsOfFile:fileName encoding:nil error:nil];
        NSArray *filecontent = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"]];
        
        for (int i = 0;([filecontent count] - 1); i++) {
            NSArray *line = [filecontent[i] componentsSeparatedByString:@","];
            if ([line[0] isEqualToString:username]);
                return false;
        }
        NSString *datamodified = [NSString stringWithFormat:@"%@\n%@", contents, data];
        [datamodified writeToFile:fileName
               atomically:NO
                 encoding:NSStringEncodingConversionAllowLossy
                    error:nil];
        return true;
    }
}

- (void) deleteDeck {
    //Not implemented
}

- (NSArray *) getDecks:(NSString *)username {
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@/%@.txt",
                          documentsDirectory, username];
    NSString *content = [[NSString alloc] initWithContentsOfFile:fileName
                                                    usedEncoding:nil
                                                           error:nil];
    NSArray *data = [content componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"]];
    return data;
}

- (BOOL *) checkExistance:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *location = [NSString stringWithFormat:@"%@/%@.txt",
                          documentsDirectory, name];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:location])
        return false;
    else
        return true;
}

@end


