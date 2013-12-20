//
//  TaxViewController.m
//  XiFangTong
//
//  Created by issuser on 13-8-6.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "TaxViewController.h"
#import "TaxCell.h"
#import "TaxResultViewController.h"

@interface TaxViewController ()
{
    NSArray *cellTitles;
}
@end

@implementation TaxViewController

#pragma mark -
#pragma mark view

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    cellTitles = [NSArray arrayWithObjects:@"房屋单价",@"房屋面积",@"住宅类型",@"是否唯一",@"电梯", nil];
    taxObject = [[TaxObject alloc] init];
    taxObject.houseIsOnly = kOnlySmall;
    taxObject.houseType = kNormalType;
    taxObject.withLift = kWithLift;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [table setDataSource:nil];
    [table setDelegate:nil];
    table = nil;
    cellTitles = nil;
}
#pragma mark -
#pragma mark table view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Tax cell";
    TaxCell *cell = (TaxCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"TaxCell" owner:self options:nil];
        for (NSObject *o in objects) {
            if([o isKindOfClass:[TaxCell class]]){
                cell = (TaxCell *)o;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            }
        }
    }
    if (indexPath.row != 5) {
        cell.leftLabel.text = [cellTitles objectAtIndex:indexPath.row];
        if (indexPath.row == 0) {
            cell.rightLabel.text = @"元/平米";
            cell.midTextField.text = taxObject.houseUnitPrice;
        }
        else if(indexPath.row == 1){
            cell.rightLabel.text = @"平方米";
            cell.midTextField.text = taxObject.houseArea;
        }
        else{
            cell.rightLabel.hidden = YES;
            cell.midTextField.hidden = YES;
            if (indexPath.row == 2) {
                [cell showPickerButton:[NSArray arrayWithObjects:@"普通住宅",@"非普通住宅",@"非住宅", nil] andSelectedIndex:taxObject.houseType];
            }
            else if (indexPath.row == 3){
                [cell showPickerButton:[NSArray arrayWithObjects:@"小于等于90平方米且唯一住房",@"90~144平米且唯一住房",@"非唯一住房", nil] andSelectedIndex:taxObject.houseIsOnly];

            }
            else{
                [cell showPickerButton:[NSArray arrayWithObjects:@"有电梯",@"无电梯", nil]andSelectedIndex:taxObject.withLift];
            }
        }
    }
    else{
        cell.leftLabel.hidden = YES;
        cell.rightLabel.hidden = YES;
        cell.midTextField.hidden = YES;
        UIButton *countButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [countButton setBackgroundImage:[UIImage imageNamed:@"calculator_bg"] forState:UIControlStateNormal];
        countButton.frame = CGRectMake(100, 8, 120, 40);
        [countButton addTarget:self action:@selector(countButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:countButton];
    }
    cell.pickerButton.tag = indexPath.row;
    [cell.pickerButton setDelegate:self];
    cell.midTextField.tag = indexPath.row;
    [cell.midTextField setDelegate:self];
    [cell.midTextField addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self textFieldResignResponser];
}
#pragma mark -
#pragma mark button
-(void)countButtonClicked:(id)sender
{
    if (![Tool checkInputIsEmpty:taxObject.houseUnitPrice] && ![Tool checkInputIsEmpty:taxObject.houseArea] && [Tool checkInputIsNumber:taxObject.houseUnitPrice] && [Tool checkInputIsNumber:taxObject.houseArea]) {
        TaxResultViewController *result = [[TaxResultViewController alloc] init];
        result.taxObject = taxObject;
        [self.navigationController pushViewController:result animated:YES];
    }    
}
#pragma mark -
#pragma mark text field delegate
- (void)textFieldWithText:(UITextField *)textField
{
    int tag = [textField tag];
    if (tag == 0) {
        taxObject.houseUnitPrice = textField.text;
    }
    else{
        taxObject.houseArea = textField.text;
    }
}
-(void)textFieldResignResponser
{
    TaxCell *cell = (TaxCell *)[table cellForRowAtIndexPath:editingIndexPath];
    
    if (![cell.midTextField isExclusiveTouch]) {
        [cell.midTextField resignFirstResponder];
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    TaxCell *cell  = (TaxCell *)[[textField superview] superview];
    
    editingIndexPath = [table indexPathForCell:cell];
}
#pragma mark -
#pragma mark show picker button
-(void)pickerButtonBecomeFirstResponder:(MShowPickerButton *)picker
{
    [self textFieldResignResponser];

}
-(void)pickerButton:(MShowPickerButton *)picker didSelectItem:(PickerItem *)item
{
    if (picker.tag == 2) {
        taxObject.houseType = item.tag;
    }
    else if (picker.tag == 3){
        taxObject.houseIsOnly = item.tag;
    }
    else{
        taxObject.withLift = item.tag;
    }
}
@end
