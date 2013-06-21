//
//  RacksDataManager.m
//  Racks
//
//  Created by Mercedes Bünz on 13.06.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import "RacksDataManager.h"

@implementation RacksDataManager

@dynamic dbDocument;


+ (id)sharedDocument
{
    static RacksDataManager *sharedDocument;
    if (!sharedDocument) {
        sharedDocument = [[RacksDataManager alloc] init];
    }
    return sharedDocument;
}

/**
 *  
 */
- (UIManagedDocument *)dbDocument;
{
    if (self.dbDocument) return self.dbDocument;
    // findet heraus wo die Ordnerstruktur liegt
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    // url speichert den gefundenen Pfad
    url = [url URLByAppendingPathComponent:DBNAME];
    // Speicher allozieren
    self.dbDocument = [[UIManagedDocument alloc] initWithFileURL:url];
    if ([self.dbDocument documentState] == UIDocumentStateClosed) {
        [self.dbDocument openWithCompletionHandler:^(BOOL success) {
            if (!success) {
                [self setupDatabaseFile];
            }
        }];
    }
    return self.dbDocument;
}


/**
 *
 */
- (void)setupDatabaseFile
{
    [self.dbDocument saveToURL:self.dbDocument.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Jawoll");
        }
    }];
}

@end
