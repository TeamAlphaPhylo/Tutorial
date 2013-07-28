//
//  Player.m
//  Virtual Phylo
//
//  Created by Petr Krakora on 2013-07-20.
//  Copyright (c) 2013 Group_12. All rights reserved.
//

#import "Player.h"

@implementation Player

+(void) createPlayer:(NSString *)username {
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
        // (Roger) Set up the default deck over here 
        NSString *data = @"0;0\nTrue\nDefault;0!1!2!3!4!5!10!20!30";
        
        NSLog(@"%@", data);
        
        [data writeToFile:fileName
               atomically:NO
                 encoding:NSStringEncodingConversionAllowLossy
                    error:nil];
    }
}

+(BOOL) createDeck:(NSString *)username deckName:(NSString *)deckname cardArray:(NSArray *)cards {
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
    array = [array stringByReplacingOccurrencesOfString:@"," withString:@"!"];
    
    NSString *data = [NSString stringWithFormat:@"%@;%@", deckname, array];
    //NSLog(data);
    if (!exists) {
        //NSLog(@"Doesn't exist");
        //NSLog(@"%lu", (unsigned long)data);
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
        [datamodified writeToFile:fileName
                       atomically:NO
                         encoding:NSStringEncodingConversionAllowLossy
                            error:nil];
        return true;
    }
}

+(NSMutableArray *) getDecks:(NSString *)username {
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@/%@.txt",
                          documentsDirectory, username];
    NSString *content = [[NSString alloc] initWithContentsOfFile:fileName
                                                    usedEncoding:nil
                                                           error:nil];
    NSArray *data = [content componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"]];
    NSMutableArray *decks = [[NSMutableArray alloc] init];
    
    //Add elements from array that aren't the stats and sync
    for (int i = 2; i < ([data count]); i++) {
        [decks addObject:data[i]];
    }
    return decks;
}

+(void) playerWin:(BOOL)win withusername:(NSString *)username {
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
    
    //For ease to programming gets length of stats for flexiblity
    int length = [data[0] length];
    NSLog(@"Length is: %i", length);
    NSString *status = [NSString stringWithFormat:@"%i;%i", playerwin, playerlose];
    NSRange range = NSMakeRange(0,length);
    content = [content stringByReplacingCharactersInRange:range withString: status];
    NSString *datamodified = [NSString stringWithFormat:@"%@", content];
    [datamodified writeToFile:fileName
                   atomically:NO
                     encoding:NSStringEncodingConversionAllowLossy
                        error:nil];
}

+(NSString *) getStats:(NSString *)username {
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@/%@.txt",
                          documentsDirectory, username];
    NSString *content = [[NSString alloc] initWithContentsOfFile:fileName
                                                    usedEncoding:nil
                                                           error:nil];
    NSArray *data = [content componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"]];
    
    NSString *stats = data[0];
    return stats;
}

+(NSString *) getSync:(NSString *)username {
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@/%@.txt",
                          documentsDirectory, username];
    NSString *content = [[NSString alloc] initWithContentsOfFile:fileName
                                                    usedEncoding:nil
                                                           error:nil];
    NSArray *data = [content componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"]];
    NSString *sync = data[1];
    return sync;
}

+(void) deleteDeck:(NSString *)username deckname:(NSString *)deckname {
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@/%@.txt",
                          documentsDirectory, username];
    NSString *content = [[NSString alloc] initWithContentsOfFile:fileName
                                                    usedEncoding:nil
                                                           error:nil];
    NSArray *data = [content componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"]];
    NSLog(@"count = %d", [data count]);
    NSMutableArray *mutable = [[NSMutableArray alloc] init];
    for (int i = 0; i < [data count]; i++) {
        NSArray *line = [data[i] componentsSeparatedByString:@";"];
        NSString *name = line[0];
        if (![name isEqualToString:deckname]) {
            //NSLog(@"Name is : %@ and comparing it to : %@", name, deckname);
            [mutable addObject:data[i]];
        }
    }
    
    NSString * datamodified = [[mutable valueForKey:@"description"] componentsJoinedByString:@","];
    datamodified = [datamodified stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
    datamodified = [datamodified stringByReplacingOccurrencesOfString:@"," withString:@""];
    [datamodified writeToFile:fileName
                   atomically:NO
                     encoding:NSStringEncodingConversionAllowLossy
                        error:nil];
    NSLog(@"finished without problems");
}

+(BOOL) checkExistance:(NSString *)name {
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

