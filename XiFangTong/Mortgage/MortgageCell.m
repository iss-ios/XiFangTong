//
//  MortgageCell.m
//  XiFangTong
//
//  Created by issuser on 13-8-7.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "MortgageCell.h"

@implementation MortgageCell
@synthesize type;
@synthesize leftLabel;
@synthesize rightLabel;
@synthesize midTextField;
@synthesize bottomButton;
@synthesize pickerButton;
@synthesize checkButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)showCheckButtonWithTitle:(NSString *)lTitle rightTitle:(NSString *)rTitle andSelectedIndex:(NSInteger)index
{
    [checkButton removeFromSuperview];
    
    checkButton = [[CheckButtonCombination alloc] initWithFrame:CGRectMake(105, 9, 195, 35) leftTitle:lTitle rightTitle:rTitle andSelecteIndex:index];
    [self addSubview:checkButton];
}
-(void)showPickerButton:(NSArray *)pickerItems andSelectedIndex:(NSInteger)index
{
    [pickerButton removeFromSuperview];

    pickerButton = [[MShowPickerButton alloc] initWithBackgroundImage:[UIImage imageNamed:@"mortgage_pickerbtn_bg"] pickerItems:pickerItems andSelectIndex:index];
        pickerButton.frame = CGRectMake(100, 9, 190, 35);
    [self addSubview:pickerButton];
}
-(void)setType:(CellType)cellType
{
    type = cellType;
    switch (cellType) {
        case kTopType:
        {
            checkButton.hidden = YES;
            pickerButton.hidden = YES;
            midTextField.hidden = YES;
            bottomButton.hidden = YES;
            leftLabel.hidden = YES;
            rightLabel.hidden = YES;
        }
            break;
        case kCheckButtonType:
        {
            midTextField.hidden = YES;
            pickerButton.hidden = YES;
            bottomButton.hidden = YES;
            rightLabel.hidden = YES;
            leftLabel.hidden = NO;
            checkButton.hidden = NO;

        }
            break;
        case kTextFieldType:
        {
            pickerButton.hidden = YES;
            bottomButton.hidden = YES;
            midTextField.hidden = NO;
            leftLabel.hidden = NO;
            rightLabel.hidden = NO;
            checkButton.hidden = YES;
        }
            break;
        case kPickerButtonType:
        {
            midTextField.hidden = YES;
            rightLabel.hidden = YES;
            bottomButton.hidden = YES;
            pickerButton.hidden = NO;
            leftLabel.hidden = NO;
            checkButton.hidden = YES;
            
        }
            break;
        case kBottomType:
        {
            midTextField.hidden = YES;
            pickerButton.hidden = YES;
            rightLabel.hidden = YES;
            bottomButton.hidden = NO;
            leftLabel.hidden = YES;
            checkButton.hidden = YES;
        }
            break;
        default:
            break;
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
