//
//  LikeCell.h
//  XiFangTong
//
//  Created by issuser on 13-7-30.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HouseInfo.h"

@interface GuessLikeCell : UITableViewCell
{
    IBOutlet UIImageView *logoImageView;
    IBOutlet UILabel     *fullNameLabel;
    IBOutlet UILabel     *avgPriceLabel;
    IBOutlet UILabel     *buildAddressLabel;
    IBOutlet UILabel     *tagLabel;
}
-(void)showHouseInfo:(HouseInfo *)house;

@end
