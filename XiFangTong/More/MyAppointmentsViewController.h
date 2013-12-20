//
//  MyAppointmentsViewController.h
//  XiFangTong
//
//  Created by issuser on 13-8-8.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "BasedViewController.h"
#import "AKSegmentedControl.h"
typedef enum
{
    kActiveType,
    kGroupBuyType
}TableType;

@interface MyAppointmentsViewController : BasedViewController<UITableViewDataSource,UITableViewDelegate,AKSegmentedControlDelegate,UIAlertViewDelegate>
{
    IBOutlet UITableView *table;
    IBOutlet AKSegmentedControl *topSegment;
    IBOutlet UIView *headerView;
    IBOutlet UIImageView *headerImageView;
    IBOutlet UILabel *headerLabel;
    
    //add by yanbo 2013/08/13
    NSMutableArray *activeList;
    TableType tableType;
}


//获取活动信息
-(NSMutableArray *)getActives;
-(NSMutableArray *)getGroups;
-(void)onClickRight:(id)sender;

@end
