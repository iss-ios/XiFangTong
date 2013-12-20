//
//  MortgageViewController.m
//  XiFangTong
//
//  Created by issuser on 13-8-6.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "MortgageViewController.h"
#import "CheckButton.h"
#import "MortgageCell.h"
#import "CheckButton.h"
#import "MShowPickerButton.h"

#import "MortgageObject.h"
#import "MortgageResultViewController.h"

@interface MortgageViewController ()
{
    NSArray *unitPriceCellTitles;
    NSArray *totalPriceCellTitles;
    NSArray *combinationCellTitles;
    NSArray *mortgagePercents;
    NSArray *mortgageYears;
    NSArray *mortgageRates;
    
    MortgageObject *fundObject;
    MortgageObject *loanObject;
    MortgageObject *combinationObject;
}
@end

@implementation MortgageViewController
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
-(void)mortgageObjectInit
{
    fundObject = [[MortgageObject alloc] init];
    loanObject = [[MortgageObject alloc] init];
    combinationObject = [[MortgageObject alloc] init];
    
    fundObject.mortgageMode = kFundMode;
    
    fundObject.paymentMode = kInterestMode;
    loanObject.paymentMode = kInterestMode;
    combinationObject.paymentMode = kInterestMode;
    
    fundObject.calculationMode = kTotalPriceMode;
    loanObject.calculationMode = kTotalPriceMode;
    
    fundObject.mortgagePercentKey = [mortgagePercents objectAtIndex:0];
    loanObject.mortgagePercentKey = [mortgagePercents objectAtIndex:0];
    fundObject.mortgagePercent = [Tool getMortgagePercentValue:fundObject.mortgagePercentKey];
    loanObject.mortgagePercent = [Tool getMortgagePercentValue:loanObject.mortgagePercentKey];
    
    fundObject.mortgageMonthKey = [mortgageYears objectAtIndex:1];
    loanObject.mortgageMonthKey = [mortgageYears objectAtIndex:2];
    combinationObject.mortgageMonthKey = [mortgageYears objectAtIndex:3];
    
    fundObject.monthAmount = [Tool getMortgageYearValue:fundObject.mortgageMonthKey];
    loanObject.monthAmount = [Tool getMortgageYearValue:loanObject.mortgageMonthKey];
    combinationObject.monthAmount = [Tool getMortgageYearValue:combinationObject.mortgageMonthKey];

    
    fundObject.mortgageRateKey = [mortgageRates objectAtIndex:0];
    loanObject.mortgageRateKey = fundObject.mortgageRateKey;
    combinationObject.mortgageRateKey = fundObject.mortgageRateKey;
    
    fundObject.fundRate = [Tool getMortgageFundRateValue:fundObject.mortgageRateKey withMonthAmount:[fundObject.monthAmount integerValue]];
    loanObject.loanRate = [Tool getMortgageLoanRateValue:loanObject.mortgageRateKey withMonthAmount:[loanObject.monthAmount integerValue]];

    combinationObject.fundRate = [Tool getMortgageFundRateValue:combinationObject.mortgageRateKey withMonthAmount:[combinationObject.monthAmount integerValue]];
    combinationObject.loanRate = [Tool getMortgageLoanRateValue:combinationObject.mortgageRateKey withMonthAmount:[combinationObject.monthAmount integerValue]];


    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    unitPriceCellTitles = [NSArray arrayWithObjects:@"还款方式",@"计算方式",@"单价",@"面积",@"按揭成数",@"按揭年数",@"贷款利率", nil];
    totalPriceCellTitles = [NSArray arrayWithObjects:@"还款方式",@"计算方式",@"总价",@"按揭年数",@"贷款利率", nil];
    combinationCellTitles = [NSArray arrayWithObjects:@"还款方式",@"公积金贷款",@"商业贷款",@"按揭年数",@"贷款利率", nil];
    
    mortgagePercents = [Tool getMortgagePercentArray];
    mortgageYears = [Tool getMortgageYearArray];
    mortgageRates = [Tool getMortgageRateArray];
    
        
    table.type = kTotalPriceType;
    [self mortgageObjectInit];
    
    [self showTopSegmentControl];
        
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    MortgageObject *info = [[MortgageObject alloc] init];
    if (fundObject.mortgageMode == 0) {
        info = fundObject;
    }
    else if (fundObject.mortgageMode == 1){
        info = loanObject;
    }
    if (info.houseTotalPrice.length != 0) {
        info.houseTotalPrice = @"";
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [table setDelegate:nil];
    [table setDataSource:nil];
    table = nil;
    fundObject = nil;
    loanObject = nil;
    combinationObject = nil;
    unitPriceCellTitles = nil;
    totalPriceCellTitles = nil;
    combinationCellTitles = nil;
    [topSegment setDelegate:nil];
    topSegment = nil;
    mortgageYears = nil;
    mortgagePercents = nil;
}
#pragma mark -
#pragma mark table view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (table.type == kUnitPriceType) {
        return unitPriceCellTitles.count+2;
    }
    else if (table.type == kTotalPriceType){
        return totalPriceCellTitles.count+2;
    }
    else{
        return combinationCellTitles.count+2;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 47;
    }
    else if (indexPath.row == 1) {
        return 65;
    }
    return 55;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Tax cell";
    MortgageCell *cell = (MortgageCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"MortgageCell" owner:self options:nil];
        for (NSObject *o in objects) {
            if([o isKindOfClass:[MortgageCell class]]){
                cell = (MortgageCell *)o;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            }
        }
    }
    UILabel *declare = [[UILabel alloc] init];
    declare.text = @"等额本金还款额逐月减少；等额本息还款额每月相同";
    declare.font = [UIFont systemFontOfSize:10.0];
    declare.backgroundColor = [UIColor clearColor];
    declare.textColor = [UIColor lightGrayColor];
    declare.frame = CGRectMake(20, 45, 300, 15);
    [declare removeFromSuperview];
    MortgageObject *info = [[MortgageObject alloc] init];
    if (fundObject.mortgageMode == 0) {
        info = fundObject;
    }
    else if (fundObject.mortgageMode == 1){
        info = loanObject;
    }
    if (indexPath.row == 0) {
        cell.type = kTopType;
//        [cell showTopSegmentWithSelectedIndex:fundObject.mortgageMode];
//        [cell.topSegment setDelegate:self];
    }
    else{
        //显示单价类型
        if (table.type == kUnitPriceType) {
            
            if (indexPath.row == unitPriceCellTitles.count+1) {
                cell.type = kBottomType;
            }
            else{
                cell.leftLabel.text = [unitPriceCellTitles objectAtIndex:indexPath.row-1];
                switch (indexPath.row) {
                        
                    case 1:
                    {
                        cell.type = kCheckButtonType;
                        [cell showCheckButtonWithTitle:@"等额本息" rightTitle:@"等额本金" andSelectedIndex:info.paymentMode];
                        [cell addSubview:declare];
                        
                    }
                        break;
                    case 2:
                    {
                        cell.type = kCheckButtonType;
                        [cell showCheckButtonWithTitle:@"按单价" rightTitle:@"按总价" andSelectedIndex:info.calculationMode];
                    }
                        break;
                    case 3:
                    {
                        cell.type = kTextFieldType;
                        cell.midTextField.text = info.houseUnitPrice;
                        cell.rightLabel.text = @"元/平米";
                    }
                        break;
                    case 4:
                    {
                        cell.type = kTextFieldType;
                        cell.midTextField.text = info.houseArea;
                        cell.rightLabel.text = @"平方米";
                    }
                        break;
                        
                    case 5:
                    {
                        cell.type = kPickerButtonType;
                        if (fundObject.mortgageMode == kFundMode) {
                            [cell showPickerButton:mortgagePercents andSelectedIndex:[mortgagePercents indexOfObject:fundObject.mortgagePercentKey]];
                        }
                        else{
                            [cell showPickerButton:mortgagePercents andSelectedIndex:[mortgagePercents indexOfObject:loanObject.mortgagePercentKey]];
                        }
                        cell.pickerButton.tag = kPercentTag;
                        
                    }
                        break;
                    case 6:
                    {
                        cell.type = kPickerButtonType;
                        if (fundObject.mortgageMode == kFundMode) {
                            [cell showPickerButton:mortgageYears andSelectedIndex:[mortgageYears indexOfObject:fundObject.mortgageMonthKey]];
                        }
                        else{
                            [cell showPickerButton:mortgageYears andSelectedIndex:[mortgageYears indexOfObject:loanObject.mortgageMonthKey]];
                        }

                        cell.pickerButton.tag = kYearTag;

                    }
                        break;
                    case 7:
                    {
                        cell.type = kPickerButtonType;

                        if (fundObject.mortgageMode == kFundMode) {
                            [cell showPickerButton:mortgageRates andSelectedIndex:[mortgageRates indexOfObject:fundObject.mortgageRateKey]];

                            cell.pickerButton.tag = kFundRateTag;
                        }
                        else{
                            [cell showPickerButton:mortgageRates andSelectedIndex:[mortgageRates indexOfObject:loanObject.mortgageRateKey]];
                            cell.pickerButton.tag = kLoanRateTag;

                        }

                    }
                        break;
                        
                    default:
                        break;
                }
            }
        }
        //显示总价类型
        else if (table.type == kTotalPriceType){
            
            if (indexPath.row == totalPriceCellTitles.count+1) {
                cell.type = kBottomType;
            }
            else{
                cell.leftLabel.text = [totalPriceCellTitles objectAtIndex:indexPath.row-1];
                switch (indexPath.row) {
                        
                    case 1:
                    {
                        cell.type = kCheckButtonType;
                        [cell showCheckButtonWithTitle:@"等额本息" rightTitle:@"等额本金" andSelectedIndex:info.paymentMode];
                        
                        [cell addSubview:declare];
                        
                    }
                        break;
                    case 2:
                    {
                        cell.type = kCheckButtonType;
                        [cell showCheckButtonWithTitle:@"按单价" rightTitle:@"按总价" andSelectedIndex:info.calculationMode];
                    }
                        break;
                        
                    case 3:
                    {
                        cell.type = kTextFieldType;
                        cell.midTextField.text = info.houseTotalPrice;
                        cell.rightLabel.text = @"万元";
                    }
                        break;
                    case 4:
                    {
                        cell.type = kPickerButtonType;
                        if (fundObject.mortgageMode == kFundMode) {
                            [cell showPickerButton:mortgageYears andSelectedIndex:[mortgageYears indexOfObject:fundObject.mortgageMonthKey]];
                        }
                        else{
                            [cell showPickerButton:mortgageYears andSelectedIndex:[mortgageYears indexOfObject:loanObject.mortgageMonthKey]];
                        }

                        cell.pickerButton.tag = kYearTag;

                    }
                        break;
                    case 5:
                    {
                        cell.type = kPickerButtonType;
                        if (fundObject.mortgageMode == kFundMode) {
                            [cell showPickerButton:mortgageRates andSelectedIndex:[mortgageRates indexOfObject:fundObject.mortgageRateKey]];
                            
                            cell.pickerButton.tag = kFundRateTag;
                        }
                        else{
                            [cell showPickerButton:mortgageRates andSelectedIndex:[mortgageRates indexOfObject:loanObject.mortgageRateKey]];
                            cell.pickerButton.tag = kLoanRateTag;
                            
                        }

                    }
                        break;
                    default:
                        break;
                }
            }
            
        }
        //组合类型
        else{
            if (indexPath.row == combinationCellTitles.count+1) {
                cell.type = kBottomType;
            }
            else{
                cell.leftLabel.text = [combinationCellTitles objectAtIndex:indexPath.row-1];
                switch (indexPath.row) {
                    case 1:
                    {
                        cell.type = kCheckButtonType;
                        [cell showCheckButtonWithTitle:@"等额本息" rightTitle:@"等额本金" andSelectedIndex:combinationObject.paymentMode];
                        [cell addSubview:declare];
                    }
                        break;
                    case 2:
                    case 3:
                    {
                        cell.type = kTextFieldType;
                        cell.rightLabel.text = @"万元";
                    }
                        break;
                    case 4:
                    {
                        cell.type = kPickerButtonType;
                        [cell showPickerButton:mortgageYears andSelectedIndex:[mortgageYears indexOfObject:combinationObject.mortgageMonthKey]];
                        cell.pickerButton.tag = kYearTag;
                        
                    }
                        break;
                    case 5:
                    {
                        cell.type = kPickerButtonType;
                        [cell showPickerButton:mortgageRates andSelectedIndex:[mortgageRates indexOfObject:combinationObject.mortgageRateKey]];
                        cell.pickerButton.tag = kCombinationRateTag;
                    }
                        break;
                    default:
                        break;
                }
            }
        }
        

    }
    cell.checkButton.tag = indexPath.row;
    [cell.checkButton setDelegate:self];
    [cell.pickerButton setDelegate:self];

    cell.midTextField.tag = indexPath.row;
    [cell.midTextField setDelegate:self];
    [cell.midTextField addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged]; 
    [cell.bottomButton addTarget:self action:@selector(countButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self textFieldResignResponser];
}
#pragma mark -
#pragma mark segment
-(void)showTopSegmentControl
{
    //    [topSegment removeFromSuperview];
    if (topSegment.buttonsArray.count == 0) {
        topSegment = [[AKSegmentedControl alloc] initWithFrame:CGRectMake(8.0, 9, 304.0, 59.0)];
        [topSegment setContentEdgeInsets:UIEdgeInsetsMake(2.0, 2.0, 3.0, 2.0)];
        [topSegment setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin];
        
        [topSegment setSeparatorImage:[UIImage imageNamed:@"segmented-separator.png"]];
        
        NSMutableArray *buttonArrays = [[NSMutableArray alloc] init];
        for (int i = 0; i<3; i++) {
            UIButton *button = [[UIButton alloc] init];
            if (i == 0) {
                [button setTitle:@"公积金" forState:UIControlStateNormal];
            }
            else if (i == 1){
                [button setTitle:@"商贷" forState:UIControlStateNormal];
            }
            else{
                [button setTitle:@"组合" forState:UIControlStateNormal];
            }
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]];
            
            UIImage *buttonSocialImageNormal = [UIImage imageNamed:[NSString stringWithFormat:@"houseloan_tab_%i_notselected2.png",i]];
            UIImage *buttonBackgroundImagePressed = [UIImage imageNamed:[NSString stringWithFormat:@"houseloan_tab_%i_selected2.png",i]];
            [button setBackgroundImage:buttonBackgroundImagePressed forState:UIControlStateHighlighted];
            [button setBackgroundImage:buttonBackgroundImagePressed forState:UIControlStateSelected];
            [button setBackgroundImage:buttonBackgroundImagePressed forState:(UIControlStateHighlighted|UIControlStateSelected)];
            [button setBackgroundImage:buttonSocialImageNormal forState:UIControlStateNormal];
            [buttonArrays addObject:button];
        }
        
        [topSegment setButtonsArray:buttonArrays];
    }
    [topSegment setDelegate:self];
    
    [topSegment removeFromSuperview];
    [table addSubview:topSegment];
}
-(void)textFieldResignResponser
{
    MortgageCell *cell = (MortgageCell *)[table cellForRowAtIndexPath:editingIndexPath];
    
    if (![cell.midTextField isExclusiveTouch]) {
        [cell.midTextField resignFirstResponder];
    }
}
-(void)checkButtonBecomeFirstResponder:(CheckButtonCombination *)segmentedControl
{
    [self textFieldResignResponser];

}
-(void)checkStyleSegmentControl:(CheckButtonCombination *)segmentedControl touchedAtIndex:(NSUInteger)index
{
    if (segmentedControl.tag == 1) {
        if (fundObject.mortgageMode == kFundMode) {
            //公积金下的还款方式
            fundObject.paymentMode = index;
        }
        else if (fundObject.mortgageMode == kLoanMode){
            //商贷下的还款方式
            loanObject.paymentMode = index;
        }
        else{
            //组合下的还款方式
            combinationObject.paymentMode = index;
        }
    }
    else{
        [segmentedControl setDelegate:nil];
        if (fundObject.mortgageMode == kFundMode) {
            //公积金下的计算方式
            fundObject.calculationMode = index;
        }
        else if (fundObject.mortgageMode == kLoanMode){
            //商贷下的计算方式
            loanObject.calculationMode = index;
        }
        if (index == 0) {
            table.type = kUnitPriceType;
        }
        else{
            table.type = kTotalPriceType;
        }
        [table reloadData];
        
    }
}
-(void)segmentedViewController:(AKSegmentedControl *)segmentedControl touchedAtIndex:(NSUInteger)index
{
    fundObject.mortgageMode = index;
    switch (segmentedControl.selectedIndex) {
        case 0:
        {
            if (fundObject.calculationMode == kUnitPriceMode) {
                table.type = kUnitPriceType;
            }
            else{
                table.type = kTotalPriceType;
            }
        }
            break;
        case 1:
        {
            if (loanObject.calculationMode == kUnitPriceMode) {
                table.type = kUnitPriceType;
            }
            else{
                table.type = kTotalPriceType;
            }
        }
            break;
        case 2:
        {
            table.type = kCombinationType;
        }
            break;
        default:
            break;
    }
    [table reloadData];

}
-(void)pickerButtonBecomeFirstResponder:(MShowPickerButton *)picker
{
    [self textFieldResignResponser];

}
-(void)pickerButton:(MShowPickerButton *)picker didSelectItem:(PickerItem *)item
{
    
    switch (picker.tag) {
        case kPercentTag:
        {
            if (fundObject.mortgageMode == kFundMode) {
                //公积金下的按揭成数
                fundObject.mortgagePercent = [Tool getMortgagePercentValue:item.itemValue];
                fundObject.mortgagePercentKey = item.itemValue;
            }
            else{
                //商贷下的按揭成数
                loanObject.mortgagePercent = [Tool getMortgagePercentValue:item.itemValue];
                loanObject.mortgagePercentKey = item.itemValue;
            }
        }
            break;
        case kYearTag:
        {
            if (fundObject.mortgageMode == kFundMode) {
                //公积金下的按揭年数
                fundObject.monthAmount = [Tool getMortgageYearValue:item.itemValue];
                fundObject.mortgageMonthKey = item.itemValue;
                //公积金下的利率
                fundObject.fundRate = [Tool getMortgageFundRateValue:fundObject.mortgageRateKey withMonthAmount:[fundObject.monthAmount integerValue]];
            }
            else if (fundObject.mortgageMode == kLoanMode){
                //商贷下的按揭年数
                loanObject.monthAmount = [Tool getMortgageYearValue:item.itemValue];
                loanObject.mortgageMonthKey = item.itemValue;
                //商贷下的利率
                loanObject.loanRate = [Tool getMortgageLoanRateValue:loanObject.mortgageRateKey withMonthAmount:[loanObject.monthAmount integerValue]];
            }
            else{
                //组合下的按揭年数
                combinationObject.monthAmount = [Tool getMortgageYearValue:item.itemValue];
                combinationObject.mortgageMonthKey = item.itemValue;
                //组合下的公积金利率
                combinationObject.fundRate = [Tool getMortgageFundRateValue:combinationObject.mortgageRateKey withMonthAmount:[combinationObject.monthAmount integerValue]];
                //组合下的商贷利率
                combinationObject.loanRate = [Tool getMortgageLoanRateValue:combinationObject.mortgageRateKey withMonthAmount:[combinationObject.monthAmount integerValue]];
            }
        }
            break;
        case kFundRateTag:
        {
            //公积金下的利率
            fundObject.fundRate = [Tool getMortgageFundRateValue:item.itemValue withMonthAmount:[fundObject.monthAmount integerValue]];
            fundObject.mortgageRateKey = item.itemValue;
        }
            break;
        case kLoanRateTag:
        {
            //商贷下的利率
            loanObject.loanRate = [Tool getMortgageLoanRateValue:item.itemValue withMonthAmount:[loanObject.monthAmount integerValue]];
            loanObject.mortgageRateKey = item.itemValue;
        }
            break;

        case kCombinationRateTag:
        {
            //组合下的公积金利率
            combinationObject.fundRate = [Tool getMortgageFundRateValue:item.itemValue withMonthAmount:[combinationObject.monthAmount integerValue]];
            //组合下的商贷利率
            combinationObject.loanRate = [Tool getMortgageLoanRateValue:item.itemValue withMonthAmount:[combinationObject.monthAmount integerValue]];
            combinationObject.mortgageRateKey = item.itemValue;
        }
            break;

        default:
            break;
    }
}
#pragma mark -
#pragma mark text field delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGPoint p = table.contentOffset;
    if (p.y == 0.0) {
        
        if (textField.tag >3) {
            table.contentOffset = CGPointMake(0, 88);
        }
        else{
            table.contentOffset = CGPointMake(0, 44);
        }
    }
//    table.contentOffset = CGPointMake(0, 44);
    MortgageCell *cell  = (MortgageCell *)[[textField superview] superview];
    editingIndexPath = [table indexPathForCell:cell];
}

- (void)textFieldWithText:(UITextField *)textField
{
    int tag = [textField tag];
    switch (fundObject.mortgageMode) {
        case kFundMode:{
            if (table.type == kUnitPriceType) {
                if (tag == 3) {
                    fundObject.houseUnitPrice = textField.text;//公积金下的房屋单价
                }
                else{
                    fundObject.houseArea = textField.text;//公积金下的房屋面积
                }
            }
            else{
                fundObject.fundAmount = textField.text;//公积金下的房屋总价
            }
        }
            break;
         
        case kLoanMode:
            if (table.type == kUnitPriceType) {
                if (tag == 3) {
                    loanObject.houseUnitPrice = textField.text;//商贷下的房屋单价
                }
                else{
                    loanObject.houseArea = textField.text;//商贷下的房屋面积
                }
            }
            else{
                loanObject.loanAmount = textField.text;//商贷下的房屋总价
            }

            break;
            
        case kCombinationMode:
        {
            if (tag == 2) {
                combinationObject.fundAmount = textField.text;//公积金贷款总额
            }
            else{
                combinationObject.loanAmount = textField.text;//商贷总额
            }
        }
            break;
        default:
            break;
    }
}
#pragma mark -
#pragma mark button
-(void)countButtonClicked:(id)sender
{
    MortgageResultViewController *result = [[MortgageResultViewController alloc] init];
    
    switch (fundObject.mortgageMode) {
        case kFundMode:{
            if (table.type == kUnitPriceType) {
                if (![Tool checkInputIsEmpty:fundObject.houseUnitPrice] && ![Tool checkInputIsEmpty:fundObject.houseArea] && [Tool checkInputIsNumber:fundObject.houseUnitPrice] && [Tool checkInputIsNumber:fundObject.houseArea]) {
                    result.mortgageObject = fundObject;
                    result.mortgageObject.mortgageMode = fundObject.mortgageMode;
                    [self.navigationController pushViewController:result animated:YES];
                }
            }
            else{
                if (![Tool checkInputIsEmpty:fundObject.fundAmount] && [Tool checkInputIsNumber:fundObject.fundAmount]) {
                    result.mortgageObject = fundObject;
                    result.mortgageObject.mortgageMode = fundObject.mortgageMode;
                    [self.navigationController pushViewController:result animated:YES];
                }
            }
        }
            break;
        case kLoanMode:
            {
                if (table.type == kUnitPriceType) {
                
                    if (![Tool checkInputIsEmpty:loanObject.houseUnitPrice] && ![Tool checkInputIsEmpty:loanObject.houseArea] && [Tool checkInputIsNumber:loanObject.houseUnitPrice] && [Tool checkInputIsNumber:loanObject.houseArea]) {
                        result.mortgageObject = loanObject;
                        result.mortgageObject.mortgageMode = fundObject.mortgageMode;
                        [self.navigationController pushViewController:result animated:YES];
                    }
                }
                else{
                    if (![Tool checkInputIsEmpty:loanObject.loanAmount] && [Tool checkInputIsNumber:loanObject.loanAmount]) {
                        result.mortgageObject = loanObject;
                        result.mortgageObject.mortgageMode = fundObject.mortgageMode;
                        [self.navigationController pushViewController:result animated:YES];
                    }
                }
            }
            break;
        case kCombinationMode:
        {
            if (![Tool checkInputIsEmpty:combinationObject.fundAmount] && ![Tool checkInputIsEmpty:combinationObject.loanAmount] && [Tool checkInputIsNumber:combinationObject.fundAmount] && [Tool checkInputIsNumber:combinationObject.loanAmount]) {
                result.mortgageObject = combinationObject;
                result.mortgageObject.mortgageMode = fundObject.mortgageMode;
                [self.navigationController pushViewController:result animated:YES];
            }
        }
            break;
    }    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self textFieldResignResponser];
}
@end
