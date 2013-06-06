//
//  Release.h
//  Racks
//
//  Created by Mercedes Bünz on 06.06.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Artist;

@interface Release : NSManagedObject

@property (nonatomic, retain) NSString * label;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) NSDate * releaseDate;
@property (nonatomic, retain) Artist *by;


@end
