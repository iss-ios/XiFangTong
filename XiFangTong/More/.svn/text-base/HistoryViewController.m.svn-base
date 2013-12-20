//
//  HistoryViewController.m
//  XiFangTong
//
//  Created by issuser on 13-8-5.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryCell.h"
#import "DBOperation.h"
#import "HouseDetailViewController.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController
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
    // Do any additional setup after loading the view from its nib.
    //add by yanbo 2013/08/15
//    [self newDataHistory];
    historyList = [[NSMutableArray alloc] initWithArray:[self getHistorys]];
    if (historyList.count == 0) {
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
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark table view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //changed by yanbo 2013/08/15 start
    //return 10;
    return [historyList count];
    //changed by yanbo end
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"HistoryCell";
    HistoryCell *cell = (HistoryCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"HistoryCell" owner:self options:nil];
        for (NSObject *o in objects) {
            if([o isKindOfClass:[HistoryCell class]]){
                cell = (HistoryCell *)o;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            }
        }
        HouseInfo *house = [historyList objectAtIndex:indexPath.row];
        [cell setMessageWithHistory:house];
    }
    return cell;
    
}

-(NSArray *)getHistorys{
    return [[DBOperation Instance] selectHistoryWithHouseID:@""];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HouseInfo *house = [historyList objectAtIndex:indexPath.row];
    HouseDetailViewController *houseDetailView = [[HouseDetailViewController alloc] init];
    houseDetailView.houseId = house.houseID;
    [self.navigationController pushViewController:houseDetailView animated:YES];
}

@end
