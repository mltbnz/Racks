//
//  SearchMusicViewController.h
//  Racks
//
//  Created by Mercedes Bünz on 23.08.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//
// Url's
#define DISCOGSURL @"http://api.discogs.com/database/search?type=release&q="
#define RETURNTYPE @"&format=json"
#define ROVIURL @"http://api.rovicorp.com/search/v2.1/music/autocomplete?"
#define LASTFMSEARCHARTISTURL @"http://ws.audioscrobbler.com/2.0/?method=artist.search&artist="
// API Keys
#define AUTOCOMPLETEKEY @"cfxhrmdbmhtn275wn9r5j49h"
#define AUTOCOMPLETESECRET @"5vbmNmWVj6"
#define SEARCHKEY @"r9grg9arayybsj863kpx6qy6"
#define SEARCHSECRET @"eSdE5eZyBc"
#define LASTFMKEY @"&api_key=70d53fc392eddafb7d6b0d2f1c5a2e0a"


#import <UIKit/UIKit.h>
#import "ArtistAlbumViewController.h"

@interface SearchMusicViewController : UITableViewController<UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate, NSURLConnectionDelegate, UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (NSString*) createUrl:(NSString*) searchString;
//- (NSMutableArray*) fetchedData:(NSData*)responseData;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end
