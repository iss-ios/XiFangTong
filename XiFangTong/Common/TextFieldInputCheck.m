//
//  TextFieldInputCheck.m
//  NewGMemo
//
//  Created by you on 13-5-16.
//  Copyright (c) 2013年 YanYou. All rights reserved.
//

#import "TextFieldInputCheck.h"

@implementation TextFieldInputCheck

- (BOOL) checkTextFieldInputIsEmpty:(UITextField *)input tip:(NSString *)tipTitle error:(NSError *__autoreleasing *)error
{
    NSInteger length = input.text.length;
    if (length == 0) {
        if (error != nil)
        {
            NSString *description = NSLocalizedString(@"提示", @"");
            
            NSString *reason = NSLocalizedString(tipTitle, @"");
            
            *error = [NSError errorWithDomain:InputErrorDomain
                                         code:1001
                                     userInfo:[self errorUserInfo:description reason:reason]];
        }
        return YES;
    }
    return NO;
}

//验证邮箱合法性
- (BOOL) checkTextFieldInputIsValidateEmail:(UITextField *) input error:(NSError *__autoreleasing *) error
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL validation = [emailTest evaluateWithObject:input.text];
    if (!validation) {
        if (error != nil)
        {
            NSString *description = NSLocalizedString(@"提示", @"");
            
            NSString *reason = NSLocalizedString(@"您的邮箱名不合法！", @"");
            
            
            *error = [NSError errorWithDomain:InputErrorDomain
                                         code:1001
                                     userInfo:[self errorUserInfo:description reason:reason]];
        }
    }
    return validation;
}
-(BOOL)checkTextFieldInputIsEqualToString:(UITextField *)input string:(NSString *)string tip:(NSString *)tipTitle error:(NSError *__autoreleasing *)error
{
    BOOL equal = [input.text isEqualToString:string];
    if (!equal) {
        NSString *description = NSLocalizedString(@"提示", @"");
        
        NSString *reason = NSLocalizedString(tipTitle, @"");
        
        *error = [NSError errorWithDomain:InputErrorDomain
                                     code:1001
                                 userInfo:[self errorUserInfo:description reason:reason]];
    }
    return equal;
}

- (BOOL)checkTextFieldInputIsMobileNumber:(UITextField*)textField 
{
    /*
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:textField.text] == YES)
        || ([regextestcm evaluateWithObject:textField.text] == YES)
        || ([regextestct evaluateWithObject:textField.text] == YES)
        || ([regextestcu evaluateWithObject:textField.text] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
     */
    NSString * MOBILE = @"^1\\d{10}$";

    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];

    if ([regextestmobile evaluateWithObject:textField.text] == YES)
        
    {
        return YES;
    }
    else
    {
        return NO;
    }

}
-(NSDictionary *)errorUserInfo:(NSString *)description reason:(NSString *)reason
{
    NSArray *objArray = [NSArray arrayWithObjects:description, reason, nil];
    NSArray *keyArray = [NSArray arrayWithObjects:NSLocalizedDescriptionKey,
                         NSLocalizedFailureReasonErrorKey, nil];
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objArray
                                                         forKeys:keyArray];
    return userInfo;
}

@end
