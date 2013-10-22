//
//  ArtistAlbumViewController.h
//  Racks
//
//  Created by Mercedes Bünz on 13.09.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//
#define LASTFMSEARCHALBUMURL @"http://ws.audioscrobbler.com/2.0/?method=artist.gettopalbums&artist="
#define LASTFMKEY @"&api_key=70d53fc392eddafb7d6b0d2f1c5a2e0a"
#define RETURNTYPE @"&format=json"

#define LASTFMSEARCHINFOURL @"http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist="

#import <UIKit/UIKit.h>
#import "AlbumViewController.h"
#import "UIImageView+WebCache.h"

@interface ArtistAlbumViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSOperationQueue *imageOperationQueue;
@property (nonatomic, strong) NSCache *imageCache;
@property NSString* artistName;

- (NSString*) createUrl:(NSString*) searchString;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end
