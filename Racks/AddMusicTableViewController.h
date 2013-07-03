//
//  AddMusicTableViewController.h
//  Racks
//
//  Created by Mercedes Bünz on 22.06.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMusicTableViewController : UITableViewController
// UI
@property (strong, nonatomic) IBOutlet UITableView *addMusicTable;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;
@property (weak, nonatomic) IBOutlet UILabel *labelLabel;
@property (weak, nonatomic) IBOutlet UITextField *artistTextField;
@property (weak, nonatomic) IBOutlet UITextField *albumTextField;
@property (weak, nonatomic) IBOutlet UITextField *labelTextField;
// functions
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;


@end
