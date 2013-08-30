//
//  SearchMusicViewController.h
//  Racks
//
//  Created by Mercedes Bünz on 23.08.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//
#define DiscogsURL @"http://api.discogs.com/database/search?type=release&q="
#define returnType @"&f=json"

#import <UIKit/UIKit.h>

@interface SearchMusicViewController : UITableViewController<UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;


- (NSURL*) createUrl:(NSString*) searchString;
- (void) fetchedData:(NSData*)responseData;
- (void) getToken:(NSString*) token;

@end
