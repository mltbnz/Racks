//
//  AlbumViewController.h
//  Racks
//
//  Created by Mercedes Bünz on 17.10.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ArtistAlbumViewController.h"
#import "Release.h"
#import "Artist.h"
#import "AppDelegate.h"
#import "MusicViewController.h"
#import "UIImageView+WebCache.h"
#import "Constants.h"

@interface AlbumViewController : UIViewController<NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
//    NSString *albumName;
//    NSString *artistName;
//    NSString *labelName;
//    NSString *releaseDate;
//    NSString *imageUrl;
    NSData *imageData;
}

@property NSString *artistName;
//@property NSString *barcode;
@property NSString *albumName;
@property NSString *releaseDate;
@property NSString *labelName;
//@property NSString *jsonURL;
@property NSString *imageUrl;
@property NSData *albumImage;
@property BOOL isScan;
//
@property UIViewController *previousView;
@property UINavigationController *navController;
//
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *artistTextField;
@property (weak, nonatomic) IBOutlet UITextView *albumTextField;
@property (weak, nonatomic) IBOutlet UITextView *desTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UILabel *releaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *labelLabel;
//
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSArray *fetchedResultsArray;
//////////
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

- (id)initWithAlbumname:(NSString*)passAlbumName AndArtistName:(NSString*)passArtistName AndReleaseDate:(NSString*)passReleaseDate AndLabelName:(NSString*)passLabelName AndImageData:(NSData*)passImageData AndIsScan:(BOOL*)passIsScan;
- (id)initWithAlbumnameAndURL:(NSString*)passAlbumName AndArtistName:(NSString*)passArtistName AndLabelName:(NSString*)passLabelName AndImageUrl:(NSString*)passImageUrl AndIsScan:(BOOL*)passIsScan;

@end
