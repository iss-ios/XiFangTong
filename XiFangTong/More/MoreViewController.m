//
//  MoreViewController.m
//  XiFangTong
//
//  Created by issuser on 13-8-2.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "MoreViewController.h"
#import "AboutViewController.h"
#import "MyFavoritesViewController.h"
#import "HistoryViewController.h"
#import "RecommendViewController.h"
#import "MyAppointmentsViewController.h"
#import "SDImageCache.h"

@interface MoreViewController ()
{
    NSArray *cellTitles;
}
@end

@implementation MoreViewController
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
    cellTitles = [NSArray arrayWithObjects:@"我的预约",@"我的收藏",@"最近浏览",@"推荐安装",@"关于我们",@"清除缓存", nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [table reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [table setDelegate:nil];
    [table setDataSource:nil];
    table = nil;
    cellTitles = nil;
}
#pragma mark -
#pragma mark table view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cellTitles.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"more cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more_middle_selectedbg"]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row == 0) {

        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more_up_selectedbg"]];
    }
    else if (indexPath.row == cellTitles.count-1){
        
         cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more_down_selectedbg"]];
    }
    cell.textLabel.text = [cellTitles objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:17.0];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            MyAppointmentsViewController *myAppointments = [[MyAppointmentsViewController alloc] init];
            [self.navigationController pushViewController:myAppointments animated:YES];
        }
            break;
        case 1:
        {
            MyFavoritesViewController *myFavorites = [[MyFavoritesViewController alloc] init];
            [self.navigationController pushViewController:myFavorites animated:YES];
        }
            break;
        case 2:
        {
            HistoryViewController *history = [[HistoryViewController alloc] init];
            [self.navigationController pushViewController:history animated:YES];
        }
            break;
        case 3:
        {
            RecommendViewController *recommend = [[RecommendViewController alloc] init];
            [self.navigationController pushViewController:recommend animated:YES];
        }
            break;
        case 4:
        {
            AboutViewController *about = [[AboutViewController alloc] init];
            [self.navigationController pushViewController:about animated:YES];
        }
            break;
        case 5:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您确定要清理系统缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
            break;
        default:
            break;
    }
}
#pragma mark -
#pragma mark button click
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex) {
        [[SDImageCache sharedImageCache] clearDisk];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:@"" forKey:GuessDistrictKey];
        [defaults setValue:@"" forKey:GuessAvgPriceKey];
        [defaults setValue:@"" forKey:GuessTagKey];
        [defaults synchronize];
        
        if ([self deleteTempData] == YES) {
            
            [[[[UIApplication sharedApplication] delegate] window] makeToast:@"已经成功清除本地缓存数据！" duration:1.0 position:@"center"];
        }else{
            [[[[UIApplication sharedApplication] delegate] window] makeToast:@"清理失败" duration:1.0 position:@"center"];
        }        
    }
   [table reloadData];
}
//add by yanbo 2013/08/20
-(BOOL)deleteTempData{
    BOOL result = TRUE;
    //删除浏览记录
    if ([[DBOperation Instance] deleteHistoryWithRequire:nil] == FALSE) {
        result = FALSE;
    }
    //删除猜你喜欢数据
    
    return result;
}
@end
