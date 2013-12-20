//
//  BasedViewController.m
//  XiFangTong
//
//  Created by issuser on 13-8-2.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "BasedViewController.h"

@interface BasedViewController ()

@end

@implementation BasedViewController

@synthesize rightButton;
@synthesize navTitleLabel;

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
//    swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
//    [swipeGesture setDirection:(UISwipeGestureRecognizerDirectionRight)];
//    [[self view] addGestureRecognizer:swipeGesture];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [[[[UIApplication sharedApplication] delegate] window] hideToastActivity];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    swipeGesture = nil;
    
}

#pragma mark -
#pragma mark button click
-(void)onClickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)onClickRight:(id)sender
{
    //do nothing
}
#pragma mark -
#pragma mark gesture recognizer
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    
    if (recognizer.direction==UISwipeGestureRecognizerDirectionRight)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
