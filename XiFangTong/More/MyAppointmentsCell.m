//
//  MyAppointmentsCell.m
//  XiFangTong
//
//  Created by issuser on 13-8-8.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "MyAppointmentsCell.h"

@implementation MyAppointmentsCell

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
-(void)showEmptyCell
{
    fullNameLabel.hidden = YES;
    introLabel.hidden = YES;
    dateLabel.hidden = YES;
    lineImageView.hidden = YES;
    joinLabel.hidden = YES;
}
-(void)showEmptyInfo:(NSString *)string
{
    [self showEmptyCell];
    emptyLabel.text = string;
    emptyLabel.hidden = NO;
    emptyLabel.frame = CGRectMake(20, 11, 280, 21);

}
//add by yanbo 2013/08/13
-(void)setMessageByActive:(NSDictionary *)active{
    fullNameLabel.text = [active valueForKey:@"buildName"];
    if ([active valueForKey:@"activeName"] == nil) {
        introLabel.text = [active valueForKey:@"groupName"];
    }else{
        dateLabel.text = [active valueForKey:@"activeName"];
    }
    NSString *strDate = [active valueForKey:@"dateEnd"];
    NSArray *arrDate = [strDate componentsSeparatedByString:@"/"];
    dateLabel.text = [NSString stringWithFormat:@"截止日期：%@年%@月%@日",[arrDate objectAtIndex:0],[arrDate objectAtIndex:1],[arrDate objectAtIndex:2]];
}
-(void)showActivity:(ActivityInfo *)activity
{
    
    fullNameLabel.text = activity.houseShortName;
    introLabel.text = activity.daoyu;
    
    
    NSString *time = [[activity.dtime componentsSeparatedByString:@"T"] objectAtIndex:0];
    dateLabel.text = [NSString stringWithFormat:@"截止日期: %@",time];
    [self resizeHeight:activity.daoyu];
}
-(void)showGroupBuy:(GroupBuyInfo *)groupBuy
{
    fullNameLabel.text = groupBuy.houseShortName;
    introLabel.text = groupBuy.houseAgio;
//    if (groupBuy.houseShortName.length == 0) {
//        fullNameLabel.text = @"团购信息加载失败";
//    }
    NSString *time = [[groupBuy.eDate componentsSeparatedByString:@"T"] objectAtIndex:0];
    dateLabel.text = [NSString stringWithFormat:@"截止日期: %@",time];
    [self resizeHeight:groupBuy.houseAgio];
}
-(void)resizeHeight:(NSString *)string
{
    UIFont *font = [UIFont systemFontOfSize:17];
    CGSize size = [string sizeWithFont:font constrainedToSize:CGSizeMake(178.0f, 1000.0f) lineBreakMode:NSLineBreakByCharWrapping];
    
    introLabel.frame = CGRectMake(12, 35, size.width+10, size.height+10);
    if (fullNameLabel.text.length == 0) {
        introLabel.frame = CGRectMake(12, 15, size.width+10, size.height+10);
    }
    dateLabel.frame = CGRectMake(10, introLabel.frame.origin.y+introLabel.frame.size.height+8, 180, 21);
    joinLabel.frame = CGRectMake(200, (introLabel.frame.origin.y+introLabel.frame.size.height+40-21)/2.0, 100, 21);
    lineImageView.frame = CGRectMake(198, 4, 2, introLabel.frame.origin.y+introLabel.frame.size.height+40-8);
    
    
}
@end
