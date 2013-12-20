//
//  SearchHouseCell.m
//  XiFangTong
//
//  Created by issuser on 13-7-31.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "SearchHouseCell.h"

@implementation SearchHouseCell

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
    //tuan/mb_382.jpg
    NSString *logoPath = [NSString stringWithFormat:@"%@%@",ImagePathURL,house.logoPath];
//    NSString *logoPath = [NSString stringWithFormat:@"%@tuan/mb_382.jpg",ImagePathURL];

    [logoImageView setImageWithURL:[NSURL URLWithString:logoPath] placeholderImage:[UIImage imageNamed:HouseLogoDefault]];
    fullNameLabel.text = house.shortName;
    buildAddressLabel.text = house.buildAddress;
    if (house.buildAddress.length == 0) {
        buildAddressLabel.text = @"地址不详";
    }
    referencePriceLabel.text = house.referencePrice;
//    if ([house.referencePrice isEqualToString:@"0"]&&house.referencePrice.length) {
//        referencePriceLabel.text = @"价格未定";
//    }
    if ([house.opened integerValue] == 0) {
        openedImageView.image = [UIImage imageNamed:@"未售.png"];
    }
    else if([house.opened integerValue] == 1){
        openedImageView.image = [UIImage imageNamed:@"在售.png"];
    }
    else{
        openedImageView.image = [UIImage imageNamed:@"尾盘.png"];
    }
    if (house.tuan.length !=0) {
        introLabel.text = house.tuan;
        introLabel.hidden = NO;
        introImageView.hidden = NO;
    }
    else{
        if (house.actIntro.length != 0) {
            introLabel.text = house.actIntro;
            introLabel.hidden = NO;
            introImageView.hidden = NO;
        }
        else{
            introImageView.hidden = YES;
            introLabel.hidden = YES;

        }
    }
}
@end
