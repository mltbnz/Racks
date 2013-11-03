//
//  Singleton.m
//  Racks
//
//  Created by Mercedes Bünz on 31.10.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton
@synthesize fetchedCoreDataResults;

static Singleton *_sharedClass = nil;

+ (Singleton *) getData
{
    if (!_sharedClass) {
        _sharedClass = [[self alloc] init];
    }
    return _sharedClass;
}

- (NSMutableArray * ) getFetchedCoreDataResults
{
    return fetchedCoreDataResults;
}


@end
