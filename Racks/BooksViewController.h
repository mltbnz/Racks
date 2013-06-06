//
//  BooksViewController.h
//  Racks
//
//  Created by Mercedes Bünz on 06.06.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BooksViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addBooksButton;
@property (weak, nonatomic) IBOutlet UITableView *booksTable;

@end
