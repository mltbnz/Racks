//
//  SearchMusicViewController.h
//  Racks
//
//  Created by Mercedes Bünz on 23.08.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//
// Url's
#define DISCOGSURL @"http://api.discogs.com/database/search?type=release&q="
#define RETURNTYPE @"&f=json"
#define ROVIURL @"http://api.rovicorp.com/search/v2.1/music/autocomplete?"
// apikey=apikey&sig=sig&entitytype=artist&size=10&query=e
// API Keys
#define AUTOCOMPLETEKEY @"cfxhrmdbmhtn275wn9r5j49h"
#define AUTOCOMPLETESECRET @"5vbmNmWVj6"
#define SEARCHKEY @"r9grg9arayybsj863kpx6qy6"
#define SEARCHSECRET @"eSdE5eZyBc"


#import <UIKit/UIKit.h>

@interface SearchMusicViewController : UITableViewController<UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;


- (NSURL*) createUrl:(NSString*) searchString;
- (void) fetchedData:(NSData*)responseData;
- (void) getToken:(NSString*) token;

@end
