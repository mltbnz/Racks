//
//  Artist.h
//  Racks
//
//  Created by Mercedes Bünz on 06.06.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Artist : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * wikiLink;
@property (nonatomic, retain) NSSet *released;
@end

@interface Artist (CoreDataGeneratedAccessors)

- (void)addReleasedObject:(Release *)value;
- (void)removeReleasedObject:(Release *)value;
- (void)addReleased:(NSSet *)values;
- (void)removeReleased:(NSSet *)values;

 
@end
