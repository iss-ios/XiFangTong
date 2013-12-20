//
//  Tool.m
//  XiFangTong
//
//  Created by issuser on 13-7-31.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "Tool.h"
#import "Reachability.h"
#define PASSWORD_CODE @"1234567890."

@implementation Tool

+(NSUInteger) countLengthOfString: (NSString *) text
{
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
        
    }
    NSUInteger unicodeLength = asciiLength / 2;
    if(asciiLength % 2) {
        unicodeLength++;
    }
    return unicodeLength;
    
    /*
    int strlength = 0;
    char* p = (char*)[text cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[text lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
           
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
     */
}
+(NSUInteger)countLengthOfStringSpecial:(NSString *)text
{
    int strlength = 0;
    char* p = (char*)[text cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[text lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            
            strlength++;
        }
        else {
            p++;
        }
    }
    
    return strlength;

}
+(BOOL)checkInputIsEmpty:(NSString *)input
{
    NSInteger length = input.length;
    if (length == 0) {
            
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"输入字段不能为空"
                                                               delegate:nil
                                                      cancelButtonTitle:NSLocalizedString(@"确认", @"") otherButtonTitles:nil];
            [alertView show];
        
        return YES;
    }
    return NO;
}
+(BOOL)checkInputIsNumber:(NSString *)string
{
    NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:PASSWORD_CODE] invertedSet];
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
    BOOL result = [string isEqualToString:filtered];
    if (result) {
        return YES;
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"请输入正确的数字"
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"确认", @"") otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    
}
+(NSArray *)getMortgagePercentArray
{
    NSMutableArray *mortgagePercents = [[NSMutableArray alloc] init];
    if (mortgagePercents.count != 0) {
        [mortgagePercents removeAllObjects];
    }
    NSDictionary *mortgageInfo = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MortgageInfo.plist" ofType:nil]];
    for (NSDictionary *dic in [mortgageInfo objectForKey:@"Percent"]) {
        NSString *key = [dic objectForKey:@"PercentKey"];
        [mortgagePercents addObject:key];
    }
    return mortgagePercents;
}
+(NSArray *)getMortgageYearArray
{
    NSMutableArray *mortgageYears = [[NSMutableArray alloc] init];
    if (mortgageYears.count != 0) {
        [mortgageYears removeAllObjects];
    }
    NSDictionary *mortgageInfo = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MortgageInfo.plist" ofType:nil]];
    for (NSDictionary *dic in [mortgageInfo objectForKey:@"Year"]) {
        NSString *key = [dic objectForKey:@"YearKey"];
        [mortgageYears addObject:key];
    }
    return mortgageYears;
}
+(NSArray *)getMortgageFundRateArray
{
    NSMutableArray *fundRates = [[NSMutableArray alloc] init];
    if (fundRates.count != 0) {
        [fundRates removeAllObjects];
    }
    NSDictionary *mortgageInfo = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MortgageInfo.plist" ofType:nil]];
    for (NSDictionary *dic in [mortgageInfo objectForKey:@"FundRate"]) {
        NSString *key = [dic objectForKey:@"RateKey"];
        [fundRates addObject:key];
    }
    return fundRates;

}
+(NSArray *)getMortgageLoanRateArray
{
    NSMutableArray *loanRates = [[NSMutableArray alloc] init];
    if (loanRates.count != 0) {
        [loanRates removeAllObjects];
    }
    NSDictionary *mortgageInfo = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MortgageInfo.plist" ofType:nil]];
    for (NSDictionary *dic in [mortgageInfo objectForKey:@"LoanRate"]) {
        NSString *key = [dic objectForKey:@"RateKey"];
        [loanRates addObject:key];
    }
    return loanRates;

}
+(NSArray *)getMortgageRateArray
{
    NSMutableArray *loanRates = [[NSMutableArray alloc] init];
    if (loanRates.count != 0) {
        [loanRates removeAllObjects];
    }
    NSDictionary *mortgageInfo = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MortgageInfo.plist" ofType:nil]];
    for (NSDictionary *dic in [mortgageInfo objectForKey:@"LoanRate"]) {
        NSString *key = [dic objectForKey:@"RateKey"];
        [loanRates addObject:key];
    }
    return loanRates;
}
+(NSString *)getMortgagePercentValue:(NSString *)key
{
    NSString *value = nil;
    NSDictionary *mortgageInfo = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MortgageInfo.plist" ofType:nil]];
    for (NSDictionary *dic in [mortgageInfo objectForKey:@"Percent"]) {
        if ([key isEqualToString:[dic objectForKey:@"PercentKey"]]) {
            value = [dic objectForKey:@"PercentValue"];
            break;
        }
    }
    return value;
}
+(NSString *)getMortgageYearValue:(NSString *)key
{
    NSString *value = nil;
    NSDictionary *mortgageInfo = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MortgageInfo.plist" ofType:nil]];
    for (NSDictionary *dic in [mortgageInfo objectForKey:@"Year"]) {
        if ([key isEqualToString:[dic objectForKey:@"YearKey"]]) {
            value = [dic objectForKey:@"YearValue"];
            break;
        }
    }
    return value;
}
+(NSString *)getMortgageFundRateValue:(NSString *)key withMonthAmount:(NSInteger)amount
{
    NSString *value = nil;
    NSDictionary *mortgageInfo = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MortgageInfo.plist" ofType:nil]];
    for (NSDictionary *dic in [mortgageInfo objectForKey:@"FundRate"]) {
        if ([key isEqualToString:[dic objectForKey:@"RateKey"]]) {
            if (amount <= 60) {
                value = [dic objectForKey:@"RateLowValue"];

            }
            else{
                value = [dic objectForKey:@"RateHighValue"];

            }
            
            break;
        }
    }
    return value;
}
+(NSString *)getMortgageLoanRateValue:(NSString *)key withMonthAmount:(NSInteger)amount
{
    NSString *value = nil;
    NSDictionary *mortgageInfo = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MortgageInfo.plist" ofType:nil]];
    for (NSDictionary *dic in [mortgageInfo objectForKey:@"LoanRate"]) {
        if ([key isEqualToString:[dic objectForKey:@"RateKey"]]) {
            if (amount <= 60) {
                value = [dic objectForKey:@"RateLowValue"];
            }
            else{
                value = [dic objectForKey:@"RateHighValue"];
            }
            
            break;
        }
    }
    return value;
}
+(CGFloat)getAvgPriceByString:(NSString *)price
{
    //@"6000元以内",@"6000-7000元",@"7000-8000元",@"8000-9000元",@"9000-12000元",@"12000-15000元",@"15000元以上"
    CGFloat p = 0.0;
    if ([price isEqualToString:@"6000元以内"]) {
        p = 6000.0;
    }
    else if ([price isEqualToString:@"6000-7000元"]){
        p = 6500.0;
    }
    else if ([price isEqualToString:@"7000-8000元"]){
        p = 7500.0;
    }
    else if ([price isEqualToString:@"8000-9000元"]){
        p = 8500.0;
    }
    else if ([price isEqualToString:@"9000-12000元"]){
        p = 10500.0;
    }
    else if ([price isEqualToString:@"12000-15000元"]){
        p = 13500.0;
    }
    else{
        p = 15000.0;
    }
    return p;
}
+(NSString *)getMinPriceByString:(NSString *)price
{
    NSString *p ;
    if ([price isEqualToString:@"6000元以内"]) {
        p = @"";
    }
    else if ([price isEqualToString:@"6000-7000元"]){
        p = @"6000";
    }
    else if ([price isEqualToString:@"7000-8000元"]){
        p = @"7000";
    }
    else if ([price isEqualToString:@"8000-9000元"]){
        p = @"8000";
    }
    else if ([price isEqualToString:@"9000-12000元"]){
        p = @"9000";
    }
    else if ([price isEqualToString:@"12000-15000元"]){
        p = @"12000";
    }
    else{
        p = @"15000";
    }
    return p;
}
+(NSString *)getMaxPriceByString:(NSString *)price
{
    NSString *p ;
    if ([price isEqualToString:@"6000元以内"]) {
        p = @"6000";
    }
    else if ([price isEqualToString:@"6000-7000元"]){
        p = @"7000";
    }
    else if ([price isEqualToString:@"7000-8000元"]){
        p = @"8000";
    }
    else if ([price isEqualToString:@"8000-9000元"]){
        p = @"9000";
    }
    else if ([price isEqualToString:@"9000-12000元"]){
        p = @"12000";
    }
    else if ([price isEqualToString:@"12000-15000元"]){
        p = @"15000";
    }
    else{
        p = @"";
    }
    return p;
}
+(BOOL)compareDateA:(NSString *)dateA isLaterThanDateB:(NSString *)dateB
{
    //<Dtime>2013-10-09T16:51:32.653+08:00</Dtime>
    
    //年-月-日string
    NSString *dateStringA = [[dateA componentsSeparatedByString:@"T"] objectAtIndex:0];
    NSString *dateStringB = [[dateB componentsSeparatedByString:@"T"] objectAtIndex:0];
   
    //时-分-秒string
    NSString *timeStringA =  [[dateA componentsSeparatedByString:@"T"] objectAtIndex:1];
    NSString *timeStringB =  [[dateB componentsSeparatedByString:@"T"] objectAtIndex:1];
    
    //年-月-日array
    NSArray *aarray = [dateStringA componentsSeparatedByString:@"-"];
    NSArray *barray = [dateStringB componentsSeparatedByString:@"-"];
    //年
    NSString *ayear = [aarray objectAtIndex:0];
    NSString *byear = [barray objectAtIndex:0];
    //月
    NSString *amon = [aarray objectAtIndex:1];
    NSString *bmon = [barray objectAtIndex:1];
    //日
    NSString *aday = [aarray objectAtIndex:2];
    NSString *bday = [barray objectAtIndex:2];
    
    //时-分-秒array
    NSArray *aTimearray = [timeStringA componentsSeparatedByString:@":"];
    NSArray *bTimearray = [timeStringB componentsSeparatedByString:@":"];
    //时
    NSString *ahour = [aTimearray objectAtIndex:0];
    NSString *bhour = [bTimearray objectAtIndex:0];
    //分
    NSString *aminute = [aTimearray objectAtIndex:1];
    NSString *bminute = [bTimearray objectAtIndex:1];
    
    
    if ([ayear integerValue]>=[byear integerValue] && [amon integerValue]>=[bmon integerValue] && [aday integerValue]>=[bday integerValue] && [ahour integerValue]>= [bhour integerValue] && [aminute integerValue]>= [bminute integerValue]) {
        if ([aminute integerValue] == [bminute integerValue]) {
            return NO;
        }
        return YES;
    }
    return NO;
}
+(BOOL)compareDateIsLaterThanNowDate:(NSString *)date
{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSString *ctime = [dateformatter stringFromDate:nowDate];
    
    NSArray *carray = [ctime componentsSeparatedByString:@"-"];
    NSArray *darray = [date componentsSeparatedByString:@"-"];
    
    NSString *cyear = [carray objectAtIndex:0];
    NSString *dyear = [darray objectAtIndex:0];
    
    NSString *cmon = [carray objectAtIndex:1];
    NSString *dmon = [darray objectAtIndex:1];
   
    NSString *cday = [carray objectAtIndex:2];
    NSString *dday = [darray objectAtIndex:2];
    
    if ([dyear integerValue]>=[cyear integerValue] && [dmon integerValue]>=[cmon integerValue] && [dday integerValue]>=[cday integerValue]) {
        return YES;
    }
    return NO;
}
+(BOOL)saveImageToLocalInUrl:(NSString *)url withName:(NSString *)imageName ofType:(NSString *)extension
{
    UIImage * image;
    NSString *imgPath = [NSString stringWithFormat:@"%@%@",ImagePathURL,url];
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgPath]];
    image = [UIImage imageWithData:data];
    NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        
      return [UIImagePNGRepresentation(image) writeToFile:[documentsDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    }
    else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        
        return [UIImageJPEGRepresentation(image, 1.0) writeToFile:[documentsDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    }
    return NO;
}
+(UIImage *)loadLocalImage:(NSString *)imageName
{

    NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *imagePath = [documentsDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", imageName]];
    UIImage * image = [UIImage imageWithContentsOfFile:imagePath];
    
    return image;
}
@end
