//
//  AlbumViewController.h
//  Racks
//
//  Created by Mercedes Bünz on 17.10.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumViewController : UIViewController

@property NSString *artistName;
@property NSString *albumName;
@property UIImage *albumImage;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *artistTextField;
@property (weak, nonatomic) IBOutlet UITextView *albumTextField;
@property (weak, nonatomic) IBOutlet UITextView *desTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@end
