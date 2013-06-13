//
//  RacksDataManager.h
//  Racks
//
//  Created by Mercedes Bünz on 13.06.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

#define DBNAME @"racksDataBase"

@interface RacksDataManager : NSManagedObject

@property (nonatomic, strong) UIManagedDocument *dbDocument;
@property (nonatomic, strong) NSFetchedResultsController *fetchResultsController;

+ (id)sharedDocument;

@end
