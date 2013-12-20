//
//  RecommendViewController.m
//  XiFangTong
//
//  Created by issuser on 13-8-8.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "RecommendViewController.h"
#import "QREncoder.h"
#define PATHURL @"http://www.wxhouse.com/app/"

@interface RecommendViewController ()

@end

@implementation RecommendViewController

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
    // Do any additional setup after loading the view from its nib.
    //add by yanbo 2013/08/20
    recommendImage.image = [self getQREncoderByString:PATHURL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImage *)getQREncoderByString:(NSString *)value{
    return [QREncoder encode:value];
}
@end
