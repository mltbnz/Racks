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
    SDWebImageManager *manager;
    SDImageCache *sharedImageCache;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [self.navigationItem.leftBarButtonItem setTitle:@"back"];
    
    self.imageOperationQueue = [[NSOperationQueue alloc]init];
    self.imageOperationQueue.maxConcurrentOperationCount = 4;
    
    self.imageCache = [[NSCache alloc] init];
    
    NSString* url = [self createUrl:self.artistName];
    NSURLRequest *request   = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *conn   = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
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
    if ([albumNames count] > 0) {
        return [albumNames count];
    }
    else
    {
        return 1;
        UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The Data could not be fetched." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
//        NSLog(@"ERROR: %@", error);
        [errorView show];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"cellCall");
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier];
    }
    NSString* albumName = [albumNames objectAtIndex:indexPath.row];
    
    
    NSString *url = [[[[albumImages objectAtIndex:indexPath.row] objectForKey:@"image"] objectAtIndex:2] objectForKey:@"#text"];
//    NSURL *imageURL = [NSURL URLWithString:url];
    
    // WebImage
    [cell.imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
    
/*
    [manager downloadWithURL:imageURL
                     options:0
                    progress:^(NSUInteger receivedSize, long long expectedSize)
     {
         // progression tracking code
     }
        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
     {
         if (image != nil)
         {             
             NSString *localKey = [NSString stringWithFormat:@"Item-%@", albumName];
             NSLog(@"%@", localKey);
             [sharedImageCache storeImage:image forKey:localKey];
             [cell.imageView setImageWithURL:imageURL];
         }
         else
         {
             cell.imageView.image = [UIImage imageNamed:@"placeholder.jpg"];
             
         }
     }];
    
//    NSLog(@"Albumname: %@\n!", albumName);

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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      
    return cell;
    
    [self.tableView reloadData];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   
    // AlbumViewController *albumViewController = [[AlbumViewController alloc] init];
    
    [self performSegueWithIdentifier:@"toAlbumSegue" sender:self];
}

#pragma mark - NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    jsonData = [[NSMutableData alloc] init];
    albumNames = [[NSMutableArray alloc] init];
    albumImages = [[NSMutableArray alloc] init];
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
        albumImages = [[jsonDict objectForKey:@"topalbums"] objectForKey:@"album"];
    }
    
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
    return urlConverted;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toAlbumSegue"])
    {
        AlbumViewController *destViewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSString *destinationTitle = [albumNames objectAtIndex:indexPath.row];
        destViewController.albumName = destinationTitle;
        destViewController.artistName = self.artistName;
        
        UITableViewCell *selectedCell = [self.tableView cellForRowAtIndexPath:indexPath];
        UIImage *destImage = selectedCell.imageView.image;
        destViewController.albumImage = destImage;

        UINavigationController *thisNavController = self.navigationController;
        destViewController.navController = thisNavController;
//        UIViewController *thisView = self;
//        destViewController.previousView = thisView;
        [destViewController setTitle:destinationTitle];
    }
}

@end
