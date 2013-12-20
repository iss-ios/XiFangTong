//
//  MyAppointmentsCell.h
//  XiFangTong
//
//  Created by issuser on 13-8-8.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityInfo.h"
#import "GroupBuyInfo.h"

@interface MyAppointmentsCell : UITableViewCell
{
    IBOutlet UILabel *fullNameLabel;
    IBOutlet UILabel *introLabel;
    IBOutlet UILabel *dateLabel;
    IBOutlet UILabel *emptyLabel;
    IBOutlet UIImageView *lineImageView;
    IBOutlet UILabel *joinLabel;
}
-(void)showEmptyCell;
-(void)showEmptyInfo:(NSString *)string;

//add by yanbo 2013/08/13
-(void)setMessageByActive:(NSDictionary *)active;

-(void)showActivity:(ActivityInfo *)activity;
-(void)showGroupBuy:(GroupBuyInfo *)groupBuy;

@end
