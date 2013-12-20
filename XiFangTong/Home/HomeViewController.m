//
//  HomeViewController.m
//  XiFangTong
//
//  Created by issuser on 13-7-26.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "HomeViewController.h"
#import "MenuViewGenerator.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

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

    topImageView.layer.cornerRadius = 5;
    topImageView.layer.masksToBounds = YES;
    
    //根据屏幕尺寸调整界面上控件位置和尺寸
    CGFloat downHeight = 0.0;
    if (IS_IPHONE_5) {
        topImageView.frame = CGRectMake(10, 0, 300, 65);
        downHeight = 50.0;
    }
    else{
        downHeight = 30.0;
    }

    //加载主界面
    MenuViewGenerator *generator = [[MenuViewGenerator alloc] initWithFrame:CGRectMake(0, topImageView.frame.size.height+5, 320, screenHeight-downHeight-topImageView.frame.size.height-5) titles:[NSArray arrayWithObjects:@"新房",@"地图找房",@"猜你喜欢",@"活动",@"指南",@"团购",@"房贷",@"税费",@"更多", nil] activeController:self];
    [self.view addSubview:generator];
    
    pageImageView.frame = CGRectMake(85, screenHeight-downHeight+5, 150, 15);
   
   
    [[CommonData Instance] downloadHouseInfos];
   
    //获取界面顶部图片
    imageRequest = [[GetImageListRequest alloc] init];
    [imageRequest setDelegate:self];
    [imageRequest requestImageListWithCategory:HomeADURL];    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    [imageRequest setDelegate:self];
}
//-(void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:YES];
//    [imageRequest setDelegate:nil];
//}
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    pageImageView = nil;
    topImageView = nil;
    [imageRequest setDelegate:nil];
    imageRequest = nil;
    
    pageImageView = nil;
    topImageView = nil;
}

#pragma mark -
#pragma mark 
-(void)getImageListRequestSuccess:(ImageObject *)imageObject
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *refreshTime = [defaults valueForKey:HomeImageRefreshTime];
    NSString *imageDtime = imageObject.dTime;
    
    if (refreshTime == nil || refreshTime.length == 0 || [Tool compareDateA:imageDtime isLaterThanDateB:refreshTime]) {
        
        NSString *imgPath = [NSString stringWithFormat:@"%@%@",ImagePathURL,imageObject.imageUrl];
        [topImageView setImageWithURL:[NSURL URLWithString:imgPath] placeholderImage:[UIImage imageNamed:@"home_top_default.png"]];
        BOOL result;
        if ([imageObject.imageUrl hasSuffix:@".png"]) {
            result = [Tool saveImageToLocalInUrl:imageObject.imageUrl withName:HomeLocalImageName ofType:@"png"];
            [defaults setValue:[NSString stringWithFormat:@"%@.png",HomeLocalImageName] forKey:HomeLocalImageName];
        }
        else{
            result = [Tool saveImageToLocalInUrl:imageObject.imageUrl withName:HomeLocalImageName ofType:@"jpg"];
            [defaults setValue:[NSString stringWithFormat:@"%@.jpg",HomeLocalImageName] forKey:HomeLocalImageName];
        }
        if (result) {
            refreshTime = imageDtime;
            [defaults setValue:refreshTime forKey:HomeImageRefreshTime];
            [defaults synchronize];
        }
    }
    else{
        UIImage *image = [Tool loadLocalImage:[defaults objectForKey:HomeLocalImageName]];
        topImageView.image = image;
    }
    
}
-(void)getImageListRequestFailed:(NSString *)message
{
    //图片获取失败，提示
    [[[[UIApplication sharedApplication] delegate] window] makeToast:@"数据加载失败" duration:1.0 position:@"bottom"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    UIImage *image = [Tool loadLocalImage:[defaults objectForKey:HomeLocalImageName]];
    if (image == nil) {
        topImageView.image = [UIImage imageNamed:@"home_top_default.png"];
    }
    else{
        topImageView.image = image;
    }
}
@end
