//
//  HistoryCell.m
//  XiFangTong
//
//  Created by issuser on 13-8-5.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "HistoryCell.h"
#import "HouseDetailViewController.h"

@implementation HistoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

//add by yanbo 2013/08/15
-(void)setMessageWithHistory:(HouseInfo *)house
{
    houseName.text = house.shortName;
    price.text = [NSString stringWithFormat:@"价格行情：%@",house.referencePrice];
//    if ([house.referencePrice isEqualToString:@"0"]) {
//        price.text = @"价格未定";
//    }
    
    NSString *logoPath = [NSString stringWithFormat:@"%@%@",ImagePathURL,house.logoPath];
    [houseImage setImageWithURL:[NSURL URLWithString:logoPath] placeholderImage:[UIImage imageNamed:HouseLogoDefault]];

}

@end
