//
//  Singleton.h
//  Racks
//
//  Created by Mercedes Bünz on 31.10.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject
{
    NSMutableArray *fetchedCoreDataResults;
}

@property (readwrite) NSMutableArray *fetchedCoreDataResults;

+ (id *) getData;

@end
