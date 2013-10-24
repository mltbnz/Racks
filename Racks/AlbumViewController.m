//
//  AlbumViewController.m
//  Racks
//
//  Created by Mercedes Bünz on 17.10.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import "AlbumViewController.h"

@interface AlbumViewController ()

@end

@implementation AlbumViewController
{
    NSMutableData* jsonData;
    NSMutableDictionary* jsonDict;
    NSString *albumSummary;
    NSString *albumRelease;
    NSString *albumLabel;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // NavBar add Button Function
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 55, 35);
    [button setTitle:@"back" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(backButtonAction:)];
//    self.navigationItem.leftBarButtonItem = backButton;
    self.navBar.topItem.leftBarButtonItem = customBarItem;
    self.navBar.topItem.title = [NSString stringWithFormat:@"%@ - %@", self.artistName, self.albumName];
    
    // check if image was passed by View
    if (self.albumImage != nil)
    {
        self.imageView.image = self.albumImage;
        [self.imageView sizeToFit];
    }
    else
    {
        UIImage *placeholderImage = [UIImage imageNamed:@"placeholder.jpg"];
        self.imageView.image = placeholderImage;
        [self.imageView sizeToFit];
    }
    
    // Set properties
    self.artistTextField.text = self.artistName;
    self.albumTextField.text = self.albumName;
    
    // Load albuminfo
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString* url = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",LASTFMALBUMINFOURL,LASTFMKEY,ARTIST,self.artistName,ALBUM,self.albumName,RETURNTYPE];
    NSString *urlConverted = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",urlConverted);
    NSURLRequest *request   = [NSURLRequest requestWithURL:[NSURL URLWithString:urlConverted]];
    NSURLConnection *conn   = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
//    NSLog(@"didReceiveResponse");
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
//    NSLog(@"Verbindung steht");
    jsonData = [[NSMutableData alloc] init];

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to the instance variable you declared
    // NSLog(@"Received %d bytes of data",[data length]);
    [jsonData appendData:data];
    // NSLog(@"Received %d bytes of totalData",[jsonData length]);
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse
{
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // NSLog(@"connectionDidFinishLoading");
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSError* error;
    jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    if ([jsonDict count] == 0)
    {
        NSLog(@"Error parsing JSON: %@", error);
    }
    else
    {
        albumRelease = [[jsonDict objectForKey:@"album"] valueForKey:@"releasedate"];
        self.releaseLabel.text = albumRelease;
        albumSummary = [[[jsonDict objectForKey:@"album"] objectForKey:@"wiki"] valueForKey:@"content"];
        self.desTextField.text = albumSummary;
//        albumNames = [[[jsonDict objectForKey:@"topalbums"] objectForKey:@"album"] valueForKey:@"name"];
//        NSLog(@"Size albumNames: %i", [albumNames count]);
//        albumImages = [[jsonDict objectForKey:@"topalbums"] objectForKey:@"album"];
    }
    
//    NSLog(@"%@", [albumImages objectAtIndex:0]);
    
//    [self.tableView reloadData];
}

# pragma  mark - Functions

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // The request has failed for some reason!
    // Check the error var
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The Download could not be completed - Please make sure you are either connected to 3G or Wi-Fi." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    NSLog(@"ERROR: %@", error);
    [errorView show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (IBAction)backButtonAction:(id)sender
{
    // NSLog(@"TEST2");
    [self.navigationController popToViewController:self.previousView animated:YES];
//    [self performSegueWithIdentifier:@"backToArtistAlbumVC" sender:self];
}





@end
