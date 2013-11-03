//
//  AlbumViewController.h
//  Racks
//
//  Created by Mercedes Bünz on 17.10.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//
#define LASTFMALBUMINFOURL @"http://ws.audioscrobbler.com/2.0/?method=album.getinfo"
#define LASTFMKEY @"&api_key=70d53fc392eddafb7d6b0d2f1c5a2e0a"
#define RETURNTYPE @"&format=json"
#define ARTIST @"&artist="
#define ALBUM @"&album="

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ArtistAlbumViewController.h"
#import "Release.h"
#import "Artist.h"
#import "AppDelegate.h"
#import "MusicViewController.h"
#import "Singleton.h"

@interface AlbumViewController : UIViewController<NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property NSString *artistName;
@property NSString *albumName;
@property UIImage *albumImage;
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

@end
