//
//  HouseDetailCell.m
//  XiFangTong
//
//  Created by issuser on 13-8-12.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "HouseDetailCell.h"

@implementation HouseDetailCell

@synthesize topLabel;
@synthesize bottomLabel;
@synthesize topImageView;

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
#pragma mark -
#pragma mark
-(void)setType:(CellType)cellType
{
    if (cellType == kHighlightedType) {
        topImageView.image = [UIImage imageNamed:@"lpdy_yellow_title_bg"];
        topImageView.frame = CGRectMake(0, 0, 320, 50);
        bottomLabel.hidden = YES;
        topLabel.frame = CGRectMake(20, 0, 320, 50);
        topLabel.font = [UIFont boldSystemFontOfSize:17.0];
        topLabel.textColor = [UIColor whiteColor];
        topLabel.textAlignment = NSTextAlignmentLeft;
    }
    else{
        topImageView.image = [UIImage imageNamed:@"lpdy_gray_title_bg"];
        topImageView.frame = CGRectMake(0, 0, self.frame.size.width, 30);
        bottomLabel.hidden = NO;
        topLabel.frame = CGRectMake(20, 4, 280, 21);
        topLabel.font = [UIFont systemFontOfSize:15.0];
        topLabel.textColor = [UIColor darkGrayColor];
        topLabel.textAlignment = NSTextAlignmentLeft;
        
    }
}
//显示内容，并根据文字长度调整label尺寸
-(void)showBottomText:(NSString *)text
{    
    bottomLabel.text = text;

    UIFont *font = [UIFont systemFontOfSize:17];
    CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(280.0f, 1000.0f) lineBreakMode:NSLineBreakByCharWrapping];
    
    bottomLabel.frame = CGRectMake(20, 35, size.width+10, size.height+10);
    bottomLabel.lineBreakMode = NSLineBreakByCharWrapping;
     
}

@end
