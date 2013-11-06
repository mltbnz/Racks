//
//  AlbumViewController.m
//  Racks
//
//  Created by Mercedes Bünz on 17.10.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//
//@class AlbumViewController;
//
//@protocol AlbumViewControllerDelegate <NSObject>
//
//- (void)getArrayFromMusicVC:(AlbumViewController *)albumViewController;
//
//@end


#import "AlbumViewController.h"

@interface AlbumViewController ()

@end

@implementation AlbumViewController
{
    NSMutableData* jsonData;
    NSMutableDictionary* jsonDict;
    NSString *albumSummary;
    NSString *albumRelease;
    NSString *albumLabel;
}

@synthesize fetchedResultsController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (id)initWithAlbumname:(NSString*)passAlbumName AndArtistName:(NSString*)passArtistName AndReleaseDate:(NSString*)passReleaseDate AndLabelName:(NSString*)passLabelName AndImageAdress:(NSString*)passImageUrl
{
    if (self = [super init])
    {
        passAlbumName = albumName;
        passArtistName = artistName;
        passReleaseDate = releaseDate;
        passLabelName = labelName;
        passImageUrl = imageUrl;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // NavBar add Button Function
    UIImage *buttonImg = [UIImage imageNamed:@"button.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, buttonImg.size.width, buttonImg.size.height);
    [button setTitle:@"Cancel" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:buttonImg forState:UIControlStateNormal];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    //    self.navigationItem.leftBarButtonItem = backButton;
    self.navBar.topItem.leftBarButtonItem = customBarItem;
    self.navBar.topItem.title = [NSString stringWithFormat:@"%@", self.albumName];
    
    // check if image was passed by View
    if (self.albumImage != nil)
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
    
    // Set TextField properties 
    if (self.artistName)
    {
//        NSLog(@"%@", self.artistName);
        self.artistTextField.text = self.artistName;
    }
    else
    {
        self.artistTextField.text = @"Malte";
    }
    
    if (self.albumName)
    {
//        NSLog(@"%@", self.albumName);
        self.albumTextField.text = self.albumName;
    }
    else
    {
        self.albumTextField.text = @"Malte";
    }
    
    
    //
    // Decide if it is a scan or a search via BOOL isScan
    //
    if (!self.isScan)
    {
        [self loadInfoFromSearch];
    }
    else
    {
        [self loadInfoFromScan];
    }
    
    // CoreData
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //    NSLog(@"didReceiveResponse");
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    //    NSLog(@"Verbindung steht");
    jsonData = [[NSMutableData alloc] init];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to the instance variable you declared
    // NSLog(@"Received %d bytes of data",[data length]);
    [jsonData appendData:data];
    // NSLog(@"Received %d bytes of totalData",[jsonData length]);
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse
{
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // NSLog(@"connectionDidFinishLoading");
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSError* error;
    jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    if ([jsonDict count] == 0)
    {
        NSLog(@"Error parsing JSON: %@", error);
    }
    else
    {
        self.releaseDate = [[jsonDict objectForKey:@"album"] valueForKey:@"releasedate"];
        if (self.releaseDate.length == 0 || self.releaseDate.length < 7)
        {
            self.releaseLabel.text = @"No date available";
        }
        else
        {
            // NSLog(@"Content: %@ / Length: %i", self.releaseDate, [self.releaseDate length]);
            self.releaseDate = [self.releaseDate substringToIndex:[self.releaseDate length] -7];
            self.releaseLabel.text = self.releaseDate;
        }
        
        albumSummary = [[[jsonDict objectForKey:@"album"] objectForKey:@"wiki"] valueForKey:@"content"];
        if (albumSummary.length == 0)
        {
            self.desTextField.text = @"No description available";
        }
        else
        {
            self.desTextField.text = albumSummary;
        }
    }
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // The request has failed for some reason!
    // Check the error var
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The Download could not be completed - Please make sure you are either connected to 3G or Wi-Fi." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    NSLog(@"ERROR: %@", error);
    [errorView show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

# pragma  mark - Functions

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"backToArtistAlbumVC"])
    {
        
    }
    else if ([[segue identifier] isEqualToString:@"backToMusic"])
    {
        
    }
}

- (IBAction)backButtonAction:(id)sender
{
    // NSLog(@"TEST2");
    [self dismissViewControllerAnimated:YES completion:nil];
    //    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    //    [self performSegueWithIdentifier:@"backToArtistAlbumVC" sender:self];
}

#pragma mark - CoreData Functions

- (IBAction)addRecord:(id)sender
{
    // NSLog(@"saveArtistInformation");
    // search to see if entity already exists
    NSError *error = nil;
    //
    // Adds the content of this view to the CoreData DB
    Artist *artist = [NSEntityDescription insertNewObjectForEntityForName:@"Artist" inManagedObjectContext:self.managedObjectContext];
    artist.name = self.artistName;
    //
    Release *release = [NSEntityDescription insertNewObjectForEntityForName:@"Release" inManagedObjectContext:self.managedObjectContext];
    release.name = self.albumName;
    release.picture = [self resizeImageAndTransformToNsdata:self.imageView.image];
    release.releaseDate = self.releaseDate;
    release.label = self.labelName;
    release.text = albumSummary;
    //
    artist.released = [NSSet setWithObject:release];
    //
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    //
    self.albumTextField.text = @"";
    self.artistTextField.text = @"";
    self.desTextField.text = @"";
    self.releaseLabel.text = @"";
    //
    //    [self.view.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
    [self backToMusicVC];
}

- (void)backToMusicVC
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^(void)
     {
         // Block
         UIAlertView *sucessView = [[UIAlertView alloc] initWithTitle:@"Success" message:[NSString stringWithFormat:@"%@ - %@ added to your library", self.artistName, self.albumName] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
         //         NSLog(@"ERROR: %@", error);
         [sucessView show];
         //         [self.navController pushViewController:[self.navController.viewControllers objectAtIndex:1] animated:YES];
         //         [self.navController popToViewController:[self.navController.viewControllers objectAtIndex:0] animated:YES];
     }];
}

- (void)loadInfoFromSearch
{
    NSLog(@"Scan from Search : %@", self.imageURL);
    // Load albuminfo
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:self.imageURL] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
    NSString* url = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",LASTFMALBUMINFOURL,LASTFMKEY,ARTIST,self.artistName,ALBUM,self.albumName,RETURNTYPE];
    NSString *urlConverted = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //    NSLog(@"%@",urlConverted);
    NSURLRequest *request   = [NSURLRequest requestWithURL:[NSURL URLWithString:urlConverted]];
    NSURLConnection *conn   = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)loadInfoFromScan
{
    NSLog(@"Scan from Scan : %@", self.imageURL);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    // Load Image from URL
    [self.imageView setImageWithURL:[NSURL URLWithString:self.imageURL] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
}

- (NSData*) resizeImageAndTransformToNsdata:(UIImage*)image
{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = 320.0/480.0;
    
    if(imgRatio!=maxRatio)
    {
        if(imgRatio < maxRatio)
        {
            imgRatio = 480.0 / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = 480.0;
        }
        else
        {
            imgRatio = 320.0 / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = 320.0;
        }
    }
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImagePNGRepresentation(img);
    return  imageData;
//    CGSize newSize = CGSizeMake(60, 60);
//    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
//    NSData *imageData = UIImagePNGRepresentation(image);
//    return imageData;
}


@end
