//
//  LikeCell.m
//  XiFangTong
//
//  Created by issuser on 13-7-30.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "GuessLikeCell.h"

@implementation GuessLikeCell

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
-(void)showHouseInfo:(HouseInfo *)house
{
    NSString *logoPath = [NSString stringWithFormat:@"%@%@",ImagePathURL,house.logoPath];
    [logoImageView setImageWithURL:[NSURL URLWithString:logoPath] placeholderImage:[UIImage imageNamed:HouseLogoDefault]];
    fullNameLabel.text = house.shortName;
    buildAddressLabel.text = house.buildAddress;
    avgPriceLabel.text = [NSString stringWithFormat:@"均价：%@元/平米",house.avgPrice];
    if ([house.avgPrice isEqualToString:@"0"]) {
        avgPriceLabel.text = @"价格未定";
    }
    if (![house.tag isEqualToString:@""]) {
        tagLabel.text = [NSString stringWithFormat:@"楼盘特色：%@",house.tag];
    }    
}

@end
