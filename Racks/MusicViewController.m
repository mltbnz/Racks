//
//  MusicViewController.m
//  Racks
//
//  Created by Mercedes Bünz on 05.06.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import "MusicViewController.h"

@interface MusicViewController ()

//@property (nonatomic, strong) NSFetchedResultsController *resultsController;

@end

@implementation MusicViewController

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
    // Core Data Stuff
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    // Fetching Records and saving it in "fetchedRecordsArray" object
    self.fetchedRecordsArray = [appDelegate getAllRecordsFromDB];
    [self.tableView reloadData];
    
    // Button Stuff
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchButtonAction:)];
    UIBarButtonItem *scanMusicButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(scanButtonAction:)];
    NSArray *buttonsArray = [[NSArray alloc] initWithObjects:scanMusicButton, searchButton, self.editButtonItem, nil];
    self.navigationItem.rightBarButtonItems = buttonsArray;
    self.musicTable.contentOffset = CGPointMake(0.0, self.searchBar.frame.size.height);
    //
    //    self.navigationItem.leftBarButtonItem = self.editButtonItem;
//    NSSortDescriptor *sortParam= [NSSortDescriptor sortDescriptorWithKey:@"Artist" ascending:YES];
//
//    NSArray *sortDescriptors = [NSArray arrayWithObject:sortParam];
//    NSArray *sortedArray = [self.fetchedRecordsArray sortedArrayUsingDescriptors:sortDescriptors];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - UiTableViewDataSource

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
    //    NSLog(@"cellCall");
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
    cell.imageView.image = [UIImage imageWithData:release.picture];
    cell.detailTextLabel.text = release.name;
    
    return cell;
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

#pragma mark - Fetched results controller

//- (NSFetchedResultsController *)fetchedResultsController
//{
//    // Set up the fetched results controller if needed.
//    if (fetchedResultsController == nil)
//    {
//        // Create the fetch request for the entity.
//        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//        // Edit the entity name as appropriate.
//        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Record" inManagedObjectContext:managedObjectContext];
//        [fetchRequest setEntity:entity];
//
//        // Edit the sort key as appropriate.
//        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
//        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
//
//        [fetchRequest setSortDescriptors:sortDescriptors];
//
//        // Edit the section name key path and cache name if appropriate.
//        // nil for section name key path means "no sections".
//        NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
//        aFetchedResultsController.delegate = self;
//        self.fetchedResultsController = aFetchedResultsController;
//    }
//
//	return fetchedResultsController;
//}

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
    // sNSLog(@"TEST1");
    //    ScanViewController *scanView = [[ScanViewController alloc] init];
    //    [self presentViewController:scanView animated:YES completion:NULL];
    [self performSegueWithIdentifier:@"scanSegue" sender:self];
}

- (IBAction)searchButtonAction:(id)sender
{
    // NSLog(@"TEST2");
    [self performSegueWithIdentifier:@"searchSegue" sender:self];
}

# pragma mark - Functions

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"searchSegue"])
    {
        
    } else if ([[segue identifier] isEqualToString:@"scanSegue"]) {
        
    }
}

@end
