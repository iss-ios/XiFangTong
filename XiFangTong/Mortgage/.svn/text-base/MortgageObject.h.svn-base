//
//  MortgageObject.h
//  XiFangTong
//
//  Created by issuser on 13-8-13.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum
{
    kFundMode,//公积金
    kLoanMode,//商贷
    kCombinationMode//组合
    
}MortgageMode;//房贷类型

typedef enum
{
    kInterestMode,//等额本息
    kPrincipalMode//等额本金
    
}PaymentMode;//还款方式

typedef enum
{
    kUnitPriceMode,
    kTotalPriceMode
    
}CalculationMode;//计算方式

@interface MortgageObject : NSObject

@property (nonatomic)       MortgageMode  mortgageMode;//房贷类型（公积金、商贷、组合）
@property (nonatomic)       PaymentMode  paymentMode;//还款方式（等额还款、等息还款）
@property (nonatomic)       CalculationMode  calculationMode;//计算方式（单价、总价）
@property (copy, nonatomic) NSString   *houseUnitPrice;//房子单价
@property (copy, nonatomic) NSString   *houseArea;//房子面积
@property (copy, nonatomic) NSString   *houseTotalPrice;//房子总价
@property (copy, nonatomic) NSString   *fundAmount;//公积金贷款总额
@property (copy, nonatomic) NSString   *loanAmount;//商业贷款总额
@property (copy, nonatomic) NSString   *mortgageAmount;//贷款总额

@property (copy, nonatomic) NSString   *paymentTotalPrice;//还款总额
@property (copy, nonatomic) NSString   *interestAmount;//支付利息
@property (copy, nonatomic) NSString   *downPayment;//首期付款
@property (copy, nonatomic) NSString   *monthAmount;//贷款月数
@property (copy, nonatomic) NSString   *paymentPerMonth;//月均还款
@property (copy, nonatomic) NSString   *mortgagePercent;//按揭成数
@property (copy, nonatomic) NSString   *fundRate;//公积金利率
@property (copy, nonatomic) NSString   *loanRate;//商贷利率
@property (copy, nonatomic) NSString   *mortgageRateKey;//利率名称
@property (copy, nonatomic) NSString   *mortgageMonthKey;//按揭年数名
@property (copy, nonatomic) NSString   *mortgagePercentKey;//按揭成数名


//计算等额本息下月还款总额
-(double)countInterestMonthPaymentAmount;

//计算等额本金下月还款总额
-(NSArray *)countPrincipalMonthPaymentAmount;

//计算房贷中各项参数值
-(void)countMortgageDetail;

@end
