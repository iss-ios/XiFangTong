//
//  MyFavorotesViewController.m
//  XiFangTong
//
//  Created by issuser on 13-8-2.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "MyFavoritesViewController.h"
#import "MyFavoritesCell.h"
#import "DBOperation.h"
#import "HouseDetailViewController.h"
#import "HouseInfo.h"

@interface MyFavoritesViewController ()

@end

@implementation MyFavoritesViewController
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
    //add by yanbo 3013/08/16
    //[self newDataActive];
    }
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    favorireList = [[NSMutableArray alloc] initWithArray:[self getFavorite]];
    if (favorireList.count == 0) {
        emptyLabel.hidden = NO;
        table.hidden = YES;
    }
    else{
        emptyLabel.hidden = YES;
        table.hidden = NO;
    }

}
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
    //changed by yanbo start
    //return 10;
    return [favorireList count];
    //changed by yanbo end
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HouseInfo *house = [favorireList objectAtIndex:indexPath.row];
    if ([house.intro isEqualToString:@""]) {
        return 120;
    }
    return 155;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MyFavoritescell";
    MyFavoritesCell *cell = (MyFavoritesCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"MyFavoritesCell" owner:self options:nil];
        for (NSObject *o in objects) {
            if([o isKindOfClass:[MyFavoritesCell class]]){
                cell = (MyFavoritesCell *)o;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            }
        }
        //add by yanbo start 2013/08/19
        if ([favorireList count] != 0) {
            [cell setMessageByFavorite:[favorireList objectAtIndex:indexPath.row]];
        }
        //add by yanbo end
    }
    return cell;
    
}

//add by yanbo 2013/08/19
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HouseInfo *house = [favorireList objectAtIndex:indexPath.row];
    HouseDetailViewController *houseDetailView = [[HouseDetailViewController alloc] init];
    houseDetailView.houseId =house.houseID;
    [self.navigationController pushViewController:houseDetailView animated:YES];
}

//add by yanbo 2013/08/16
-(NSArray *)getFavorite{
    return [[DBOperation Instance] selectFavoriteWithHouseID:@""];
}



@end
