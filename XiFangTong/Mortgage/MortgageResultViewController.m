//
//  MortgageResultViewController.m
//  XiFangTong
//
//  Created by issuser on 13-8-13.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "MortgageResultViewController.h"
#import "MortgageResultCell.h"
@interface MortgageResultViewController ()
{
    NSArray *totalPriceTitles;
    NSArray *unitPriceTitles;
    NSArray *totalPriceValues;
    NSArray *unitPriceValues;
}
@end

@implementation MortgageResultViewController

@synthesize mortgageObject;

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
    unitPriceTitles = [NSArray arrayWithObjects:@"房款总额:",@"贷款总额:",@"还款总额:",@"支付利息:",@"首期付款:",@"贷款月数:",@"月均还款:", nil];
    totalPriceTitles = [NSArray arrayWithObjects:@"房款总额:",@"贷款总额:",@"还款总额:",@"支付利息:",@"首期付款:",@"贷款月数:",@"月均还款:", nil];
    
    [mortgageObject countMortgageDetail];
   
    totalPriceValues = [NSArray arrayWithObjects:@"略",[NSString stringWithFormat:@"%@ 元",mortgageObject.mortgageAmount],[NSString stringWithFormat:@"%@ 元",mortgageObject.paymentTotalPrice],[NSString stringWithFormat:@"%@ 元",mortgageObject.interestAmount],@"略",[NSString stringWithFormat:@"%@ 月",mortgageObject.monthAmount],@"月均还款:",nil];
    
    unitPriceValues = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@ 元",mortgageObject.houseTotalPrice],[NSString stringWithFormat:@"%@ 元",mortgageObject.mortgageAmount],[NSString stringWithFormat:@"%@ 元",mortgageObject.paymentTotalPrice],[NSString stringWithFormat:@"%@ 元",mortgageObject.interestAmount],[NSString stringWithFormat:@"%@ 元",mortgageObject.downPayment],[NSString stringWithFormat:@"%@ 月",mortgageObject.monthAmount],@"月均还款:",nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [table setDelegate:nil];
    [table setDataSource:nil];
    table = nil;
}
#pragma mark -
#pragma mark table view
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (mortgageObject.paymentMode == kPrincipalMode) {
        return 2;
    }
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (mortgageObject.paymentMode == kPrincipalMode && section == 1) {
        if (unfold) {
            return [mortgageObject.monthAmount integerValue];
        }
        else{
            return 1;
         }
    }
    else{
        if (mortgageObject.mortgageMode == kCombinationMode) {
            //组合
            if (mortgageObject.paymentMode == kInterestMode) {
                // 等额本息
                return [unitPriceTitles count];
            }
            else{
                 //等额本金
                return [unitPriceTitles count]-1;
            }
        }
        else{
            if (mortgageObject.paymentMode == kInterestMode) {
                if (mortgageObject.calculationMode == kUnitPriceMode) {
                     //商贷、公积金/等额本息/单价
                    return [unitPriceTitles count];
                }
                else{
                    //商贷、公积金/等额本息/总价
                    return [totalPriceTitles count];
                }
            }
            else{
                if (mortgageObject.calculationMode == kUnitPriceMode) {
                    //商贷、公积金/等额本金/单价
                    return [unitPriceTitles count]-1;
                }
                else{
                    //商贷、公积金/等额本金/总价
                    return [totalPriceTitles count]-1;
                }
            }
        }
    }
    
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if ((mortgageObject.paymentMode == kPrincipalMode && section == 1)||mortgageObject.paymentMode == kInterestMode) {
        return @"*以上计算仅供参考，具体按实际结算金额为准";
    }
    else{
        
        return nil;
    }
    
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        
        return @"月均还款";
    }
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MortgageResultCell";
    MortgageResultCell *cell = (MortgageResultCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"MortgageResultCell" owner:self options:nil];
        for (NSObject *o in objects) {
            if([o isKindOfClass:[MortgageResultCell class]]){
                cell = (MortgageResultCell *)o;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            }
        }
    }
    if (indexPath.section == 1) {
        if (unfold) {
            cell.leftLabel.text = [NSString stringWithFormat:@"第%i月:",indexPath.row+1];
            NSArray *array = [mortgageObject countPrincipalMonthPaymentAmount];
            cell.rightLabel.text = [array objectAtIndex:indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryNone;

        }
        else{
            cell.leftLabel.text = @"月还款详细";
            cell.rightLabel.text = nil;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }
    }
    else{
        if (mortgageObject.mortgageMode != kCombinationMode && mortgageObject.calculationMode == kUnitPriceMode) {
            cell.leftLabel.text = [unitPriceTitles objectAtIndex:indexPath.row];
            cell.rightLabel.text = [unitPriceValues objectAtIndex:indexPath.row];

            if (mortgageObject.paymentMode == kInterestMode && indexPath.row == unitPriceTitles.count-1) {
                cell.rightLabel.text = [NSString stringWithFormat:@"%.2f 元",[mortgageObject countInterestMonthPaymentAmount]];
            }
        }
        else{
            cell.leftLabel.text = [totalPriceTitles objectAtIndex:indexPath.row];
            cell.rightLabel.text = [totalPriceValues objectAtIndex:indexPath.row];
            if (mortgageObject.paymentMode == kInterestMode && indexPath.row == totalPriceTitles.count-1) {
                cell.rightLabel.text = [NSString stringWithFormat:@"%.2f 元",[mortgageObject countInterestMonthPaymentAmount]];
            }
        }

    }
        
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (!unfold) {
            unfold = YES;
            
        }
        else{
            unfold = NO;
        }
        [tableView reloadData];
    }
}
@end
