//
//  addMuckeViewController.h
//  Racks
//
//  Created by Mercedes Bünz on 28.06.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//
#define DiscogsURL @"http://api.discogs.com/database/search?type=release&q="
#define returnType @"&f=json"

#import <UIKit/UIKit.h>

@interface addMuckeViewController : UIViewController <UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate, UIScrollViewDelegate, UISearchBarDelegate>
{
    IBOutlet UITextField *artistText;
    IBOutlet UITextField *albumText;
    IBOutlet UITextField *labelText;
    IBOutlet UIScrollView *myScrollView;
    CGPoint scrollPoint;
    CGPoint viewCenter;
    CGFloat offset;
    CGFloat animatedDistance;
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIToolbar *bottomNavBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end
