//
//  Release.h
//  Racks
//
//  Created by Mercedes Bünz on 28.10.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Artist;

@interface Release : NSManagedObject

@property (nonatomic, retain) NSString * label;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) NSString * releaseDate;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) Artist *releasedBy;

@end
