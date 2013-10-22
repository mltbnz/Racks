//
//  AlbumViewController.m
//  Racks
//
//  Created by Mercedes Bünz on 17.10.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import "AlbumViewController.h"

@interface AlbumViewController ()

@end

@implementation AlbumViewController

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
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(backButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = backButton;
    
    if (self.albumImage)
    {
        self.imageView.image = self.albumImage;
        [self.imageView sizeToFit];
    }
    else
    {
        UIImage *placeholderImage = [UIImage imageNamed:@"placeholder.jpg"];
        self.imageView.image = placeholderImage;
        [self.imageView sizeToFit];
    }
    
    self.artistTextField.text = self.artistName;
    self.albumTextField.text = self.albumName;
    
    // Do any additional setup after loading the view.
//    self.imageView = [[UIImage alloc] initWithImage:[self.albumImage]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


# pragma mark - Functions

- (IBAction)backButtonAction:(id)sender
{
    // NSLog(@"TEST2");
    [self performSegueWithIdentifier:@"backToArtistAlbumVC" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"searchSegue"])
    {
        
    } else if ([[segue identifier] isEqualToString:@"scanSegue"]) {
        
    }
}



@end
