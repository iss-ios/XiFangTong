//
//  MyAppointmentsViewController.m
//  XiFangTong
//
//  Created by issuser on 13-8-8.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "MyAppointmentsViewController.h"
#import "MyAppointmentsCell.h"
#import "DBOperation.h"

@interface MyAppointmentsViewController ()

@end

@implementation MyAppointmentsViewController
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
    [self showSegmentControl];
//    table.tableHeaderView = headerView;
    //add by yanbo 2013/08/13
    //[self newDataActive];
    //[self newDataGroup];
    activeList = [[NSMutableArray alloc] initWithArray:[self getActives]];
    tableType = kActiveType;
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
    return activeList.count + 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //changed by yanbo start 2013/08/13
    // if (indexPath.row == 3) {
    if (indexPath.row == 0) {
        if (activeList.count == 0) {
            return 50;
        }
        return 100;
    }
    else if (indexPath.row == [activeList count]+1) {
        //changed by yanbo end
        return 44;
    }
    else{
        NSString *string = nil;
        if (tableType  == kActiveType) {
            ActivityInfo *activity = [activeList objectAtIndex:indexPath.row-1];
            string = activity.daoyu;
        }
        else{
            GroupBuyInfo *groupBuy = [activeList objectAtIndex:indexPath.row-1];
            string = groupBuy.houseAgio;
        }
        UIFont *font = [UIFont systemFontOfSize:16];
        CGSize size = [string sizeWithFont:font constrainedToSize:CGSizeMake(178.0f, 1000.0f) lineBreakMode:NSLineBreakByCharWrapping];
        return size.height+20+40+35+20;
    }
    
//    return 96;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MyAppointmentsCell";
    MyAppointmentsCell *cell = (MyAppointmentsCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"MyAppointmentsCell" owner:self options:nil];
        for (NSObject *o in objects) {
            if([o isKindOfClass:[MyAppointmentsCell class]]){
                cell = (MyAppointmentsCell *)o;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            }
        }
    }
    if (indexPath.row == 0) {
        [cell showEmptyCell];
        if (activeList.count == 0) {
            headerImageView.hidden = YES;
            headerLabel.hidden = YES;
            headerView.frame = CGRectMake(0, 10, 320, 52);
        }
        else{
            headerImageView.hidden = NO;
            headerLabel.hidden = NO;
            headerView.frame = CGRectMake(0.0, 10,320.0, 102.0);
        }
        
        [tableView addSubview:headerView];
    }
    else if (indexPath.row < [activeList count]+1) {
        if (topSegment.selectedIndex == 0) {
            ActivityInfo *activity = [activeList objectAtIndex:indexPath.row-1];
            [cell showActivity:activity];
        }
        else{
            GroupBuyInfo *group = [activeList objectAtIndex:indexPath.row-1];
            [cell showGroupBuy:group];
        }
    }
    else{
        if (activeList.count == 0) {
            if (topSegment.selectedIndex == 0) {
                [cell showEmptyInfo:@"抱歉，您暂时未参加任何活动"];
            }
            else{
                [cell showEmptyInfo:@"抱歉，您暂时未参加任何团购"];
            }
        }
        else{
            [cell showEmptyCell];
        }
    }

    return cell;

}
#pragma mark -
#pragma mark segment
-(void)showSegmentControl
{
    topSegment = [[AKSegmentedControl alloc] initWithFrame:CGRectMake(8.0, 0, 304.0, 60.0)];
    [topSegment setDelegate:self];
    [topSegment setContentEdgeInsets:UIEdgeInsetsMake(2.0, 2.0, 3.0, 2.0)];
    [topSegment setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin];
    
    [topSegment setSeparatorImage:[UIImage imageNamed:@"segmented-separator.png"]];
    
    NSMutableArray *buttonArrays = [[NSMutableArray alloc] init];
    for (int i = 0; i<2; i++) {
        UIButton *button = [[UIButton alloc] init];
        if (i == 0) {
            [button setTitle:@"活动" forState:UIControlStateNormal];
        }
        else {
            [button setTitle:@"团购" forState:UIControlStateNormal];
        }
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]];
        
        UIImage *buttonSocialImageNormal = [UIImage imageNamed:[NSString stringWithFormat:@"appoint_tab_%i_notselected2.png",i]];
        UIImage *buttonBackgroundImagePressed = [UIImage imageNamed:[NSString stringWithFormat:@"appoint_tab_%i_selected2.png",i]];
        [button setBackgroundImage:buttonBackgroundImagePressed forState:UIControlStateHighlighted];
        [button setBackgroundImage:buttonBackgroundImagePressed forState:UIControlStateSelected];
        [button setBackgroundImage:buttonBackgroundImagePressed forState:(UIControlStateHighlighted|UIControlStateSelected)];
        [button setBackgroundImage:buttonSocialImageNormal forState:UIControlStateNormal];
        [buttonArrays addObject:button];
    }
    
    [topSegment setButtonsArray:buttonArrays];
    [headerView addSubview:topSegment];
    
}
-(void)segmentedViewController:(AKSegmentedControl *)segmentedControl touchedAtIndex:(NSUInteger)index
{
    switch (segmentedControl.selectedIndex) {
        case 0:
        {
            //add by yanbo 2013/08/13
            [activeList removeAllObjects];
            [activeList addObjectsFromArray:[self getActives]];
            tableType = kActiveType;
        }
            break;
        case 1:
        {
            //add by yanbo 2013/08/13
            [activeList removeAllObjects];
            [activeList addObjectsFromArray:[self getGroups]];
            tableType = kGroupBuyType;
        }
            break;
        
        default:
            break;
    }
    [table reloadData];
}

#pragma mark 活动
-(NSArray *)getActives{
    return [[DBOperation Instance] selectActiveWithActiveID:@"" compareDate:NO];
}

#pragma mark 团购
-(NSArray *)getGroups{
    return [[DBOperation Instance] selectGroupWithGroupID:@"" compareDate:NO];
}

#pragma mark -
#pragma mark button
-(void)onClickRight:(id)sender
{
    [[CommonData Instance] phoneCall];
}

@end
