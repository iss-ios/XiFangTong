//
//  MortgageCell.h
//  XiFangTong
//
//  Created by issuser on 13-8-7.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MShowPickerButton.h"
#import "CheckButton.h"
#import "CheckButtonCombination.h"
#import "AKSegmentedControl.h"
#import "CustomTextField.h"

typedef enum
{
    kTopType,
    kCheckButtonType,
    kTextFieldType,
    kPickerButtonType,
    kBottomType
    
}CellType;

@interface MortgageCell : UITableViewCell

@property (nonatomic) CellType type;
@property (strong, nonatomic) IBOutlet UILabel *leftLabel;
@property (strong, nonatomic) IBOutlet UILabel *rightLabel;
@property (strong, nonatomic) IBOutlet CustomTextField *midTextField;
@property (strong, nonatomic) IBOutlet UIButton *bottomButton;
@property (strong, nonatomic) MShowPickerButton *pickerButton;
@property (strong, nonatomic) CheckButtonCombination *checkButton;

-(void)setType:(CellType)cellType;

-(void)showCheckButtonWithTitle:(NSString *)lTitle rightTitle:(NSString *)rTitle andSelectedIndex:(NSInteger)index;

-(void)showPickerButton:(NSArray *)pickerItems andSelectedIndex:(NSInteger)index;


@end
