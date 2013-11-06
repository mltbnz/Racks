//
//  SearchMusicViewController.h
//  Racks
//
//  Created by Mercedes Bünz on 23.08.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArtistAlbumViewController.h"
#import "Constants.h"

@interface SearchMusicViewController : UITableViewController<UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate, NSURLConnectionDelegate, UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, retain) NSMutableArray *jsonArray;

- (NSString*) createUrl:(NSString*) searchString;
//- (NSMutableArray*) fetchedData:(NSData*)responseData;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end
