//
//  GuideViewController.m
//  XiFangTong
//
//  Created by issuser on 13-8-5.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController
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
    [imageRequest requestImageListWithCategory:GuideURL];
    [[[[UIApplication sharedApplication] delegate] window] makeToastActivity];

    guideWebView.scalesPageToFit = YES;
    guideWebView.scrollView.bounces = NO;
    guideWebView.scrollView.alwaysBounceHorizontal = NO;
    guideWebView.frame = CGRectMake(10, 54, 300, screenHeight-54);
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [imageRequest setDelegate:self];

}
//-(void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:YES];
//    [imageRequest setDelegate:nil];
//    imageRequest = nil;
//    guideWebView = nil;
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark request
-(void)getImageListRequestSuccess:(ImageObject *)imageObject
{
//    guideWebView.scrollView.contentSize = CGSizeMake(guideWebView.frame.size.width, <#CGFloat height#>)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *refreshTime = [defaults valueForKey:GuideImageRefreshTime];
    NSString *imageDtime = imageObject.dTime;
    
    if (refreshTime == nil || refreshTime.length == 0 || [Tool compareDateA:imageDtime isLaterThanDateB:refreshTime]) {
        
        NSString *imgPath = [NSString stringWithFormat:@"%@%@",ImagePathURL,imageObject.imageUrl];
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:imgPath]];
        [guideWebView loadRequest:request];
        BOOL result;
        if ([imageObject.imageUrl hasSuffix:@".png"]) {
            result = [Tool saveImageToLocalInUrl:imageObject.imageUrl withName:GuideLocalImageName ofType:@"png"];
            [defaults setValue:[NSString stringWithFormat:@"%@.png",GuideLocalImageName] forKey:GuideLocalImageName];
        }
        else{
            result = [Tool saveImageToLocalInUrl:imageObject.imageUrl withName:GuideLocalImageName ofType:@"jpg"];
            [defaults setValue:[NSString stringWithFormat:@"%@.jpg",GuideLocalImageName] forKey:GuideLocalImageName];
        }
        if (result) {
            refreshTime = imageDtime;
            [defaults setValue:refreshTime forKey:GuideImageRefreshTime];
            [defaults synchronize];
        }
    }
    else{
        [self showDownloadImage];
    }


}
-(void)getImageListRequestFailed:(NSString *)message
{
    [[[[UIApplication sharedApplication] delegate] window] makeToast:@"数据加载失败" duration:2.0 position:@"center"];
    UIImage *image = [Tool loadLocalImage:GuideLocalImageName];
    if (image == nil) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"guide_image" ofType:@"png"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        
        [guideWebView loadData:data MIMEType:@"image/png" textEncodingName:nil baseURL:nil];
    }
    else{
        [self showDownloadImage];
    }
    
}
-(void)showDownloadImage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *imageName = [defaults objectForKey:GuideLocalImageName];
    NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *imagePath = [documentsDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", imageName]];
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    if ([imageName hasSuffix:@".png"]) {
        [guideWebView loadData:data MIMEType:@"image/png" textEncodingName:nil baseURL:nil];
    }
    else{
        [guideWebView loadData:data MIMEType:@"image/jpg" textEncodingName:nil baseURL:nil];
    }
    
}
#pragma mark -
#pragma mark web view delegate
-(void)webViewDidFinishLoad:(UIWebView *)webView
{

    
    [[[[UIApplication sharedApplication] delegate] window] hideToastActivity];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [[[[UIApplication sharedApplication] delegate] window] makeToast:@"图片加载失败" duration:2.0 position:@"center"];
}
#pragma mark -
#pragma mark button
-(void)onClickRight:(id)sender
{
    [[CommonData Instance] phoneCall];
}
@end
