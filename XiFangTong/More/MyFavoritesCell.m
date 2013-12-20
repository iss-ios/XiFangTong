//
//  MyFavoritesCell.m
//  XiFangTong
//
//  Created by issuser on 13-8-2.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "MyFavoritesCell.h"

@implementation MyFavoritesCell

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

#pragma mark 图片加载
- (void)loadImageFromURL:(NSURL*)url {
    NSURLRequest* request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:60.0];
    connection = [[NSURLConnection alloc]
                  initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)theConnection
    didReceiveData:(NSData *)incrementalData {
    if (data==nil) {
        data =
        [[NSMutableData alloc] initWithCapacity:2048];
    }
    [data appendData:incrementalData];

}

- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
    if (data ==nil) {
        return;
    }else{
        logoImage.image = [UIImage imageWithData:data];
    }
}

//add by yanbo 2013/08/19
-(void)setMessageByFavorite:(HouseInfo *)house{
    
    buildName.text = house.shortName;
    buildPlace.text = house.buildAddress;
    buildPrice.text = [NSString stringWithFormat:@"价格行情：%@",house.referencePrice];
//    if ([house.referencePrice isEqualToString:@"0"]) {
//        buildPrice.text = @"价格未定";
//    }
    finishDate.text = [NSString stringWithFormat:@"交付时间：%@",house.finishDate];
    if (![house.tag isEqualToString:@""]) {
        buildTag.text = [NSString stringWithFormat:@"楼盘特色： %@",house.tag];
    }

    NSString *logoPath = [NSString stringWithFormat:@"%@%@",ImagePathURL,house.logoPath];
    [logoImage setImageWithURL:[NSURL URLWithString:logoPath] placeholderImage:[UIImage imageNamed:HouseLogoDefault]];
    
    //活动
    if (![house.tuan isEqualToString:@""]) {
        buildAct.text = house.tuan;
        buildAct.hidden = NO;
        saleImage.hidden = NO;
    }
    else{
        if (![house.actIntro isEqualToString:@""]) {
            buildAct.text = house.actIntro;
            buildAct.hidden = NO;
            saleImage.hidden = NO;
        }
        else{
            saleImage.hidden = YES;
            buildAct.hidden = YES;
            
        }
    }

    //状态
    switch ([house.opened integerValue]) {
        case 0:
            stateImage.image = [UIImage imageNamed:@"未售.png"];
            break;
        case 1:
            stateImage.image = [UIImage imageNamed:@"在售.png"];

            break;
        case 2:
            stateImage.image = [UIImage imageNamed:@"尾盘.png"];
            break;
        default:
            stateImage.image = [UIImage imageNamed:@"未售.png"];
            break;
    }
}

@end
