//
//  ArtistAlbumViewController.h
//  Racks
//
//  Created by Mercedes Bünz on 13.09.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlbumViewController.h"
#import "UIImageView+WebCache.h"
#import "Constants.h"

@interface ArtistAlbumViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSOperationQueue *imageOperationQueue;
@property (nonatomic, strong) NSCache *imageCache;
@property NSString* artistName;

- (NSString*) createUrl:(NSString*) searchString;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end
