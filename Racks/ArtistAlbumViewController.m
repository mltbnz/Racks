//
//  ArtistAlbumViewController.m
//  Racks
//
//  Created by Mercedes Bünz on 13.09.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import "ArtistAlbumViewController.h"

@interface ArtistAlbumViewController ()

@end

@implementation ArtistAlbumViewController
{
    NSMutableArray* albumImages;
    NSMutableArray* albumNames;
    NSMutableData* jsonData;
    NSMutableDictionary* jsonDict;
    NSMutableArray* imagesArray;
    
    
    NSMutableDictionary* test;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    self.imageOperationQueue = [[NSOperationQueue alloc]init];
    self.imageOperationQueue.maxConcurrentOperationCount = 4;
    
    self.imageCache = [[NSCache alloc] init];
    
    NSString* url = [self createUrl:self.artistName];
    NSURLRequest *request   = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *conn   = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    // NSString *infoURL = [self createUrl:<#(NSString *)#>]
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [albumNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"cellCall");
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:CellIdentifier];
    }
    NSString* albumName = [albumNames objectAtIndex:indexPath.row];
    
    // UIImage *placeholderImage = [UIImage imageNamed:@"placeholder.jpg"];
    
    NSString *url = [[[[albumImages objectAtIndex:indexPath.row] objectForKey:@"image"] objectAtIndex:2] objectForKey:@"#text"];
    NSURL *imageURL = [NSURL URLWithString:url];
    NSLog(@"URL: %@", url);
    
    // WebImage Use
    [cell.imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
//    NSLog(@"Albumname: %@\n!", albumName);
  /*
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder.jpg"];
    
    // QUEUE
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    cell.imageView.image = placeholderImage;
//    NSString *url = [[[[albumImages objectAtIndex:indexPath.row] objectForKey:@"image"] objectAtIndex:2] objectForKey:@"#text"];
//    NSURL *imageURL = [NSURL URLWithString:url];
    test = [[NSMutableDictionary alloc] init];
    
    dispatch_async(queue, ^{
            NSData *data = [NSData dataWithContentsOfURL:imageURL];
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageView.image = image;
            });
    });
    
    NSLog(@"testSize: %lu", (unsigned long)[test count]);
    for (NSMutableDictionary *yo in test) {
        NSLog(@"test: %@", yo);
    }
*/
    cell.textLabel.text = albumName;
    cell.detailTextLabel.text = self.artistName;
      
    return cell;
    
    [self.tableView reloadData];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"didSelectRowAtIndexPath");
    // Navigation logic may go here. Create and push another view controller.
     // ...
     // Pass the selected object to the new view controller.
    // [self.navigationController performSegueWithIdentifier:@"toAlbumSegue" sender:self];
    
    AlbumViewController *albumViewController = [[AlbumViewController alloc] init];
    
    [self performSegueWithIdentifier:@"toAlbumSegue" sender:self];
}

#pragma mark - NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"didReceiveResponse");
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    NSLog(@"Verbindung steht");
    jsonData = [[NSMutableData alloc] init];
    albumNames = [[NSMutableArray alloc] init];
    albumImages = [[NSMutableArray alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to the instance variable you declared
    NSLog(@"Received %d bytes of data",[data length]);
    [jsonData appendData:data];
    NSLog(@"Received %d bytes of totalData",[jsonData length]);
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse
{
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading");

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSError* error;
    jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    if ([jsonDict count] == 0)
    {
        NSLog(@"Error parsing JSON: %@", error);
    }
    else
    {
        albumNames = [[[jsonDict objectForKey:@"topalbums"] objectForKey:@"album"] valueForKey:@"name"];
        NSLog(@"Size albumNames: %i", [albumNames count]);
        albumImages = [[jsonDict objectForKey:@"topalbums"] objectForKey:@"album"];
    }
    
    NSLog(@"%@", [albumImages objectAtIndex:0]);

    [self.tableView reloadData];
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

- (NSString*) createUrl:(NSString*)searchString
{ 
    NSString *theURL        = [NSString stringWithFormat:@"%@%@%@%@",LASTFMSEARCHALBUMURL,searchString,LASTFMKEY,RETURNTYPE];
    NSString *urlConverted  = [theURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@", urlConverted);
    return urlConverted;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toAlbumSegue"])
    {
        AlbumViewController *destViewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = nil;
        
        indexPath = [self.tableView indexPathForSelectedRow];
        NSString *destinationTitle = [albumNames objectAtIndex:indexPath.row];
        destViewController.albumName = destinationTitle;
        destViewController.artistName = self.artistName;
        
        UIImage *destImage = [test objectForKey:destinationTitle];
        destViewController.albumImage = destImage;
        
        // destViewController.albumImage =
        [destViewController setTitle:destinationTitle];
        destViewController.navigationItem.backBarButtonItem.title = @"back";
    }
}

@end
