//
//  MusicViewController.h
//  Racks
//
//  Created by Mercedes Bünz on 05.06.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "SearchMusicViewController.h"
#import "ScanViewController.h"
#import "Release.h"
#import "AppDelegate.h"
#import "AlbumViewController.h"
#import "ZBarSDK.h"
#import "JsonHelper.h"
#import "Constants.h"
#import <QuartzCore/QuartzCore.h>

@interface MusicViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, UINavigationControllerDelegate, ZBarReaderDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate>;

@property (weak, nonatomic) IBOutlet UITableView *musicTable;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *scanMusicButton;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) UIView *MusicViewController;
@property (nonatomic,strong) NSArray* fetchedRecordsArray;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (IBAction)scanButtonAction:(id)sender;
- (IBAction)searchButtonAction:(id)sender;

@end
