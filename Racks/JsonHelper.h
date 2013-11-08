//
//  JsonHelper.h
//  Racks
//
//  Created by Mercedes Bünz on 05.11.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef void (^requestCompletedBlock)(id);
typedef void (^requestErrorBlock)(NSError *);
@interface JsonHelper : NSObject<NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    NSString *searchParam;
    NSString *inputUrl;
}
// Block approach
@property (nonatomic, copy) requestCompletedBlock completed;
@property (nonatomic, copy) requestErrorBlock errored;

//
//@property(nonatomic, strong) NSURLConnection *connection;
//@property(nonatomic, strong) NSURLResponse *response;
//@property(nonatomic, strong) NSData *responseData;
//@property(nonatomic, strong) NSCondition *condition;
//@property(nonatomic, strong) NSError *error;
//@property(nonatomic) BOOL connectionDidFinishLoading;

// My approach
@property NSString *returnUrl;

-(id) initWithParam:(NSString*)searchParameter AndUrl:(NSString*)url;

// Block
- (void)makeRequest:(requestCompletedBlock)completed error:(requestErrorBlock)error;

@end
