//
//  GroupBuyViewController.m
//  XiFangTong
//
//  Created by issuser on 13-8-5.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "GroupBuyViewController.h"
#import "GroupBuyView.h"
#import "GroupBuyInfo.h"
#import "GroupBuyInfoViewController.h"
@interface GroupBuyViewController ()

@end

@implementation GroupBuyViewController

@synthesize houseID;

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
    CGFloat originx = 0.0;
    if (!IS_IPHONE_5) {
        originx = 76;
    }
    mainScrollView.frame = CGRectMake(0, originx, 320, 380);
    [self.view addSubview:mainScrollView];
    groupBuyList = [[NSMutableArray alloc] init];
    request = [[GroupBuyRequest alloc] init];
    [request setDelegate:self];
    [request requestGroupBuyListWithDate:@""];
    [[[[UIApplication sharedApplication] delegate] window] makeToastActivity];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [request setDelegate:self];
}
//-(void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:YES];
//    [request setDelegate:nil];
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    mainPageControl = nil;
    [mainScrollView setDelegate:nil];
    mainScrollView = nil;
    pageLabel = nil;
}
#pragma mark -
#pragma mark scroll view

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //获取当前页码
    int index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    
    //设置当前页码
    mainPageControl.currentPage = index;
    pageLabel.text = [NSString stringWithFormat:@"%i/%i",mainPageControl.currentPage+1,mainPageControl.numberOfPages];

}
#pragma mark -
#pragma mark page control
-(IBAction)pageChange:(UIPageControl *)sender{
    CGFloat offset= sender.currentPage*320;
    [mainScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
    pageLabel.text = [NSString stringWithFormat:@"%i/%i",mainPageControl.currentPage+1,mainPageControl.numberOfPages];
}
#pragma mark -
#pragma mark request
-(void)groupBuyRequestSuccess:(NSArray *)dataSources
{
    if (groupBuyList.count != 0) {
        [groupBuyList removeAllObjects];
    }
    groupBuyList = [NSMutableArray arrayWithArray:dataSources];
    if (groupBuyList.count == 0) {
        emptyLabel.hidden = NO;
        pageLabel.hidden = YES;
    }
    else{
        emptyLabel.hidden = YES;
        pageLabel.hidden = NO;
    }
    CGFloat downHeight = 0.0;
    if (IS_IPHONE_5) {
        downHeight = 75.0;
    }
    for (int i = 0; i < groupBuyList.count; i++) {
       
        GroupBuyInfo *info = [groupBuyList objectAtIndex:i];
        int w = (i+1)*2-1;
        GroupBuyView *groupView = [[GroupBuyView alloc] initWithFrame:CGRectMake(15*w+i*290, 0, 290, 380+downHeight) contentImage:nil andPhone:nil];
        groupView.tag = i;
        [mainScrollView addSubview:groupView];

        groupView.groupBuy = info;

        [groupView showGroupBuy:info];
        
        [mainScrollView setContentSize:CGSizeMake(320*(i+1), 380+downHeight)];
       
        mainPageControl.numberOfPages = i+1;
        if (houseID.length != 0 &&  [houseID isEqualToString:info.houseID]) {
            mainPageControl.currentPage = i;
            break;
            
        }
        else{
            mainPageControl.currentPage = 0;
        }
        
    }
    mainScrollView.frame = CGRectMake(0, mainScrollView.frame.origin.y, 320, 380+downHeight);
    
    pageLabel.text = [NSString stringWithFormat:@"%i/%i",mainPageControl.currentPage+1,mainPageControl.numberOfPages];
    [self pageChange:mainPageControl];
}
-(void)groupBuyRequestFailed:(NSString *)message
{
    [[[[UIApplication sharedApplication] delegate] window] makeToast:@"数据加载失败" duration:2.0 position:@"center"];
}
#pragma mark -
#pragma mark button
-(void)onClickRight:(id)sender
{
    GroupBuyInfoViewController *info = [[GroupBuyInfoViewController alloc] init];
    [self.navigationController pushViewController:info animated:YES];
}
@end
