//
//  GamesViewController.h
//  Racks
//
//  Created by Mercedes Bünz on 06.06.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GamesViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addGamesButton;
@property (weak, nonatomic) IBOutlet UITableView *gamesTable;

@end
