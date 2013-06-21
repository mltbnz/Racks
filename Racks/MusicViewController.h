//
//  MusicViewController.h
//  Racks
//
//  Created by Mercedes Bünz on 05.06.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RacksDataManager.h"

@interface MusicViewController : UITableViewController <NSFetchedResultsControllerDelegate>;

@property (weak, nonatomic) IBOutlet UITableView *musicTable;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addMusicButton;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;

@end
