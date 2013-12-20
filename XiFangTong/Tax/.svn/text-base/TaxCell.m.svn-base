//
//  TaxCell.m
//  XiFangTong
//
//  Created by issuser on 13-8-6.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "TaxCell.h"

@implementation TaxCell
@synthesize leftLabel;
@synthesize rightLabel;
@synthesize midTextField;
@synthesize pickerButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)showPickerButton:(NSArray *)pickerItems andSelectedIndex:(NSInteger)index
{
    [pickerButton removeFromSuperview];
    if (pickerButton == nil) {
        pickerButton = [[MShowPickerButton alloc] initWithBackgroundImage:[UIImage imageNamed:@"picker_btn_bg"] pickerItems:pickerItems andSelectIndex:index];
        pickerButton.frame = CGRectMake(100, 9, 190, 35);
    }
    [self addSubview:pickerButton];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
