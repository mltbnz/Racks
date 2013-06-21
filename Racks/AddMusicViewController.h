//
//  AddMusicViewController.h
//  Racks
//
//  Created by Mercedes Bünz on 17.06.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Artist;
@class Release;

@interface AddMusicViewController : UITableViewController

// Properties for UI
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UISearchBar *searchOnline;
@property (weak, nonatomic) IBOutlet UITableView *addTable;
// Property data
@property NSArray *Artists;
// Properties for classes
@property (nonatomic, strong) Artist *artist;
@property (nonatomic, strong) Release * release;
// Cells
@property (weak, nonatomic) IBOutlet UITableViewCell *cellArtist;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellAlbumTitle;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellLabel;
@property (weak, nonatomic) IBOutlet UITableViewCell *cellReleaseYear;


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;


@end
