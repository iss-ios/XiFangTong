//
//  HouseDetailViewController.h
//  XiFangTong
//
//  Created by issuser on 13-8-12.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "BasedViewController.h"
#import "HouseInfo.h"
#import "HouseInfoRequest.h"
@interface HouseDetailViewController : BasedViewController<UITableViewDataSource,UITableViewDelegate,HouseInfoRequestDelegate,UITextViewDelegate>
{
    IBOutlet UITableView *table;
    IBOutlet UIView *headerView;
    IBOutlet UIView *footerView;
    IBOutlet UIImageView *houseImageView;
    
    IBOutlet UIButton *activityButton;
    IBOutlet UIButton *groupBuyButton;
    IBOutlet UILabel  *activityLabel;
    IBOutlet UILabel  *groupBuyLabel;
    
    IBOutlet UIButton *mortgageButton;
    IBOutlet UIButton *phoneButton;
    IBOutlet UIButton *mapButton;
    
    HouseInfoRequest *houseInfoRequest;
    HouseInfo *house;
    BOOL stored;
}
@property (strong, nonatomic) NSString *houseId;
//@property (strong, nonatomic) HouseInfo *house;
-(void)onClickRight:(id)sender;

@end
