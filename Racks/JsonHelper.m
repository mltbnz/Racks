//
//  JsonHelper.m
//  Racks
//
//  Created by Mercedes Bünz on 05.11.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import "JsonHelper.h"

@implementation JsonHelper
{
    NSMutableData* jsonData;
    NSMutableDictionary* jsonDict;    
}

-(id) init
{
    return self;
}

-(id) initWithParam:(NSString*)searchParameter AndUrl:(NSString *)url
{
    if (self = [super init]) {
        searchParam = searchParameter;
        inputUrl = url;
    }
    [self makeConnection];
    return self;
};

#pragma mark - NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    jsonData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to the instance variable you declared
    [jsonData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse
{
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError* error;
    NSString *result;
    
    if (jsonData)
    {
        jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    }
    
    if ([jsonDict count] == 0)
    {
        NSLog(@"Error parsing JSON: %@", error);
    }
    else
    {
        if ([searchParam isEqualToString:@"resource_url"])
        {
            result = [[[jsonDict objectForKey:@"results"] objectAtIndex:0] valueForKey:searchParam];
            self.returnUrl = result;
        }
        else if ([searchParam isEqualToString:@"uri150"])
        {
            result = [[[jsonDict objectForKey:@"images"] objectAtIndex:0] valueForKey:searchParam];
            self.returnUrl = result;
        }
    }
    NSLog(@"Result: %@", result);

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // The request has failed for some reason!
    // Check the error var
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The Download could not be completed - Please make sure you are either connected to 3G or Wi-Fi." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    NSLog(@"ERROR: %@", error);
    [errorView show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

# pragma mark - Functions

-(void) makeConnection
{
    NSString* url = [NSString stringWithFormat:@"%@",inputUrl];
    NSString *urlConverted = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"%@",urlConverted);
    NSURLRequest *request   = [NSURLRequest requestWithURL:[NSURL URLWithString:urlConverted]];
    NSURLConnection *conn   = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

@end
