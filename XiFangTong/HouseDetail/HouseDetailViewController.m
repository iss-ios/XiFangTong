//
//  HouseDetailViewController.m
//  XiFangTong
//
//  Created by issuser on 13-8-12.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "HouseDetailViewController.h"
#import "HouseDetailCell.h"
#import "ActivityViewController.h"
#import "GroupBuyViewController.h"
#import "MortgageViewController.h"
#import "MapViewController.h"
#import "TextFormatView.h"

//#import "SideHouseViewController.h"

@interface HouseDetailViewController ()
{
    NSArray *cellTopTitles;
//    NSArray *cellBottomTitles;
}
@end

@implementation HouseDetailViewController

//@synthesize house;
@synthesize houseId;

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
  
    //加载控件
    [mortgageButton setBackgroundImage:[UIImage imageNamed:@"lpdy_title_bottom2_icon01_h"] forState:UIControlStateHighlighted];
    [phoneButton setBackgroundImage:[UIImage imageNamed:@"lpdy_title_bottom2_icon02_h"] forState:UIControlStateHighlighted];
    [mapButton setBackgroundImage:[UIImage imageNamed:@"lpdy_title_bottom2_icon03_h"] forState:UIControlStateHighlighted];
    
    cellTopTitles = [NSArray arrayWithObjects:@"主力在售",@"价格行情",@"优惠折扣",@"周边配套",@"基本信息", nil];
    
    if (IS_IPHONE_5) {
        footerView.frame = CGRectMake(0, screenHeight-44, 320, 44);
    }
    table.tableHeaderView = headerView;

    //检查楼盘是否已被收藏
    [self checkStored];
    
    //获取楼盘详细内容
    houseInfoRequest = [[HouseInfoRequest alloc] init];
    [houseInfoRequest setDelegate:self];
    if (houseId.length != 0) {

        [houseInfoRequest requestHouseInfoWithID:houseId];
        [[[[UIApplication sharedApplication] delegate] window] makeToastActivity];

    }
}
-(void)checkStored
{
    //查找数据库，检查该楼盘是否已被收藏
    NSArray *result = [[DBOperation Instance] selectFavoriteWithHouseID:houseId];
    if (result.count == 0) {
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"lpdy_title_right"] forState:UIControlStateNormal];
        stored = NO;
    }
    else{
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"lpdy_title_right_hover"] forState:UIControlStateNormal];
        stored = YES;
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [houseInfoRequest setDelegate:self];
}
//-(void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:YES];
//    [houseInfoRequest setDelegate:nil];
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [table setDelegate:nil];
    [table setDataSource:nil];
    table = nil;
    headerView = nil;
    footerView = nil;
    houseImageView = nil;
    activityButton = nil;
    groupBuyButton = nil;
    activityLabel = nil;
    groupBuyLabel = nil;
    mortgageButton = nil;
    phoneButton = nil;
    mapButton = nil;
    [houseInfoRequest setDelegate:nil];
    houseInfoRequest = nil;
    house = nil;
}
#pragma mark -
#pragma mark table view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (house != nil) {
        if (indexPath.row == 4) {
            CGFloat height = [TextFormatView countViewHeightWithTextArray:[NSArray arrayWithObjects:house.district,house.buildAddress,house.finishDate,house.manageCorporation,house.buildTypeCode,house.manageMoney,house.greenRate,house.cubage,house.traffic,nil]];
           return  height+37;
        }
        NSString *text = nil;
        switch (indexPath.row) {
            case 0:
                text = house.buildTypeShowIntro;
                break;
            case 1:
            {
                if (![house.referencePrice isEqualToString:@"0"]) {
                    text = house.referencePrice;
                }
                else{
                    text = @"价格未定";
                    
                }
            }
                break;
            case 2:
            {
                if ([house.intro isEqualToString:@""]) {
                    text = @"暂无优惠";
                    
                }
                else{
                    text = house.intro;
                }
            }
                break;
            case 3:
            {
                if ([house.support isEqualToString:@""]) {
                    text = @"暂无信息";
                }
                else{
                    text = house.support;
                }
                
            }
                break;
        }
        
        UIFont *font = [UIFont systemFontOfSize:17];
        CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(280.0f, 1000.0f) lineBreakMode:NSLineBreakByCharWrapping];
        if (text.length == 0) {
            size.height+=21;
        }
        return 37+size.height+10;
    }
    return 60;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"house detail cell";
    HouseDetailCell *cell = (HouseDetailCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"HouseDetailCell" owner:self options:nil];
        for (NSObject *o in objects) {
            if([o isKindOfClass:[HouseDetailCell class]]){
                cell = (HouseDetailCell *)o;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            }
        }
    }
    if (indexPath.row != 5) {
        cell.topLabel.text = [cellTopTitles objectAtIndex:indexPath.row];
    }
    
    cell.bottomLabel.tag = indexPath.row;
    [cell setType:kDefaultType];
    if (house != nil) {
        switch (indexPath.row) {
            case 0:
                if ([house.buildTypeShowIntro isEqualToString:@""]) {
                    [cell showBottomText:@"暂无信息"];
                }
                else{
                    
                    [cell showBottomText:house.buildTypeShowIntro];
                }
                break;
            case 1:
            {
//                if (![house.referencePrice isEqualToString:@"0"] && house.referencePrice.length != 0) {
                    [cell showBottomText:house.referencePrice];
//                }
//                else{
//                    [cell showBottomText:@"价格未定"];
//                }
            }
                break;
            case 2:
            {
                if ([house.intro isEqualToString:@""]) {
                    [cell showBottomText:@"暂无优惠"];
                }
                else{
                    [cell showBottomText:house.intro];
                }
            }
                break;
            case 3:
            {
                if ([house.support isEqualToString:@""]) {
                    [cell showBottomText:@"暂无信息"];
                }
                else{
                    [cell showBottomText:house.support];
                }
            }
                break;
            case 4:
            {
                cell.bottomLabel.text = nil;
                TextFormatView *textView = [[TextFormatView alloc] initWithPoint:CGPointMake(20, 37) textTitleArray:[NSArray arrayWithObjects:@"区      域:",@"地      址:",@"交付日期：",@"物管公司:",@"物业类型:",@"物管费用:",@"绿  化  率:",@"容  积  率:",@"周边交通:", nil ] contentArray:[NSArray arrayWithObjects:house.district,house.buildAddress,house.finishDate,house.manageCorporation,house.buildTypeCode,house.manageMoney,house.greenRate,house.cubage,house.traffic,nil]];
                [cell addSubview:textView];
                
            }
                break;
            default:
            {
                cell.topLabel.text = nil;
                cell.bottomLabel.text = nil;
                cell.topImageView.hidden = YES;
            
            }
                break;
        }
    }
    return cell;
}
#pragma mark -
#pragma mark button click
-(IBAction)onClickActivity:(id)sender
{
    //进入活动界面
    ActivityViewController *activity = [[ActivityViewController alloc] init];
    if (house.actIntro.length != 0) {
        activity.houseID = house.houseID;
    }
    [self.navigationController pushViewController:activity animated:YES];
}
-(IBAction)onClickGroupBuy:(id)sender
{
    //进入团购界面
    GroupBuyViewController *groupBuy = [[GroupBuyViewController alloc] init];
    if (house.tuan.length != 0) {
        groupBuy.houseID = house.houseID;
    }
    [self.navigationController pushViewController:groupBuy animated:YES];
}
-(IBAction)onClickMortgage:(id)sender
{
    //房贷界面快速入口
    MortgageViewController *mortgage = [[MortgageViewController alloc] init];
    [self.navigationController pushViewController:mortgage animated:YES];
}
-(IBAction)onClickPhone:(id)sender
{
    //打电话
    [[CommonData Instance] phoneCall];
}
-(IBAction)onClickMap:(id)sender
{
    //显示该楼盘周边楼盘
    MapViewController *map = [[MapViewController alloc] init];
    map.houseInfo = house;
    [self.navigationController pushViewController:map animated:YES];
}
-(void)onClickRight:(id)sender
{
    
    //收藏楼盘
    if (!stored) {
        if (house != nil) {
            BOOL success =  [[DBOperation Instance] insertMyFavoriteHouse:house];
            if (success) {
                stored = YES;
               
                [[[[UIApplication sharedApplication] delegate] window] makeToast:@"收藏成功" duration:1.0 position:@"center"];
            }
            else{
                stored = NO;
                [[[[UIApplication sharedApplication] delegate] window] makeToast:@"收藏失败" duration:1.0 position:@"center"];
            }
        }
    }
    else{
        BOOL success =  [[DBOperation Instance] deleteMyFavoriteHouse:house];
        if (success) {
            [[[[UIApplication sharedApplication] delegate] window] makeToast:@"已取消收藏" duration:1.0 position:@"center"];
            stored = NO;
        }
        else{
            [[[[UIApplication sharedApplication] delegate] window] makeToast:@"取消收藏失败" duration:1.0 position:@"center"];
            stored = YES;
        }
    }
    if (stored) {
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"lpdy_title_right_hover"] forState:UIControlStateNormal];
    }
    else{
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"lpdy_title_right"] forState:UIControlStateNormal];
    }
}
#pragma mark -
#pragma mark request delegate
-(void)showHeaderView
{
    //根据获取到的数据确定是否显示活动和团购按钮，调整布局
    self.navTitleLabel.text = house.shortName;
    NSString *imgPath = nil;
    if ([house.imagePath isEqualToString:@""]) {
        imgPath = [NSString stringWithFormat:@"%@%@",ImagePathURL,house.logoPath];
    }
    else{
        imgPath = [NSString stringWithFormat:@"%@%@",ImagePathURL,house.imagePath];
    }
    [houseImageView setImageWithURL:[NSURL URLWithString:imgPath] placeholderImage:[UIImage imageNamed:HouseDetailLogoDefault]];
    if ([house.tuan isEqualToString:@""] && [house.actIntro isEqualToString:@""]) {
        activityLabel.hidden = YES;
        activityButton.hidden = YES;
        groupBuyButton.hidden = YES;
        groupBuyLabel.hidden = YES;
        headerView.frame = CGRectMake(0, 0, 320, 183);
    }
    else if (![house.tuan isEqualToString:@""] && ![house.actIntro isEqualToString:@""]){
        activityLabel.hidden = NO;
        activityButton.hidden = NO;
        groupBuyButton.hidden = NO;
        groupBuyLabel.hidden = NO;
        headerView.frame = CGRectMake(0, 0, 320, 251);
        activityLabel.text = house.actIntro;
        groupBuyLabel.text = house.tuan;
    }
    else{
        if (![house.actIntro isEqualToString:@""]) {
            activityLabel.hidden = NO;
            activityButton.hidden = NO;
            groupBuyButton.hidden = YES;
            groupBuyLabel.hidden = YES;
            activityLabel.text = house.actIntro;
        }
        else{
            activityLabel.hidden = YES;
            activityButton.hidden = YES;
            groupBuyButton.hidden = NO;
            groupBuyLabel.hidden = NO;
            groupBuyLabel.text = house.tuan;
            groupBuyLabel.frame = CGRectMake(13, 188, 241, 21);
            groupBuyButton.frame = CGRectMake(5, 183, 310, 32);
        }
        headerView.frame = CGRectMake(0, 0, 320, 217);
    }
    houseImageView.frame = CGRectMake(5, 5, 310, 175);
//    footerView.frame = CGRectMake(10, screenHeight-50, 300, 40);
//    footerView.layer.cornerRadius = 5;
//    footerView.layer.masksToBounds = YES;
//    [self.view addSubview:footerView];
}

-(void)houseInfoRequestSuccess:(HouseInfo *)houseInfo
{
    //获取到楼盘信息
    house = houseInfo;
    [self showHeaderView];
    [table reloadData];
    table.tableHeaderView = headerView;
    
    //将该楼盘加到浏览历史数据库中
    NSArray *array = [[DBOperation Instance] selectHistoryWithHouseID:house.houseID];
    if (array.count == 0) {
        [[DBOperation Instance] insertMyHistoryHouse:house];
    }
}
-(void)houseInfoRequestFailed:(NSString *)message
{
    //获取楼盘信息失败
    [[[[UIApplication sharedApplication] delegate] window] makeToast:@"数据加载失败" duration:2.0 position:@"center"];
}

@end
