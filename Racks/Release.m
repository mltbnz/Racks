//
//  Release.m
//  Racks
//
//  Created by Mercedes Bünz on 28.10.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import "Release.h"
#import "Artist.h"


@implementation Release

@dynamic label;
@dynamic name;
@dynamic picture;
@dynamic releaseDate;
@dynamic text;
@dynamic releasedBy;

+ (BOOL)allowsReverseTransformation {
	return YES;
}

+ (Class)transformedValueClass {
	return [NSData class];
}


- (id)transformedValue:(id)value {
	NSData *data = UIImagePNGRepresentation(value);
	return data;
}


- (id)reverseTransformedValue:(id)value {
	UIImage *uiImage = [[UIImage alloc] initWithData:value];
//	return [uiImage autorelease];
}

@end
