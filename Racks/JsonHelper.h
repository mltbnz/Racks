//
//  JsonHelper.h
//  Racks
//
//  Created by Mercedes Bünz on 05.11.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface JsonHelper : NSObject<NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    NSString *searchParam;
    NSString *inputUrl;
}

@property NSString *returnUrl;

-(id) initWithParam:(NSString*)searchParameter AndUrl:(NSString*)url;

@end
