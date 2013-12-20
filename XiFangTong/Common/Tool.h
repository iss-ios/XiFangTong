//
//  Tool.h
//  XiFangTong
//
//  Created by issuser on 13-7-31.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MShowPickerButton.h"

@interface Tool : NSObject<UIAlertViewDelegate>

+(NSUInteger) countLengthOfString:(NSString *)text;

+(NSUInteger) countLengthOfStringSpecial:(NSString *)text;

+(BOOL)checkInputIsEmpty:(NSString *) input;

+(BOOL)checkInputIsNumber:(NSString *)string;

+(NSArray *)getMortgagePercentArray;

+(NSArray *)getMortgageYearArray;

+(NSArray *)getMortgageFundRateArray;

+(NSArray *)getMortgageLoanRateArray;

+(NSArray *)getMortgageRateArray;

+(NSString *)getMortgagePercentValue:(NSString *)key;

+(NSString *)getMortgageYearValue:(NSString *)key;

+(NSString *)getMortgageFundRateValue:(NSString *)key withMonthAmount:(NSInteger)amount;

+(NSString *)getMortgageLoanRateValue:(NSString *)key withMonthAmount:(NSInteger)amount;

+(CGFloat)getAvgPriceByString:(NSString *)price;

+(NSString *)getMinPriceByString:(NSString *)price;

+(NSString *)getMaxPriceByString:(NSString *)price;

+(BOOL)compareDateA:(NSString *)dateA isLaterThanDateB:(NSString *)dateB;

+(BOOL)compareDateIsLaterThanNowDate:(NSString *)date;

+(BOOL)saveImageToLocalInUrl:(NSString *)url withName:(NSString *)imageName ofType:(NSString *)extension;

+(UIImage *)loadLocalImage:(NSString *)imageName;
//+(void)phoneCall;

@end
