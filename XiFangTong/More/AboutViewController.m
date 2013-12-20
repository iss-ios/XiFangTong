//
//  AboutViewController.m
//  XiFangTong
//
//  Created by issuser on 13-8-2.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
#pragma mark -
#pragma mark view
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
    imageRequest = [[GetImageListRequest alloc] init];
    [imageRequest setDelegate:self];
//    [imageRequest requestImageListWithCategory:AboutUsURL];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [imageRequest setDelegate:self];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [imageRequest setDelegate:nil];
    imageRequest = nil;
    aboutImageView = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark request
-(void)getImageListRequestSuccess:(NSString *)imagePath
{
    NSString *imgPath = [NSString stringWithFormat:@"%@%@",ImagePathURL,imagePath];
    [aboutImageView setImageWithURL:[NSURL URLWithString:imgPath] placeholderImage:[UIImage imageNamed:@"about_us_ima.png"]];
}
-(void)getImageListRequestFailed:(NSString *)message
{
    [[[[UIApplication sharedApplication] delegate] window] makeToast:@"数据加载失败" duration:1.0 position:@"center"];
}
@end
