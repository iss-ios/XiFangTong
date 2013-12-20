//
//  LikeViewController.m
//  XiFangTong
//
//  Created by issuser on 13-7-30.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "GuessLikeViewController.h"
#import "GuessLikeCell.h"
#import "HouseDetailViewController.h"

@interface GuessLikeViewController ()

@end

@implementation GuessLikeViewController

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
    houseList = [[NSMutableArray alloc] init];
    request = [[GuessLikeRequest alloc] init];
    [request setDelegate:self];
    [request requestHouseListWithParameter:[self generateParaDictionary]];
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
    [table setDelegate:nil];
    [table setDataSource:nil];
    table = nil;
}
#pragma mark -
#pragma mark table view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [houseList count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"like cell";
    GuessLikeCell *cell = (GuessLikeCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"GuessLikeCell" owner:self options:nil];
        for (NSObject *o in objects) {
            if([o isKindOfClass:[GuessLikeCell class]]){
                cell = (GuessLikeCell *)o;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            }
        }
    }

    if (houseList.count != 0) {
        HouseInfo *house = [houseList objectAtIndex:indexPath.row];
        [cell showHouseInfo:house];
    }
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HouseInfo *house = [houseList objectAtIndex:indexPath.row];
    HouseDetailViewController *houseDetail = [[HouseDetailViewController alloc] init];
    houseDetail.houseId = house.houseID;
    [self.navigationController pushViewController:houseDetail animated:YES];
}
#pragma mark -
#pragma mark request
-(NSDictionary *)generateParaDictionary
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *price = [defaults objectForKey:GuessAvgPriceKey];
    NSString *district = [defaults objectForKey:GuessDistrictKey];
    NSString *feature = [defaults objectForKey:GuessTagKey];
    NSNumber *pNum = nil;
    NSArray *houses = [[DBOperation Instance] selectHistoryWithHouseID:@""];
    if (houses.count != 0) {
        HouseInfo *houseinfo = [houses objectAtIndex:0];
        price = houseinfo.avgPrice;
        if (price.length == 0) {
             pNum =[NSNumber numberWithFloat:0.0];
        }
        else{
            pNum =[NSNumber numberWithFloat:[houseinfo.avgPrice floatValue]];
        }
        district = houseinfo.districtID;
        feature = houseinfo.tag;
    
    }
    else{
        if ([price isEqualToString:@""]) {
            pNum = [NSNumber numberWithFloat:0.0];
        }
        else{
            pNum = [NSNumber numberWithFloat:[Tool getAvgPriceByString:price]];
        }
    }    
    NSArray *values = [NSArray arrayWithObjects:[NSNumber numberWithInt:10],district,feature,pNum, nil];
    NSArray *keys = [NSArray arrayWithObjects:@"top",@"district",@"tag",@"avgPrice", nil];
    if (values.count == keys.count) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjects:values forKeys:keys];
        return dic;
    }
    return nil;
}

-(void)guessLikeRequestSuccess:(NSArray *)dataSources
{
    if (houseList.count != 0) {
        [houseList removeAllObjects];
    }
    houseList = [NSMutableArray arrayWithArray:dataSources];
    if (houseList.count == 0) {
        emptyLabel.hidden = NO;
        table.hidden = YES;
    }
    else{
        emptyLabel.hidden = YES;
        table.hidden = NO;
        [table reloadData];
    }
}
-(void)guessLikeRequestFailed:(NSString *)message
{
    [[[[UIApplication sharedApplication] delegate] window] makeToast:@"数据加载失败" duration:2.0 position:@"center"];

}


@end
