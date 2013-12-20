//
//  MortgageObject.m
//  XiFangTong
//
//  Created by issuser on 13-8-13.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "MortgageObject.h"
#include <math.h>

@implementation MortgageObject

@synthesize mortgageMode;
@synthesize paymentMode;
@synthesize calculationMode;
@synthesize houseUnitPrice;
@synthesize houseArea;
@synthesize houseTotalPrice;
@synthesize fundAmount;
@synthesize loanAmount;
@synthesize paymentTotalPrice;
@synthesize interestAmount;
@synthesize downPayment;
@synthesize monthAmount;
@synthesize paymentPerMonth;
@synthesize mortgagePercent;
@synthesize fundRate;
@synthesize loanRate;
@synthesize mortgageRateKey;
@synthesize mortgageMonthKey;
@synthesize mortgagePercentKey;
@synthesize mortgageAmount;

#pragma mark -
#pragma mark 计算贷款总额
-(CGFloat)countMortgageAmount
{
    CGFloat amount = 0.0;
    if (mortgageMode == kCombinationMode) {
        amount = ([fundAmount floatValue]+[loanAmount floatValue])*10000;
    }
    else{
        if (calculationMode == kTotalPriceMode) {
            if (mortgageMode == kFundMode) {
                amount = [fundAmount floatValue]*10000;
            }
            else{
                amount = [loanAmount floatValue]*10000;
            }
        }
        else{
            CGFloat housePrice = [houseArea floatValue]*[houseUnitPrice floatValue];
            CGFloat percent = [mortgagePercent floatValue];
            amount = housePrice*percent;
        }
    }
    return amount;
}
#pragma mark -
#pragma mark 计算等额本息还款总额
-(double)countInterestPaymentTotalPrice
{
    double mTotal = [self countInterestMonthPaymentAmount];
    double amount = mTotal *[monthAmount integerValue];
    return amount;
}
#pragma mark -
#pragma mark 计算等额本金还款总额
-(double)countPrincipalPaymentTotalPrice
{
    double amount = 0.0;

    //贷款总额
    double total = [self countMortgageAmount];
    //每月本金
    double monthPri = total/[monthAmount floatValue];
    //月利率
    double mRate = 0.0;
    //每月利息
    double monthInt = 0.0;
    
    //每月还款额
    double mTotal = 0.0;
    
        
    for (int i = 1; i<= [monthAmount integerValue]; i++) {
        if (mortgageMode == kFundMode) {
            mRate = [fundRate doubleValue]/(12.0*100.0);
            monthInt = (total - monthPri * (i - 1)) * mRate;
            mTotal = monthInt+monthPri;
        }
        else if(mortgageMode == kLoanMode){
            mRate = [loanRate doubleValue]/(12.0*100.0);
            monthInt = (total - monthPri * (i - 1)) * mRate;
            mTotal = monthInt+monthPri;
        }
        else{
            double monthPri1 = [fundAmount doubleValue]*10000/[monthAmount integerValue];
            double monthPri2 = [loanAmount doubleValue]*10000/[monthAmount integerValue];
            double mRate1 = [fundRate doubleValue]/(12.0*100.0);
            double mRate2 = [loanRate doubleValue]/(12.0*100.0);
            double mInt1 = ([fundAmount doubleValue]*10000 - monthPri1 * (i - 1)) * mRate1;
            double mInt2 = ([loanAmount doubleValue]*10000 - monthPri2 * (i - 1)) * mRate2;
            mTotal = mInt1+mInt2+monthPri;
        }
        amount = amount +mTotal;
    }
    return amount;
}
#pragma mark -
#pragma mark 计算等额本息下月还款总额
-(double)countInterestMonthPaymentAmount
{
    double mTotal = 0.0;
    double pTotal = [self countMortgageAmount];
    double mRate = 0.0;
   
    if (mortgageMode == kFundMode) {
        
//        NSString *mrs = [NSString stringWithFormat:@"%.8f",[fundRate floatValue]/(12.0*100)];
        mRate = [fundRate doubleValue]/(12.0*100.0);
        
        double pf = pow(1+mRate, [monthAmount integerValue]);
        
        mTotal = pTotal*mRate*pf/(pf -1);
    }
    else if(mortgageMode == kLoanMode){
//        NSString *mrs = [NSString stringWithFormat:@"%.8f",[loanRate floatValue]/(12.0*100)];
        mRate = [loanRate doubleValue]/(12.0*100.0);
        
        double pf = pow(1+mRate, [monthAmount integerValue]);
        
        mTotal = pTotal*mRate*pf/(pf -1);
    }
    else{
        
        double mRate1 = [fundRate doubleValue]/(12.0*100.0);
        double mRate2 = [loanRate doubleValue]/(12.0*100.0);
//        NSString *mrs1 = [NSString stringWithFormat:@"%.8f",[fundRate floatValue]/(12.0*100)];
//        CGFloat mRate1 = [mrs1 floatValue];
//       
//        NSString *mrs2 = [NSString stringWithFormat:@"%.8f",[loanRate floatValue]/(12.0*100)];
//        CGFloat mRate2 = [mrs2 floatValue];
       
        double pf1 = pow(1+mRate1, [monthAmount integerValue]);
        double pf2 = pow(1+mRate2, [monthAmount integerValue]);
        double mTotal1 = [fundAmount doubleValue]*10000*mRate1*pf1/(pf1 -1);
        double mTotal2 = [loanAmount doubleValue]*10000*mRate2*pf2/(pf2 -1);
        mTotal = mTotal1+mTotal2;
    }
    return mTotal;
    
}
#pragma mark -
#pragma mark 计算等额本金下月还款总额
-(NSArray *)countPrincipalMonthPaymentAmount
{
//    每月还款额=每月本金+每月本息
//    每月本金=本金/还款月数
//    每月本息=（本金-累计还款总额）X月利率
    NSMutableArray *months = [[NSMutableArray  alloc] init];
    if (months.count != 0) {
        [months removeAllObjects];
    }
    //贷款总额
    double total = [self countMortgageAmount];
    //每月本金
    double monthPri = total/[monthAmount doubleValue];
    //月利率
    double mRate = 0.0;
    //每月利息
    double monthInt = 0.0;
    
    //每月还款额
    double mTotal = 0.0;
    NSString *s;
    
    for (int i = 1; i<= [monthAmount integerValue]; i++) {
        
        if (mortgageMode == kFundMode) {
            mRate = [fundRate doubleValue]/(12.0*100.0);
            monthInt = (total - monthPri * (i - 1)) * mRate;
            mTotal = monthInt+monthPri;
        }
        else if(mortgageMode == kLoanMode){
            mRate = [loanRate doubleValue]/(12.0*100.0);
            monthInt = (total - monthPri * (i - 1)) * mRate;
            mTotal = monthInt+monthPri;
        }
        else{
            double monthPri1 = [fundAmount doubleValue]*10000/[monthAmount integerValue];
            double monthPri2 = [loanAmount doubleValue]*10000/[monthAmount integerValue];
            double mRate1 = [fundRate doubleValue]/(12.0*100.0);
            double mRate2 = [loanRate doubleValue]/(12.0*100.0);
            double mInt1 = ([fundAmount doubleValue]*10000 - monthPri1 * (i - 1)) * mRate1;
            double mInt2 = ([loanAmount doubleValue]*10000 - monthPri2 * (i - 1)) * mRate2;
            mTotal = mInt1+mInt2+monthPri;
        }
        s = [NSString stringWithFormat:@"%.2f 元",mTotal];
        [months addObject:s];
        
    }
    return months;
}

#pragma mark -
#pragma mark 计算等额本息下支付利息
-(double)countInterestAmount
{
    double interest = [self countInterestPaymentTotalPrice]-[self countMortgageAmount];
    return interest;

}
#pragma mark -
#pragma mark计算等额本金下支付利息
-(double)countPrincipalInterestAmount
{
    //贷款总额
    double total = [self countMortgageAmount];
    //每月本金
    double monthPri = total/[monthAmount integerValue];
    //月利率
    double mRate = 0.0;
    //每月利息
    double monthInt = 0.0;
    
    //每月还款额
    double interest = 0.0;
    for (int i = 1; i<= [monthAmount integerValue]; i++) {

        if (mortgageMode == kFundMode) {
            mRate = [fundRate doubleValue]/(12.0*100.0);
            monthInt = (total - monthPri * (i - 1)) * mRate;
        }
        else if(mortgageMode == kLoanMode){
            mRate = [loanRate doubleValue]/(12.0*100.0);
            monthInt = (total - monthPri * (i - 1)) * mRate;
        }
        else{
            double monthPri1 = [fundAmount doubleValue]*10000/[monthAmount integerValue];
            double monthPri2 = [loanAmount doubleValue]*10000/[monthAmount integerValue];
            double mRate1 = [fundRate doubleValue]/(12.0*100.0);
            double mRate2 = [loanRate doubleValue]/(12.0*100.0);
           
            double mInt1 = ([fundAmount doubleValue]*10000 - monthPri1 * (i - 1)) * mRate1;
            double mInt2 = ([loanAmount doubleValue]*10000 - monthPri2 * (i - 1)) * mRate2;
            monthInt = mInt1+mInt2;
            
        }

        interest = interest+monthInt;
    }
    return interest;
}
#pragma mark -
#pragma mark
-(void)countMortgageDetail
{
    //@"房款总额:",@"贷款总额:",@"还款总额:",@"支付利息:",@"首月还款:",@"贷款月数:",@"月均还款:
   
    //房款总额
    if (mortgageMode != kCombinationMode && calculationMode == kUnitPriceMode) {
        houseTotalPrice = [NSString stringWithFormat:@"%.2f",[houseUnitPrice floatValue]*[houseArea floatValue]];
        
    }
    //贷款总额
    mortgageAmount = [NSString stringWithFormat:@"%.2f",[self countMortgageAmount]];
    
    downPayment = [NSString stringWithFormat:@"%.2f",[houseTotalPrice doubleValue]-[mortgageAmount doubleValue]];
   
    //还款总额、支付利息
    if (paymentMode == kInterestMode) {
        //还款总额
        paymentTotalPrice =[NSString stringWithFormat:@"%.2f",[self countInterestPaymentTotalPrice]];
        //支付利息
        interestAmount = [NSString stringWithFormat:@"%.2f",[self countInterestAmount]];
    }
    else{
        //还款总额
        paymentTotalPrice =[NSString stringWithFormat:@"%.2f",[self countPrincipalPaymentTotalPrice]];
        //支付利息
        interestAmount = [NSString stringWithFormat:@"%.2f",[self countPrincipalInterestAmount]];
    }
    
}
@end
