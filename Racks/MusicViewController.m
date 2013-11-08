//
//  MusicViewController.m
//  Racks
//
//  Created by Mercedes Bünz on 05.06.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import "MusicViewController.h"

@interface MusicViewController ()

@end

@implementation MusicViewController
{
    BOOL didAppear;
    NSString *albumRelease;
    NSString *albumName;
    NSString *artistName;
    NSString *labelName;
    NSString *helperUrl;
    NSString *albumId;
    NSString *imageId;
    
    NSData *helperData;
    NSMutableData* jsonData;
    NSMutableDictionary* jsonDict;
    AppDelegate* appDelegate;
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
    //
    didAppear = FALSE;
    // Core Data Stuff
    appDelegate = [UIApplication sharedApplication].delegate;
    // Fetching Records and saving it in "fetchedRecordsArray" object
    self.fetchedRecordsArray = [appDelegate getAllRecordsFromDB];
    
//    NSLog(@"%lu", (unsigned long)[self.fetchedRecordsArray count]);
    // Button Stuff
    UIImage *scanImage = [UIImage imageNamed:@"scan.png"];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchButtonAction:)];
    UIBarButtonItem *scanMusicButton = [[UIBarButtonItem alloc] initWithImage:scanImage style:UIBarButtonItemStyleBordered target:self action:@selector(scanButtonAction:)];
    NSArray *buttonsArray = [[NSArray alloc] initWithObjects:scanMusicButton, searchButton, nil];
    self.navigationItem.rightBarButtonItems = buttonsArray;
    self.musicTable.contentOffset = CGPointMake(0.0, self.searchBar.frame.size.height);
    //
}

-(void)viewDidAppear:(BOOL)animated
{
    if (didAppear)
    {
        [self.tableView reloadData];
        didAppear = TRUE;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    self.fetchedRecordsArray = [appDelegate getAllRecordsFromDB];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - UiTableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fetchedRecordsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    //
    Artist *artist = [self.fetchedRecordsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",artist.name];
    
    Release *release = [[artist.released allObjects] objectAtIndex:0];
    //
//    UIImageView *subView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 60, 60)];
//    subView.backgroundColor= [UIColor whiteColor];
//    [subView.layer setCornerRadius:8.0f];
//    [subView.layer setMasksToBounds:YES];
//    [subView setImage:[UIImage imageWithData:release.picture]];
//    [cell.contentView addSubview:subView];
    
    cell.imageView.image = [UIImage imageWithData:release.picture];
    cell.detailTextLabel.text = release.name;
    
    return cell;
    [self.tableView reloadData];
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
		NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
		[context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
		
		// Save the context.
		NSError *error;
		if (![context save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
	}
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
    NSError* error = nil;
    jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];

    if ([jsonDict count] == 0)
    {
        NSLog(@"Error parsing JSON: %@", error);
    }
    else
    {
        albumName = [[[jsonDict objectForKey:@"releases"] objectAtIndex:0] valueForKey:@"title"];
        artistName = [[[[[[jsonDict objectForKey:@"releases"] objectAtIndex:0] objectForKey:@"artist-credit"] objectAtIndex:0] objectForKey:@"artist"] valueForKey:@"name"];
        albumRelease = 	[[[jsonDict objectForKey:@"releases"] objectAtIndex:0] valueForKey:@"date"];
        labelName = [[[[[[jsonDict objectForKey:@"releases"] objectAtIndex:0] objectForKey:@"label-info"] objectAtIndex:0] objectForKey:@"label"] valueForKey:@"name"];
        albumId = [[[jsonDict objectForKey:@"releases"] objectAtIndex:0] valueForKey:@"id"];
    }
    NSLog(@"PARAMETER: %@%@%@%@",albumName,artistName,albumRelease,labelName);
//    NSLog(@"%@",urlConverted);
//    NSURLResponse * response = nil;
    
    NSString *resourceUrl = [NSString stringWithFormat:@"%@%@", MUSICBRAINZCOVERURL, albumId];
    NSString *urlConverted = [resourceUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlConverted];

//    NSURLRequest *request   = [NSURLRequest requestWithURL:[NSURL URLWithString:urlConverted]];
//    NSLog(@"Helper1: %@", resourceUrl);
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
//    
//    dispatch_sync(queue, ^{
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            helperData = data;
//            [self performSegueWithIdentifier:@"toAlbumDetailView" sender:self];
//        });
//    });

//    NSData *jsonSyncData = [[NSData alloc] init];
//    jsonSyncData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
   
    
//    if (helperData != nil)
//    {
//        helperData = jsonSyncData;
//    }
//    else
//    {
//        UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The Download could not be completed - Please make sure you are either connected to 3G or Wi-Fi." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
////        NSLog(@"ERROR: %@", error);
//        [errorView show];
//    }
    [self performSegueWithIdentifier:@"toAlbumDetailView" sender:self];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

//
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // The request has failed for some reason!
    // Check the error var
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The Download could not be completed - Please make sure you are either connected to 3G or Wi-Fi." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    NSLog(@"ERROR: %@", error);
    [errorView show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


#pragma mark - Fetched results controller

//
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

//
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

//
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}




# pragma mark - NavigationController

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [viewController viewWillAppear:animated];
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [viewController viewDidAppear:animated];
}


# pragma mark - ButtonAction

- (IBAction)scanButtonAction:(id)sender
{
    // [self performSegueWithIdentifier:@"scanSegue" sender:self];
    
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    
    [reader.scanner setSymbology: ZBAR_UPCA config: ZBAR_CFG_ENABLE to: 0];
    reader.readerView.zoom = 1.0;
    
    [self presentModalViewController: reader
                            animated: YES
     ];
}

- (IBAction)searchButtonAction:(id)sender
{
    [self performSegueWithIdentifier:@"searchSegue" sender:self];
}

# pragma mark - Functions

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"searchSegue"])
    {
        didAppear = FALSE;
    }
    else if ([[segue identifier] isEqualToString:@"scanSegue"])
    {
        didAppear = FALSE;
    }
    else if ([[segue identifier] isEqualToString:@"toAlbumDetailView"])
    {
        AlbumViewController *destViewController = [segue destinationViewController];
        destViewController.albumName = albumName;
        destViewController.artistName = artistName;
        destViewController.releaseDate = albumRelease;
        destViewController.labelName = labelName;
        destViewController.albumImage = helperData;
        destViewController.isScan = TRUE;
//        destViewController.imageURL = helperUrl;
//        [destViewController setTitle:albumName];
        didAppear = FALSE;
    }
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    
    ZBarSymbol *symbol = nil;
    
    for(symbol in results)
    {
        NSString *upcString = symbol.data;
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Scanned UPC" message:[NSString stringWithFormat:@"The UPC read was: %@", upcString] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//        [alert show];
//        NSLog(@"%@",upcString);
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSString* url = [NSString stringWithFormat:@"%@%@%@", MUSICBRAINZURL,upcString,MUSICBRAINZFORMAT];
        NSString *urlConverted = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        //    NSLog(@"%@",urlConverted);
        NSURLResponse * response = nil;
        NSError *error = nil;
        NSURLRequest *request   = [NSURLRequest requestWithURL:[NSURL URLWithString:urlConverted]];
        NSURLConnection *conn   = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
//        NSURLConnection *conn = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

        
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

@end
