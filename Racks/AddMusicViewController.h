//
//  AddMusicViewController.h
//  Racks
//
//  Created by Mercedes Bünz on 24.06.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMusicViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate> {
    IBOutlet UITextField *artistText;
    IBOutlet UITextField *albumText;
    IBOutlet UITextField *labelText;
    IBOutlet UIScrollView *myScrollView;
    CGPoint scrollPoint;
    CGPoint viewCenter;
    CGFloat offset;
}

//
//@property (weak, nonatomic) IBOutlet UITextField *nextTextField;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UILabel *overviewLabel;
@property (weak, nonatomic) IBOutlet UIToolbar *bottomNavBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;


- (void)textFieldDidBeginEditing:(UITextField*)textField;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;

@end
