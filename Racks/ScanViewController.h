//
//  ScanViewController.h
//  Racks
//
//  Created by Mercedes Bünz on 23.08.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface ScanViewController : UIViewController<ZBarReaderDelegate>
{
    IBOutlet UIButton *scanButton;
}

@property (nonatomic, retain) IBOutlet UIButton *scanButton;

-(IBAction) scanButtonPress:sender;

@end
