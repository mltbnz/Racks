//
//  SearchMusicViewController.m
//  Racks
//
//  Created by Mercedes Bünz on 23.08.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import "SearchMusicViewController.h"

@interface SearchMusicViewController ()
{
    BOOL isFiltered;
    BOOL artistIsFiltered;
    NSMutableArray* totalData;
    NSMutableArray* filterData;
    NSMutableArray* testArray;
    NSMutableArray* artistSelectArray;
}

@end

@implementation SearchMusicViewController

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
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

# pragma mark - SearchBar Delegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{

}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //    NSLog(@"Editing");
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    // Eingabe Test
    NSString* searchString = self.searchBar.text;
    //    NSLog(@"%@", searchString);
    //
    if (self.searchBar.text.length == 0) {
        isFiltered = NO;
    }
    else
    {
        isFiltered      = YES;
        filterData      = [[NSMutableArray alloc] init];
        NSURL* url      = [self createUrl:searchString];
        NSData* data    = [NSData dataWithContentsOfURL:url];
        if (data == nil) {
            NSLog(@"Error");
        } else {
            [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
        }
    }
}

# pragma  mark - Functions

- (NSURL*) createUrl:(NSString*) searchString
{
    NSURL* url;
    NSString *theURL        = [NSString stringWithFormat:@"%@%@%@",DiscogsURL,searchString,returnType];
    NSString *urlConverted  = [theURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    url = [NSURL URLWithString:urlConverted];
    NSLog(@"%@", url);
    return url;
}

- (void) fetchedData:(NSData*)responseData
{
    NSError* error;
    NSMutableDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    if (!json)
    {
        NSLog(@"Error parsing JSON: %@", error);
    } else
    {
        [filterData addObject:[json objectForKey:@"title"]];
        [self.tableView reloadData];
    }
}

- (void) getToken:(NSString*) token
{
    
}

@end
