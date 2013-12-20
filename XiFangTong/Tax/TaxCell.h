//
//  TaxCell.h
//  XiFangTong
//
//  Created by issuser on 13-8-6.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MShowPickerButton.h"
@interface TaxCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *leftLabel;
@property (strong, nonatomic) IBOutlet UILabel *rightLabel;
@property (strong, nonatomic) IBOutlet UITextField *midTextField;
@property (strong, nonatomic) MShowPickerButton *pickerButton;

-(void)showPickerButton:(NSArray *)pickerItems andSelectedIndex:(NSInteger)index;

@end
