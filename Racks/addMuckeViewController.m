//
//  addMuckeViewController.m
//  Racks
//
//  Created by Mercedes Bünz on 28.06.13.
//  Copyright (c) 2013 Malte Bünz. All rights reserved.
//

#import "addMuckeViewController.h"

@interface addMuckeViewController ()

@end



@implementation addMuckeViewController

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
    [myScrollView setScrollEnabled:YES];
    viewCenter = myScrollView.contentOffset;
    [myScrollView setContentSize:CGSizeMake(320.0, self.view.frame.size.height)];
    NSLog(@"viewDidLoad: contentOffset y: %f",[myScrollView contentOffset].y);
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TextField

- (void)textFieldDidBeginEditing:(UITextField*)textField;
{
    //    NSLog(@"edit start on field: %i", textField.tag);
    if (!_saveButton) {
        _saveButton.enabled = YES;
    }
//    NSLog(@"Scrollview Width: %f / ScrollView Height: %f", myScrollView.frame.size.width, myScrollView.frame.size.height);
    offset = textField.frame.origin.y;
    offset = offset + 20.0;
    scrollPoint = CGPointMake(0.0, offset);
    [myScrollView setContentOffset:scrollPoint animated:NO];
    //    currentActiveField = _textField0;
     
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{

}

- (void)editingDidEnd:(UITextField *)textField {
    NSLog(@"edit ended)/n");
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    NSLog(@"textFieldShouldClear:");
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //    viewCenter = CGPointMake(scrollView.frame.size.width/2.0, scrollView.frame.size.height/2.0);
    //    viewCenter = CGPointMake(0.0, 0.0);
	NSLog(@"textFieldShouldReturn: %ld", (long)textField.tag);
    if (textField == artistText) {
		[textField resignFirstResponder];
		[albumText becomeFirstResponder];
	} else if (textField == albumText) {
		[textField resignFirstResponder];
		[labelText becomeFirstResponder];
	} else if (textField == labelText) {
		[textField resignFirstResponder];
        [myScrollView setContentOffset:viewCenter animated:YES];
	}
	return YES;
}

#pragma mark ScrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [myScrollView resignFirstResponder];
    [myScrollView setContentOffset:viewCenter animated:YES];
}

- (void) scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [myScrollView resignFirstResponder];
    [myScrollView setContentOffset:viewCenter animated:YES];

}


@end
