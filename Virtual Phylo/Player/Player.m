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
    if (exists)
    {
        NSLog(@"Creating data file for %@", username);
        NSArray *paths = NSSearchPathForDirectoriesInDomains
        (NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        //make a file name to write the data to using the documents directory:
        NSString *fileName = [NSString stringWithFormat:@"%@/%@.txt",
                              documentsDirectory, username];
        
        //instantiates 0 wins 0 loses on creation of player
        NSString *data = @"0;0\nTrue";
        
        NSLog(data);
        
        [data writeToFile:fileName
               atomically:NO
                encoding:NSStringEncodingConversionAllowLossy
                   error:nil];
    }
}

- (BOOL) createDeck:(NSString *)username deckName:(NSString *)deckname cardArray:(NSArray *)cards {
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
    NSString *array = [cards componentsJoinedByString:@","];

    NSString *data = [NSString stringWithFormat:@"%@;%@", deckname, array];
    //NSLog(@"array : %@", array);
    if (!exists) {
        //NSLog(@"Doesn't exist");
        NSLog(@"%lu", (unsigned long)data);
        [data writeToFile:fileName
               atomically:NO
                 encoding:NSStringEncodingConversionAllowLossy
                    error:nil];
        return true;
    }
    else {
        NSString *contents = [[NSString alloc] initWithContentsOfFile:fileName encoding:nil error:nil];
        NSArray *filecontent = [contents componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"]];
        //NSLog(@"Contents are, %@", [filecontent description]);
        //Check if deck with name already exists
        //NSLog(@"Count is, %lu", (unsigned long)[filecontent count]);
        for (int i = 0; i <= ([filecontent count] - 1); i++) {
            NSArray *line = [filecontent[i] componentsSeparatedByString:@","];
            NSArray *lineName = [line[0] componentsSeparatedByString:@";"];
            if ([lineName[0] isEqualToString:deckname]) {
                //NSLog(@"Deck Exists!");
                return false;
            }
        }
        //NSLog(contents);
        NSString *datamodified = [NSString stringWithFormat:@"%@\n%@", contents, data];
        //NSLog([datamodified description]);
        [datamodified writeToFile:fileName
               atomically:NO
                 encoding:NSStringEncodingConversionAllowLossy
                    error:nil];
        return true;
    }
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

- (void) playerWin:(BOOL)win withusername:(NSString *)username {
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@/%@.txt",
                          documentsDirectory, username];
    NSString *content = [[NSString alloc] initWithContentsOfFile:fileName
                                                    usedEncoding:nil
                                                           error:nil];
    NSArray *data = [content componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"]];
    
    NSArray *line = [data[0] componentsSeparatedByString:@";"];
    int playerwin = [line[0] intValue];
    int playerlose = [line[1] intValue];
    
    if (win)
        playerwin += 1;
    else
        playerlose += 1;
    
    NSMutableArray *mutable = [[NSMutableArray alloc] init];
    NSString *stats = [NSString stringWithFormat:@"%i;%i", playerwin, playerlose];
    NSLog(@"Stats are, %@", stats);
    [mutable addObject: stats];
    NSLog([data count]);
    for (int i = 0; i < ([data count] - 1); i++) {
        if (!(i%2) && (i != 2))
            [mutable addObject:data[i]];
    }
    
    
    NSString *contents = [[NSString alloc] initWithContentsOfFile:fileName encoding:nil error:nil];
    NSString *datamodified = [NSString stringWithFormat:@"%@\n%@", contents, mutable];
    NSLog(@"Data modfied is, %@", datamodified);
    //NSLog([datamodified description]);
    [datamodified writeToFile:fileName
                   atomically:NO
                     encoding:NSStringEncodingConversionAllowLossy
                        error:nil];
    
}

- (BOOL) checkExistance:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *location = [NSString stringWithFormat:@"%@/%@.txt",
                          documentsDirectory, name];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:location])
        return true;
    else
        return false;
}

@end


