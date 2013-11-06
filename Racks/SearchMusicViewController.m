//
//  SearchMusicViewController.m
//  Racks
//
//  Created by Mercedes Bünz on 23.08.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import "SearchMusicViewController.h"

@interface SearchMusicViewController ()

@end

@implementation SearchMusicViewController
{
    BOOL isFiltered;
    BOOL artistIsFiltered;
    NSMutableData* totalData;
    NSMutableArray* artistSelectArray;
    NSMutableArray* json;
    NSMutableDictionary* jsonDict;
    
    NSMutableArray* testArray;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        artistSelectArray = self.jsonArray;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.contentOffset = CGPointMake(0.0, self.searchBar.frame.size.height);
    
    self.searchBar.showsScopeBar = NO;
    self.searchBar.showsCancelButton = YES;

}

- (void) viewDidAppear:(BOOL)animated
{
    [UIView animateWithDuration: 0.3
                          delay: 0.1
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:
                    ^{
                        self.tableView.contentOffset = CGPointMake(0.0, 0.0);
                        
                     }
                     completion:^(BOOL finished)
                    {
                        [self.searchBar becomeFirstResponder];
                    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
//    if ([artistSelectArray count] != 0) {
        return [artistSelectArray count];
//    } else {
////        [self.navigationController popToRootViewControllerAnimated:NO];
//        UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The Data could not be fetched." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
//        [errorView show];
//        return 1;
//    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"cellCall");
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [artistSelectArray objectAtIndex:indexPath.row];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier: @"artistDetailSegue" sender: self];
}


# pragma mark - SearchBar Delegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
//    [artistSelectArray removeAllObjects];
//    [json removeAllObjects];
//    [jsonDict removeAllObjects];
//    [self.tableView reloadData];
    
    NSString* searchString = self.searchBar.text;
    //
    if (self.searchBar.text.length == 0) {
        isFiltered = NO;
    }
    else
    {
        isFiltered      = YES;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        NSString* url      = [self createUrl:searchString];
        NSURLRequest *request   = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        NSURLConnection *conn   = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        /*
         NSData* data    = [NSData dataWithContentsOfURL:url];
         if (data == nil) {
         NSLog(@"Error");
         } else {
         // call fetchedData here
         // NSMutableArray *artistSelectArray = [self fetchedData:data];
         }
         */
    }
    [self.searchBar resignFirstResponder];
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [self.searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{

}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self.tableView reloadData];
    // Eingabe Test

}

#pragma mark - NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    totalData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to the instance variable you declared
    [totalData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse
{
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now    
    NSError* error;
    jsonDict = [NSJSONSerialization JSONObjectWithData:totalData options:0 error:&error];   
    
    if ([jsonDict count] == 0)
    {
        NSLog(@"Error parsing JSON: %@", error);
    }
    else
    {
        artistSelectArray = [[[[jsonDict objectForKey:@"results"] objectForKey:@"artistmatches"] objectForKey:@"artist"] valueForKey:@"name"];
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.tableView reloadData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // The request has failed for some reason!
    // Check the error var
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The Download could not be completed - Please make sure you are either connected to 3G or Wi-Fi." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [errorView show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

# pragma mark - UISearchDisplayController Delegate Methods

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    return NO;
}


# pragma  mark - Functions

////
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (NSString*) createUrl:(NSString*) searchString
{
    NSString *theURL        = [NSString stringWithFormat:@"%@%@%@%@",LASTFMSEARCHARTISTURL,searchString,LASTFMKEY,RETURNTYPE];
    NSString *urlConverted  = [theURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@", urlConverted);
    return urlConverted;
}

////
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"artistDetailSegue"])
    {
        ArtistAlbumViewController *destViewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *destinationTitle = [artistSelectArray objectAtIndex:indexPath.row];
        
        destViewController.artistName = destinationTitle;
        [destViewController setTitle:destinationTitle];
        destViewController.navigationItem.backBarButtonItem.title = @"back";
    }
}


@end
