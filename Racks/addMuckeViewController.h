//
//  addMuckeViewController.h
//  Racks
//
//  Created by Mercedes Bünz on 28.06.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addMuckeViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIScrollViewDelegate, UISearchBarDelegate>
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
