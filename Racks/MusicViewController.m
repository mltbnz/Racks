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
@property (nonatomic, strong) RacksDataManager *dataManager;

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
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchButtonAction:)];
    UIBarButtonItem *scanMusicButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(scanButtonAction:)];
    
    NSArray *buttonsArray = [[NSArray alloc] initWithObjects:scanMusicButton, searchButton, nil];
    
    self.navigationItem.rightBarButtonItems = buttonsArray;
    
    self.musicTable.contentOffset = CGPointMake(0.0, self.searchBar.frame.size.height);
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - UiTableViewDataSource



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellCall");
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
