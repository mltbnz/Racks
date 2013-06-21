//
//  AddMusicViewController.m
//  Racks
//
//  Created by Mercedes Bünz on 17.06.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import "AddMusicViewController.h"
#import "Artist.h"
#import "Release.h"

@interface AddMusicViewController ()

@end

@implementation AddMusicViewController

- (IBAction)cancelAction:(id)sender {
    //self.searchOnline.showsCancelButton = 1;
    [self.searchOnline resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)numberodGroupsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
    // Dequeue and then configure a table cell for each attribute of the book.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (indexPath.row == 0) {
        return _cellArtist;
    }
    if (indexPath.row == 1) {
        return _cellAlbumTitle;
    }
    if (indexPath.row == 2) {
        return _cellLabel;
    }
    if (indexPath.row == 3) {
        return _cellReleaseYear;
    }

    return cell;
//	switch (indexPath.row) {
//        case 0: // Artist name
//			cell.textLabel.text = @"Name";
//			cell.detailTextLabel.text = self.artist.name;
//			break;
//        case 1: // Title name
//			cell.textLabel.text = @"Title";
//			cell.detailTextLabel.text = self.artist.wikiLink;
//			break;
//        case 2: // Copyright
//			cell.textLabel.text = @"Copyright";
//			cell.detailTextLabel.text = [self.dateFormatter stringFromDate:self.book.copyright];
//			break;
}
    



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_addTable setScrollEnabled:NO];
    
    // self.searchOnline.showsCancelButton = 0;
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
